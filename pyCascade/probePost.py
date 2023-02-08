from pyCascade import utils

import glob
import numpy as np
from matplotlib import pyplot as plt
from matplotlib import cm, colors
import pandas as pd
import pickle
from pyarrow import csv, cpu_count, set_cpu_count

from pandarallel import pandarallel


def read_pointcloud_probes(filename):
    df = pd.read_csv(filename, delim_whitespace=True)  # read as dataframe
    return df.stack().to_dict()  # save as tuple indexed dictionary

def skip_comment(row):
    if row.text.startswith("# "):
        return 'skip'
    else:
        return 'error'

def read_probes(filename):
    print(f"Pyarrow reading PROBE file on {cpu_count()} threads")
    read_options = csv.ReadOptions(skip_rows = 5, autogenerate_column_names = True, use_threads = True)
    parse_options = csv.ParseOptions(delimiter=" ", invalid_row_handler=skip_comment)
    pyarrow_table = csv.read_csv(filename, read_options, parse_options)
    df = pyarrow_table.to_pandas()
    df = df.transpose()
    new_header = df.iloc[1] #grab the second row for the header
    df = df[3:].reset_index(drop=True) #take the data less the header row
    df.columns = new_header #set the header row as the df header
    return df.stack().to_dict()  # save as tuple indexed dictionary


def read_locations(filename):
    return pd.read_csv(filename, delim_whitespace=True, skiprows=1, names=['x', 'y', 'z'])


def parallel_functions(value):
    """
    Function to read in data directly instead of accessing it through indexing the lazy dictionary. 
    This speeds up parrallel processing because less infromation is passed to subprocesses.
    """
    return pd.Series(utils.eval_tuple(value))

def mean_convergence(data_df):
    # n_steps = len(data_df.groupby(axis='columns', level='step').size())
    time_sum = data_df.groupby(
        axis='columns', level='name').cumsum(axis='columns')
    # data_steps = pd.Series(np.arange(1, n_steps+1))
    data_df_index = list(zip(*data_df.keys()))  # unzip list of tuples
    data_steps = [*set(data_df_index[1])] # sort and remove duplicates
    n_names = len([*set(data_df_index[0])])

    quant_cum_avg = time_sum.div(
        np.tile(data_steps, n_names), axis='columns', level='step')  # cumumlative averge
    quant_last_avg = quant_cum_avg.groupby(axis='columns', level='name').last()
    data_diff = quant_cum_avg.sub(quant_last_avg, axis='columns', level='name')

    data_diff_norm = abs(data_diff.div(
        quant_last_avg, axis='columns', level='name'))

    return data_diff_norm

def time_average(data_df):
    return data_df.groupby(axis='columns', level='name').mean()

def time_rms(data_df):
    mean = time_average(data_df)
    norm_data = data_df.sub(mean, axis='columns', level='name')
    diff_squared = norm_data**2
    return time_average(diff_squared)


def ClenshawCurtis_Quadrature(data_df):
    N = 10
    interval = 2.5
    xs = [np.cos((2*(N-k)-1)*np.pi/(2*N)) for k in range(N)]
    A = np.array([[xs[i]**j for i in range(N)] for j in range(N)])
    b = [(1+(-1)**k)/(k+1) for k in range(N)]
    ws = np.linalg.solve(A,b)
    CC_weights = np.squeeze(ws[:,None])

    ## correcting for inforrect probes locations untill R10
    Warning('Quadrature weights shifted to match R<=10. Delete this in the future')
    CC_weights = np.roll(CC_weights, 1)
    #############

    Quad_weights = np.tile(CC_weights, 10) * np.repeat(CC_weights, 10) * (interval/2)**2
    Quad_weights = Quad_weights[..., np.newaxis]
    wighted_data = data_df.groupby(axis='index', level='quant').apply(lambda x: x*Quad_weights)
    integrated_data = wighted_data.groupby(axis='index', level='quant').sum()

    return integrated_data

# use to define lambda function with mul preset
def mul_names(data_df, names, mul):
    data_df = data_df.T
    sliced_data = data_df.loc[names]
    sliced_data*=mul
    data_df.update(sliced_data)
    return data_df.T



