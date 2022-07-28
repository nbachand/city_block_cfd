import pandas as pd
import glob
import numpy as np

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


    def slice_into_np(self, get_names = [], get_numbers = [], get_vars = [], get_probes = np.s_[::]):
        if not get_names:
            get_names = self.probe_names # if empty, use all probes
        if not get_numbers:
            get_numbers = self.probe_numbers# if empty, use all numbers

        names_list = []
        check_vars = True
        for  name in get_names:
            name_dict = self.data[name]
            numbers_list = []
            for number in get_numbers:
                df = name_dict[number]
                if check_vars and not get_vars:
                    get_vars = df.keys()
                    check_vars = False
                df = df[get_vars]
                np_array = df.to_numpy()
                np_array_select_probes = np_array[get_probes]
                numbers_list.append(np_array_select_probes) # get df from data dictionary and convert to np array
            names_list.append(numbers_list) # create nested lists of names[numbers]

        return np.asarray(names_list) # return numpy array with all requested data

    
    def mattia_plot(
        self, 
        get_names = [],
        get_numbers =  [],
        get_probes = [],
        get_vars = [],
        LES_params = {},
        plotting_params = {}
        ):
        
        # LES params
        self.LES_params.update(LES_params)

        uStar = self.LES_params['uStar']
        z0 = self.LES_params['z0']
        deltas = self.LES_parmas['deltas']


        Uref = uStar/0.41*np.log(1.975/z0)
        q = 0.5*1.225*Uref**2

        self.LES_params.update({
            'Uref' : Uref,
            'q' : q
        })

        # plotting params
        self.plotting_params.update(plotting_params)

        t0 = self.plotting_params['t0']

        data = self.slice_into_np(get_names, get_numbers)






    

        




