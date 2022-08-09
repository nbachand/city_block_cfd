import glob
import numpy as np
from matplotlib import pyplot as plt
import time
from itertools import repeat
import pandas as pd
import pickle

from pandarallel import pandarallel

def read_probes(filename):
    return pd.read_csv(filename, delim_whitespace=True)

def read_locations(filename):
    return pd.read_csv(filename, delim_whitespace=True, skiprows=1, names=['x','y','z'])

def ax_index(ax,i,j):
    n_dims = np.array(ax).ndim
    if n_dims == 0:
        sub_ax = ax
    elif n_dims == 1:
        sub_ax = ax[max(i,j)]
    else:
        sub_ax = ax[i,j]
    return sub_ax

def eval_tuple(value):
    if not isinstance(value, pd.core.frame.DataFrame):
        function, arg = value # retrieve data reading function and data path
        value = function(arg)
    return value # read in the data, and assign it to the dict value

def parallel_functions(value):
    return pd.DataFrame.stack(eval_tuple(value))



class MyLazyDict(dict):
    '''
    Create a lazy dictionary by modifying the __getitem__ attribute. New dictionary dynamically reads in data as it is accessed,
    and memorizes data once it has been read in.
    '''
    def __getitem__(self, item):
        value=dict.__getitem__(self, item) # retrieve the current dictionary value
        if not isinstance(value, pd.core.frame.DataFrame): # check if data has been read in
            # print('reading in data')
            value = eval_tuple(value)
            dict.__setitem__(self, item, value) # reset the dictionary value to the data
        return value

class Probes:
    def __init__(self, directory):

        self.LES_params = {}
        self.plot_params = {}
        
        my_dict= {}
        path_generator = glob.iglob(f'{directory}/*.pcd') # create a generator to iterate over probe paths
        self.probe_names = []
        self.probe_numbers = None

        for path in path_generator:

            file_name = path.split('/')[-1] # get the local file name
            probe_info = file_name.split('.')
            probe_name, probe_number, _ = probe_info[:]
            probe_number = int(probe_number)

            if probe_name not in my_dict.keys():
                my_dict[probe_name] = {} # create a dictionary for each probe name if it does not exist
                self.probe_names.append(probe_name)

            my_dict[probe_name][probe_number] = (read_probes, path) # store the pcd path and pcd reader function

        #iterate through the upper data dict
        for probe_name, name_dict in my_dict.items():
            my_dict[probe_name] = MyLazyDict(name_dict) # modify the getter or the lower-level dicts to lazily read in data
            if not self.probe_numbers:
                self.probe_numbers = list(name_dict.keys())
                self.probe_numbers.sort()
                representative_dict = my_dict[probe_name][self.probe_numbers[0]]
                self.probe_vars = representative_dict.keys()
                self.probe_stack = representative_dict.index
        self.data = my_dict

    def get_locations(self, dir_locations):
        locations = {}
        for probe_name in self.probe_names:
            location_path = f"{dir_locations}/{probe_name}.txt"
            locations[probe_name] = (read_locations, location_path) # preparing for lazy location reading
        self.locations = MyLazyDict(locations) # creating lazy dict for locations


    def slice_into_df(
        self,
        slice_params = {}
        ):



        if 'names' not in slice_params:
            slice_params['names'] = self.probe_names # if empty, use all probes
        if 'numbers' not in slice_params:
            slice_params['numbers'] = self.probe_numbers# if empty, use all numbers
        if 'vars' not in  slice_params:
            slice_params['vars'] = self.probe_vars
        if 'stack' not in slice_params:
            slice_params['stack'] = self.probe_stack

        mi_series = pd.DataFrame.from_dict(self.data, orient="index").stack()
        mi_series_sliced = mi_series.loc[slice_params['names'],slice_params['numbers']]

        st = time.time()

        if 'parallel' in slice_params and slice_params['parallel'] is True:
            pandarallel.initialize(progress_bar=True) # initialize(36) or initialize(os.cpu_count()-1)
            mi_df = mi_series_sliced.parallel_apply(parallel_functions)
        else:
            mi_df = mi_series_sliced.apply(parallel_functions)

        mi_df = mi_df.swaplevel(axis = 'columns')

        et = time.time()
        elapsed_time = et - st
        print(f"reading data took {elapsed_time} seconds")

        return mi_df # return numpy array with all requested data

    
    def mattia_plot(
        self, 
        slice_params = {},
        LES_params = {},
        plot_params = {}
        ):
        
        # LES params
        self.LES_params.update(LES_params)

        uStar = self.LES_params['uStar']
        z0 = self.LES_params['z0']
        # deltas = self.LES_parmas['deltas']

        Uref = uStar/0.41*np.log(1.975/z0)
        q = 0.5*1.225*Uref**2

        self.LES_params.update({
            'Uref' : Uref,
            'q' : q
        })

        slice_params['ordering'] = (3,0,2,1) # set dim order to var, names, stack, numbers

        data, slice_params = self.slice_into_np(slice_params)
        n_names = len(slice_params['names'])
        n_numbers = len(slice_params['numbers'])
        n_vars = len(slice_params['vars'])

        var_cum_avg = np.cumsum(data, axis = -1) / np.arange(1,n_numbers+1) # cumumlative averge
        data_diff = abs((var_cum_avg - var_cum_avg[...,[-1]])/var_cum_avg[...,[-1]])

        # data_diff = data_diff[0,...] #just looking at u,0 for now
        # plot_data = data_diff.reshape((-1, n_numbers), order = 'C')

        yPlot = np.tile(slice_params['stack'], 1)
        xPlot = slice_params['numbers']

        self.plot_params.update(plot_params)

        fig, ax = plt.subplots(n_names, n_vars)

        for i, var in enumerate(slice_params['vars']):
            ax_list = []
            if 'levels' in self.plot_params and var in plot_params['levels']:
                levels = plot_params['levels'][var]
            else:
                levels = np.linspace(0,.5,200)
            
            for j, name in enumerate(slice_params['names']):
                plot_data = data_diff[i,j,...]
                sub_ax = ax_index(ax,j,i)
                im = sub_ax.contourf(xPlot, yPlot, plot_data, levels = levels)
                ax_list.append(sub_ax)

                if i > 0:
                    sub_ax.yaxis.set_visible(False)
                else:
                    sub_ax.set_ylabel(name)
                if j < n_names-1:
                    sub_ax.xaxis.set_visible(False)
                else:
                    sub_ax.set_xlabel(var)
            
            fig.colorbar(im, ax = ax_list)

           


        # plt.figure()
        # plt.contourf(xPlot, yPlot, plot_data, levels = plot_params['levels'])
        # fig.show()









    

        