class Probes(utils.Helper):
    def __init__(self, directory, probe_type = "PROBES"):
        """
        File info is stored in a tuple-indexed dictionary. Once data is access, it is read in as a (nested) tuple-indexed dictionary.
        For POINTCLOUD_PROBES data is indexed as self.data[(name,step)][(stack, quant)]. For PROBES data is indexed as 
        self.data[(name, quant)][(stack, step)]. This format mimics the multiIndex DataFrame created in self.slice_into_df.
        """

        self.probe_type = probe_type

        my_dict = {}  # this will be a tuple indexed 1-level dictionary.
        # create a generator to iterate over probe paths
        path_generator = glob.iglob(f'{directory}/*.*')
        probe_names = []
        probe_tbd1s = []

        for path in path_generator:

            if self.probe_type == "POINTCLOUD_PROBES":
                if ".pcb" not in path:
                    continue
                file_name = path.split('/')[-1]  # get the local file name
                probe_info = file_name.split('.')
                probe_name, probe_tbd1, _ = probe_info[:]
                probe_tbd1 = int(probe_tbd1)
                # store the pcd path and pcd reader function
                my_dict[(probe_name, probe_tbd1)] = (read_pointcloud_probes, path)
            elif self.probe_type == "PROBES":
                if "README" in path:
                    continue
                file_name = path.split('/')[-1]  # get the local file name
                probe_info = file_name.split('.')
                probe_name, probe_tbd1 = probe_info[:]
                # store the pcd path and pcd reader function
                my_dict[(probe_name, probe_tbd1)] = (read_probes, path)

            probe_names.append(probe_name)
            probe_tbd1s.append(probe_tbd1)

        # iterate through the upper data dict
        my_dict = utils.MyLazyDict(my_dict)  # modify the getter lazily read in data

        self.probe_names = [*set(probe_names)]  # remove duplicates
        # remove duplicates and sort
        probe_tbd1s = [*set(probe_tbd1s)]

        # get the all quants and (max) stack across all probes
        probe_tbd2s = ()
        probe_stack = ()
        for name in self.probe_names:
            representative_dict = my_dict[(
                name, probe_tbd1s[0])]
            representative_dict_keys = list(
                zip(*representative_dict.keys()))  # unzip list of tuples
            # sort and remove duplicates
            probe_tbd2s += representative_dict_keys[1]
            # sort and remove duplicates
            probe_stack += representative_dict_keys[0]
            if self.probe_type == "PROBES":
                break
        # sort and remove duplicates
        probe_tbd2s = [*set(probe_tbd2s)]
        # sort and remove duplicates
        self.probe_stack = [*set(probe_stack)]
        if self.probe_type == "POINTCLOUD_PROBE":
            self.probe_steps = probe_tbd1s
            self.probe_quants = probe_tbd2s
        elif self.probe_type == "PROBES":
            self.probe_steps = probe_tbd2s
            self.probe_quants = probe_tbd1s

        self.data = my_dict
        

    def get_locations(self, dir_locations):
        locations = {}
        for probe_name in self.probe_names:
            location_path = f"{dir_locations}/{probe_name}.txt"
            # preparing for lazy location reading
            locations[probe_name] = (read_locations, location_path)
        # creating lazy dict for locations
        self.locations = utils.MyLazyDict(locations)

    def slice_into_df(
        self,
        names = "self.probe_names",
        steps = "self.probe_steps",
        quants = "self.probe_quants",
        parallel = False
    ):
        # default to all probes, setps/quants
        names, steps, quants = [self.get_input(input) for input in [names, steps, quants]]
        if self.probe_type == "POINTCLOULD_PROBES":
            second_ind = steps
        elif self.probe_type == "PROBES":
            second_ind = quants

        # turn outer dict into series for vectorzed opperations
        mi_series = pd.Series(self.data)
        # sort for improved speed
        mi_series.sort_index(inplace=True)
        # get desired values, temporarily converting from multiindex to dataframe for .loc speed increase
        st = utils.start_timer()
        df_from_mi_series = mi_series.unstack()
        df_sliced = df_from_mi_series.loc[names, second_ind]
        df_sliced = pd.DataFrame(df_sliced) #in case the slice becomes a series
        mi_series_sliced = df_sliced.stack()
        utils.end_timer(st, "slicing")

        st = utils.start_timer()

        # dont use parrall for debugging, else significant speed up
        if parallel and self.probe_type == "POINTCLOUD_PROBES":
            # initialize(36) or initialize(os.cpu_count()-1)
            pandarallel.initialize(progress_bar=True)
            # read in data directly (not indecing self.data)
            mi_df = mi_series_sliced.parallel_apply(parallel_functions)
        else:
            mi_df = mi_series_sliced.apply(parallel_functions)

        mi_df = mi_df.T
        if self.probe_type == 'PROBES':
            mi_df = mi_df.unstack().stack(level=-2)#.swaplevel(axis=0)

        mi_df.index.rename(['stack', 'quant'], inplace=True)
        if isinstance(mi_df, pd.DataFrame):
            mi_df.columns.rename(['name', 'step'], inplace=True)

        utils.end_timer(st, "reading data")

        st = utils.start_timer()

        # memorize data that was accesed outside of self.data
        self.data.update(mi_df)  # update data dictionary

        utils.end_timer(st, "memorizing data")

        return mi_df  # return numpy array with all requested data

    def contour_plots(
        self,
        names = "self.probe_names",
        steps = "self.probe_steps",
        quants = "self.probe_quants",
        stack = "self.probe_stack",
        parrallel = False,
        processing = None,
        plot_params={}
    ):

        quants, stack, names, steps = [self.get_input(input) for input in [quants, stack, names, steps]]

        data = self.slice_into_df(names, steps, quants, parrallel)
        data = data.loc[(stack,quants),:]
        n_names = len(names)
        n_quants = len(quants)

        processed_data = data
        if processing is not None:
            st = utils.start_timer()
            for process_step in processing:
                processed_data = process_step(processed_data)
            utils.end_timer(st, 'processing data')

        st = utils.start_timer()

        # plt.rcParams['text.usetex'] = True
        fig, ax = plt.subplots(n_names, n_quants, constrained_layout =True)

        for j, (quant, quant_df) in enumerate(processed_data.groupby(axis='index', level='quant')):
            if 'plot_levels' in plot_params and quant in plot_params['plot_levels']:
                plot_levels = plot_params['plot_levels'][quant]
            else:
                plot_levels = 256

            ax_list = []
            im_list = []
            vmins = [] # for colorbar
            vmaxs = []
            for i, (name, name_df) in enumerate(quant_df.groupby(axis='columns', level='name')):
                plot_df = name_df.droplevel('quant', axis='index')
                plot_df = plot_df.droplevel('name', axis='columns')
                plot_df = plot_df.dropna()
                sub_ax = utils.ax_index(ax, i, j)
                
                xPlot = plot_df.columns
                if 'horizontal spacing' in plot_params:
                    xPlot *= plot_params['horizontal spacing']
                yPlot = plot_df.index
                if hasattr(self, 'locations') and 'stack span' in plot_params:
                    location = self.locations[name]
                    yAxis = location[plot_params['stack span']]
                    yPlot = yAxis[yPlot]

                if 'veritcal scaling' in plot_params:
                   yPlot*=plot_params['veritcal scaling']

                if 'plot_every' in plot_params:  # usefull to plot subset of timesteps but run calcs across all timesteps
                    name_df = plot_df.iloc[:,::plot_params['plot_every']]
                    xPlot =xPlot[::plot_params['plot_every']]

                im = sub_ax.contourf(xPlot, yPlot, plot_df, levels=plot_levels)
                ax_list.append(sub_ax)
                im_list.append(im)

                if j > 0:
                    sub_ax.yaxis.set_visible(False)
                else:
                    sub_ax.set_ylabel(name)
                if i < n_names-1:
                    sub_ax.xaxis.set_visible(False)
                else:
                    sub_ax.set_xlabel(quant)

                vmin, vmax = im.get_clim()
                vmins.append(vmin)
                vmaxs.append(vmax)
                # fig.colorbar(im, ax = sub_ax)

            vmin = min(vmins)
            vmax = max(vmaxs)
            if 'ColorNorm' in plot_params:
                if plot_params['ColorNorm'] == "TwoSlope":
                    norm = colors.TwoSlopeNorm(0,vmin,vmax)
                elif plot_params['ColorNorm'] == "Centered":
                    vmagmax = max(np.abs((vmin, vmax)))
                    norm = colors.TwoSlopeNorm(0,-vmagmax,vmagmax)

            else:
                norm = colors.Normalize(vmin,vmax)
            for im in im_list:
                im.set_norm(norm)
            fig.colorbar(cm.ScalarMappable(norm=norm), ax=ax_list)
        
        if 'xlabel' in plot_params:
            fig.supxlabel(plot_params['xlabel'])
        if 'ylabel' in plot_params:
            fig.supylabel(plot_params['ylabel'])
        utils.end_timer(st, "plotting")
        # plt.figure()
        # plt.contourf(xPlot, yPlot, plot_data, plot_levels = plot_params['plot_levels'])
        # fig.show()

        return fig, ax

    def profile_plots(
        self,
        names = "self.probe_names",
        steps = "self.probe_steps",
        quants = "self.probe_quants",
        stack = "np.s_[::]",
        processing = None,
        parrallel = False,
        plot_params = {}
        ):

        quants, stack, names, steps = [self.get_input(input) for input in [quants, stack, names, steps]]
        data = self.slice_into_df(names, steps,quants, parrallel)
        data = data.loc[(stack,quants),:]

        processed_data = data
        if processing is not None:
            st = utils.start_timer()
            for process_step in processing:
                processed_data = process_step(processed_data)
            utils.end_timer(st, 'processing data')

        fig, ax = plt.subplots(1, 1, constrained_layout =True)
        for j, (quant, quant_df) in enumerate(processed_data.groupby(axis='index', level='quant')):
            for i, (name, name_df) in enumerate(quant_df.groupby(axis='columns', level='name')):
                plot_df = name_df.droplevel('quant', axis='index')
                plot_df = plot_df.dropna()
                # if isinstance(plot_df, pd.DataFrame):
                #     plot_df = plot_df.droplevel('name', axis='columns')

                yPlot = plot_df.index
                if hasattr(self, 'locations') and 'stack span' in plot_params:
                    location = self.locations[name]
                    yAxis = location[plot_params['stack span']]
                    yPlot = yAxis[yPlot]

                if 'veritcal scaling' in plot_params:
                   yPlot*=plot_params['veritcal scaling']

                ax.plot(plot_df.values, yPlot, label=f'{name}: {quant}')
                if 'xlabel' in plot_params:
                    fig.supxlabel(plot_params['xlabel'])
                if 'ylabel' in plot_params:
                    fig.supylabel(plot_params['ylabel'])
                ax.legend()

    
    
    def time_plots(
        self,
        names = "self.probe_names",
        steps = "self.probe_steps",
        quants = "self.probe_quants",
        stack = "np.s_[::]",
        parrallel = False,
        processing = None,
        plot_params={}
    ):

        quants, stack, names, steps = [self.get_input(input) for input in [quants, stack, names, steps]]

        data = self.slice_into_df(names, steps, parrallel)
        data = data.loc[(stack,quants),:]
        n_names = len(names)
        n_quants = len(quants)

        processed_data = data
        if processing is not None:
            st = utils.start_timer()
            for process_step in processing:
                processed_data = process_step(processed_data)
            utils.end_timer(st, 'processing data')

        st = utils.start_timer()

        # plt.rcParams['text.usetex'] = True
        fig, ax = plt.subplots(1, 1, constrained_layout =True)

        for j, (quant, quant_df) in enumerate(processed_data.groupby(axis='index', level='quant')):
            for i, (name, name_df) in enumerate(quant_df.groupby(axis='columns', level='name')):
                plot_df = name_df.droplevel('name', axis='columns')
                plot_df = plot_df.dropna()
                
                xPlot = plot_df.columns
                if 'horizontal spacing' in plot_params:
                    xPlot *= plot_params['horizontal spacing']

                if 'plot_every' in plot_params:  # usefull to plot subset of timesteps but run calcs across all timesteps
                    name_df = plot_df.iloc[:,::plot_params['plot_every']]
                    xPlot =xPlot[::plot_params['plot_every']]

                yPlot =  np.squeeze(plot_df.values)
                if 'veritcal scaling' in plot_params:
                   yPlot*=plot_params['veritcal scaling']

                ax.plot(xPlot, yPlot, label=f'{name}: {quant}')
                if 'xlabel' in plot_params:
                    fig.supxlabel(plot_params['xlabel'])
                if 'ylabel' in plot_params:
                    fig.supylabel(plot_params['ylabel'])
                ax.legend()
        

        return fig, ax

    def statistics(
        self,
        names = "self.probe_names",
        steps = "self.probe_steps",
        quants = "self.probe_quants",
        stack = "np.s_[::]",
        parrallel = False,
        processing = None,
        plot_params={}
    ):

        quants, stack, names, steps = [self.get_input(input) for input in [quants, stack, names, steps]]

        data = self.slice_into_df(names, steps, parrallel)
        data = data.loc[(stack,quants),:]
        n_names = len(names)
        n_quants = len(quants)

        processed_data = data
        if processing is not None:
            st = utils.start_timer()
            for process_step in processing:
                processed_data = process_step(processed_data)
            utils.end_timer(st, 'processing data')

        st = utils.start_timer()

        return processed_data


