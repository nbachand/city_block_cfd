import glob
import numpy as np
from matplotlib import pyplot as plt
import time
from itertools import repeat
import pandas as pd
import pickle

from pandarallel import pandarallel


def read_probes(filename):
    df = pd.read_csv(filename, delim_whitespace=True)  # read as dataframe
    return df.stack().to_dict()  # save as tuple indexed dictionary


def read_locations(filename):
    return pd.read_csv(filename, delim_whitespace=True, skiprows=1, names=['x', 'y', 'z'])


def ax_index(ax, i, j):
    n_dims = np.array(ax).ndim
    if n_dims == 0:
        sub_ax = ax
    elif n_dims == 1:
        sub_ax = ax[max(i, j)]
    else:
        sub_ax = ax[i, j]
    return sub_ax


def eval_tuple(value):
    if isinstance(value, tuple):
        function, arg = value  # retrieve data reading function and data path
        # read in the data, and assign it to the dict value
        value = function(arg)
    return value


def parallel_functions(value):
    """ 
    Function to read in data directly instead of accessing it through indexing the lazy dictionary. 
    This speeds up parrallel processing because less infromation is passed to subprocesses.
    """
    return pd.Series(eval_tuple(value))

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

def end_timer(st, description):
    et = time.time()
    elapsed_time = round(et - st)
    print(f"{description} took {elapsed_time} seconds")


class MyLazyDict(dict):
    '''
    Create a lazy dictionary by modifying the __getitem__ attribute. New dictionary dynamically reads in data as it is accessed,
    and memorizes data once it has been read in.
    '''

    def __getitem__(self, item):
        # retrieve the current dictionary value
        value = dict.__getitem__(self, item)
        if isinstance(value, tuple):  # check if data has been read in
            # print('reading in data')
            value = eval_tuple(value)
            # reset the dictionary value to the data
            dict.__setitem__(self, item, value)
        return value


class Probes:
    def __init__(self, directory):
        """
        File info is stored in a tuple-indexed dictionary. Once data is access, it is read in as a (nested) tuple-indexed dictionary.
        Data is indexed as self.data[(name,step)][(stack, var)]. This format mimics the multiIndex DataFrame created in
        self.slice_int_df.
        """

        self.LES_params = {}
        self.plot_params = {}

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
        my_dict = MyLazyDict(my_dict)  # modify the getter lazily read in data

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
        self.locations = MyLazyDict(locations)

    def slice_into_df(
        self,
        slice_params={}
    ):

        if 'names' not in slice_params:
            # if empty, use all probes
            slice_params['names'] = self.probe_names
        if 'steps' not in slice_params:
            # if empty, use all steps
            slice_params['steps'] = self.probe_steps

        # turn outer dict into series for vectorzed opperations
        mi_series = pd.Series(self.data)
        # get desired values
        mi_series_sliced = mi_series.loc[slice_params['names'],
                                         slice_params['steps']]

        st = time.time()

        # dont use parrall for debugging, else significant speed up
        if 'parallel' in slice_params and slice_params['parallel'] is True:
            # initialize(36) or initialize(os.cpu_count()-1)
            pandarallel.initialize(progress_bar=True)
            # read in data directly (not indecing self.data)
            mi_df = mi_series_sliced.parallel_apply(parallel_functions)
        else:
            mi_df = mi_series_sliced.apply(parallel_functions)

        mi_df = mi_df.T

        mi_df.index.rename(['stack', 'var'], inplace=True)
        mi_df.columns.rename(['name', 'step'], inplace=True)

        end_timer(st, "reading data")

        st = time.time()

        # memorize data that was accesed outside of self.data
        self.data.update(mi_df)  # update data dictionary

        end_timer(st, "memorizing data")

        return mi_df  # return numpy array with all requested data

    def set_LES_params(
        self,
        LES_params={}
    ):

    # LES params
        self.LES_params.update(LES_params)

        uStar = self.LES_params['uStar']
        z0 = self.LES_params['z0']
        # deltas = self.LES_parmas['deltas']

        Uref = uStar/0.41*np.log(1.975/z0)
        q = 0.5*1.225*Uref**2

        self.LES_params.update({
            'Uref': Uref,
            'q': q
        })

    def contour_plots(
        self,
        slice_params={},
        plot_params={}
    ):

        if 'vars' not in slice_params:
            slice_params['vars'] = self.probe_vars
        if 'stack' not in slice_params:
            slice_params['stack'] = self.probe_stack

        data = self.slice_into_df(slice_params)
        n_names = len(slice_params['names'])
        n_vars = len(slice_params['vars'])

        if 'processing' not in plot_params:
            processed_data = data
        else:
            st = time.time()
            for process_step in plot_params['processing']:
                processed_data = process_step(data)
            end_timer(st, 'processing data')

        st = time.time()

        self.plot_params.update(plot_params)

        fig, ax = plt.subplots(n_names, n_vars)

        for j, (var, var_df) in enumerate(processed_data.groupby(axis='index', level='var')):
            ax_list = []
            if 'plot_levels' in self.plot_params and var in plot_params['plot_levels']:
                plot_levels = plot_params['plot_levels'][var]
            else:
                plot_levels = 200

            for i, (name, name_df) in enumerate(var_df.groupby(axis='columns', level='name')):
                plot_df = name_df.droplevel('var', axis='index')
                plot_df = plot_df.droplevel('name', axis='columns')
                sub_ax = ax_index(ax, i, j)
                im = sub_ax.contourf(plot_df.columns, plot_df.index, name_df, levels=plot_levels)
                ax_list.append(sub_ax)

                if j > 0:
                    sub_ax.yaxis.set_visible(False)
                else:
                    sub_ax.set_ylabel(name)
                if i < n_names-1:
                    sub_ax.xaxis.set_visible(False)
                else:
                    sub_ax.set_xlabel(var)

            fig.colorbar(im, ax=ax_list)
        end_timer(st, "plotting")
        # plt.figure()
        # plt.contourf(xPlot, yPlot, plot_data, plot_levels = plot_params['plot_levels'])
        # fig.show()

        return fig, ax
