from pyCascade import utils

import glob
import numpy as np
from matplotlib import pyplot as plt
from matplotlib import cm, colors
from itertools import repeat
import pandas as pd
import pickle

from pandarallel import pandarallel


def read_probes(filename):
    df = pd.read_csv(filename, delim_whitespace=True)  # read as dataframe
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
    n_steps = len(data_df.groupby(axis='columns', level='step').size())
    time_sum = data_df.groupby(
        axis='columns', level='name').cumsum(axis='columns')
    data_steps = pd.Series(np.arange(1, n_steps+1))

    var_cum_avg = time_sum.div(
        data_steps, axis='columns', level='step')  # cumumlative averge
    var_last_avg = var_cum_avg.groupby(axis='columns', level='name').last()
    data_diff = var_cum_avg.sub(var_last_avg, axis='columns', level='name')

    data_diff_norm = abs(data_diff.div(
        var_last_avg, axis='columns', level='name'))

    return data_diff_norm


class Probes:
    def __init__(self, directory):
        """
        File info is stored in a tuple-indexed dictionary. Once data is access, it is read in as a (nested) tuple-indexed dictionary.
        Data is indexed as self.data[(name,step)][(stack, var)]. This format mimics the multiIndex DataFrame created in
        self.slice_int_df.
        """
        my_dict = {}  # this will be a tuple indexed 1-level dictionary.
        # create a generator to iterate over probe paths
        path_generator = glob.iglob(f'{directory}/*.pcd')
        probe_names = []
        probe_steps = []

        for path in path_generator:

            file_name = path.split('/')[-1]  # get the local file name
            probe_info = file_name.split('.')
            probe_name, probe_step, _ = probe_info[:]
            probe_step = int(probe_step)

            probe_names.append(probe_name)
            probe_steps.append(probe_step)

            # store the pcd path and pcd reader function
            my_dict[(probe_name, probe_step)] = (read_probes, path)

        # iterate through the upper data dict
        my_dict = utils.MyLazyDict(my_dict)  # modify the getter lazily read in data

        self.probe_names = [*set(probe_names)]  # remove duplicates
        # remove duplicates and sort
        self.probe_steps = [*set(probe_steps)]

        # assume the vars and stack is the same for all probes
        representative_dict = my_dict[(
            self.probe_names[0], self.probe_steps[0])]
        representative_dict_keys = list(
            zip(*representative_dict.keys()))  # unzip list of tuples
        # sort and remove duplicates
        self.probe_vars = [*set(representative_dict_keys[1])]
        # sort and remove duplicates
        self.probe_stack = [*set(representative_dict_keys[0])]
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
        names = None,
        steps = None,
        parallel = False
    ):

        # if empty, use all probes
        names = utils.get_input(names, self.probe_names, overwrite = False)
        # if empty, use all steps
        steps = utils.get_input(steps, self.probe_steps, overwrite = False)

        # turn outer dict into series for vectorzed opperations
        mi_series = pd.Series(self.data)
        # get desired values
        mi_series_sliced = mi_series.loc[names, steps]

        st = utils.start_timer()

        # dont use parrall for debugging, else significant speed up
        if parallel:
            # initialize(36) or initialize(os.cpu_count()-1)
            pandarallel.initialize(progress_bar=True)
            # read in data directly (not indecing self.data)
            mi_df = mi_series_sliced.parallel_apply(parallel_functions)
        else:
            mi_df = mi_series_sliced.apply(parallel_functions)

        mi_df = mi_df.T

        mi_df.index.rename(['stack', 'var'], inplace=True)
        mi_df.columns.rename(['name', 'step'], inplace=True)

        utils.end_timer(st, "reading data")

        st = utils.start_timer()

        # memorize data that was accesed outside of self.data
        self.data.update(mi_df)  # update data dictionary

        utils.end_timer(st, "memorizing data")

        return mi_df  # return numpy array with all requested data

    def contour_plots(
        self,
        names = None,
        steps = None,
        vars = None,
        stack = None,
        parrallel = False,
        processing = None,
        plot_params={}
    ):

        vars = utils.get_input(vars, self.probe_vars, overwrite = False)
        stack = utils.get_input(stack, np.s_[::], overwrite = False)
        names = utils.get_input(names, self.probe_names, overwrite = False)
        steps = utils.get_input(steps, self.probe_steps, overwrite = False)

        data = self.slice_into_df(names, steps, parrallel)
        data = data.loc[(stack,vars),:]
        n_names = len(names)
        n_vars = len(vars)


        if processing is None:
            processed_data = data
        else:
            st = utils.start_timer()
            for process_step in processing:
                processed_data = process_step(data)
            utils.end_timer(st, 'processing data')

        st = utils.start_timer()

        # plt.rcParams['text.usetex'] = True
        fig, ax = plt.subplots(n_names, n_vars)

        for j, (var, var_df) in enumerate(processed_data.groupby(axis='index', level='var')):
            if 'plot_levels' in plot_params and var in plot_params['plot_levels']:
                plot_levels = plot_params['plot_levels'][var]
            else:
                plot_levels = 256

            ax_list = []
            im_list = []
            vmins = [] # for colorbar
            vmaxs = []
            for i, (name, name_df) in enumerate(var_df.groupby(axis='columns', level='name')):
                plot_df = name_df.droplevel('var', axis='index')
                plot_df = plot_df.droplevel('name', axis='columns')
                sub_ax = utils.ax_index(ax, i, j)
                
                xPlot = plot_df.columns
                if 'horizontal spacing' in plot_params:
                    xPlot *= plot_params['horizontal spacing']
                yPlot = plot_df.index
                if hasattr(self, 'locations') and 'stack span' in plot_params:
                    location = self.locations[name]
                    yAxis = location[plot_params['stack span']]
                    yPlot = yAxis[yPlot]

                im = sub_ax.contourf(xPlot, yPlot, name_df, levels=plot_levels)
                ax_list.append(sub_ax)
                im_list.append(im)

                if j > 0:
                    sub_ax.yaxis.set_visible(False)
                else:
                    sub_ax.set_ylabel(name)
                if i < n_names-1:
                    sub_ax.xaxis.set_visible(False)
                else:
                    sub_ax.set_xlabel(var)

                clims = im.get_clim()
                vmins.append(clims[0])
                vmaxs.append(clims[1])
                # fig.colorbar(im, ax = sub_ax)

            # norm = colors.DivergingNorm(0,min(vmins),max(vmaxs))
            sm = cm.ScalarMappable()
            for im in im_list:
                im.set_clim(min(vmins), max(vmaxs))
            sm.set_clim(min(vmins), max(vmaxs))
            fig.colorbar(sm, ax=ax_list)
        utils.end_timer(st, "plotting")
        # plt.figure()
        # plt.contourf(xPlot, yPlot, plot_data, plot_levels = plot_params['plot_levels'])
        # fig.show()

        return fig, ax
