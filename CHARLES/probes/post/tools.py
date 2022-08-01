import pandas as pd
import glob
import numpy as np
from matplotlib import pyplot as plt
from sklearn.inspection import plot_partial_dependence

def read_probes(filename):
    return pd.read_csv(filename, delim_whitespace=True)

def read_locations(filename):
    return pd.read_csv(filename, delim_whitespace=True, skiprows=1, names=['x','y','z'])

class MyLazyDict(dict):
    '''
    Create a lazy dictionary by modifying the __getitem__ attribute. New dictionary dynamically reads in data as it is accessed,
    and memorizes data once it has been read in.
    '''
    def __getitem__(self, item):
        value=dict.__getitem__(self, item) # retrieve the current dictionary value
        if not isinstance(value, pd.core.frame.DataFrame): # check if data has been read in
            # print('reading in data')
            function, arg = value # retrieve data reading function and data path
            value = function(arg) # read in the data, and assign it to the dict value
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
        self.data = my_dict

    def get_locations(self, dir_locations):
        locations = {}
        for probe_name in self.probe_names:
            location_path = f"{dir_locations}/{probe_name}.txt"
            locations[probe_name] = (read_locations, location_path) # preparing for lazy location reading
        self.locations = MyLazyDict(locations) # creating lazy dict for locations


    def slice_into_np(
        self,
        slice_params = {}
        ):

        if 'names' not in slice_params:
            slice_params['names'] = self.probe_names # if empty, use all probes
        if 'numbers' not in slice_params:
            slice_params['numbers'] = self.probe_numbers# if empty, use all numbers

        names_list = []
        check_vars = True
        for name in slice_params['names']:
            name_dict = self.data[name]
            numbers_list = []
            for number in slice_params['numbers']:
                df = name_dict[number]
                if check_vars:
                    self.probe_vars = df.keys()
                    self.probe_stack  = df.index
                    if 'vars' not in  slice_params:
                        slice_params['vars'] = self.probe_vars
                    if 'stack' not in slice_params:
                        slice_params['stack'] = self.probe_stack
                    check_vars = False
                df = df[slice_params['vars']]
                np_array = df.to_numpy()
                np_array_select_probes = np_array[slice_params['stack']]
                numbers_list.append(np_array_select_probes) # get df from data dictionary and convert to np array
            names_list.append(numbers_list) # create nested lists of names[numbers]

        np_data = np.asarray(names_list)

        if 'ordering' in slice_params:
            np_data = np_data.transpose(slice_params['ordering'])

        return np_data, slice_params # return numpy array with all requested data

    
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

        data = data[0,...] #just looking at u,0 for now
        var_cum_avg = np.cumsum(data, axis = -1) / np.arange(1,n_numbers+1) # cumumlative averge
        data_diff = abs((var_cum_avg - var_cum_avg[...,[-1]])/var_cum_avg[...,[-1]])
        plot_data = data_diff.reshape((-1, n_numbers), order = 'C')

        yPlot = np.tile(slice_params['stack'], n_names)
        xPlot = slice_params['numbers']

        # plotting params
        self.plot_params.update(plot_params)
        if 'levels' not in self.plot_params:
            plot_params['levels'] = 200

        plt.figure()
        plt.contourf(xPlot, yPlot, plot_data, levels = plot_params['levels'])
        plt.colorbar()
        plt.show(block=True)









    

        




