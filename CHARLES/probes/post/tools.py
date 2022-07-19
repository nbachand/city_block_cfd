import pandas as pd
import glob
import time

def read_pcd(filename):
    return pd.read_csv(filename, delim_whitespace=True)
            
class MyProbeDict(dict):
    def __getitem__(self, item):
        value=dict.__getitem__(self, item)
        if not isinstance(value, pd.core.frame.DataFrame):
            # print('reading in probe data')
            function, arg = value
            value = function(arg)
            dict.__setitem__(self, item, value)
        return value


class Probes:
    def __init__(self, directory):

        my_dict= {}
        path_generator = glob.iglob(f'{directory}/*.pcd') # retrieve paths for all probes

        for path in path_generator:

            file_name = path.split('/')[-1]
            probe_info = file_name.split('.')
            probe_name, probe_number, _ = probe_info[:]
            probe_number = int(probe_number)

            if probe_name not in my_dict.keys():
                my_dict[probe_name] = {}

            my_dict[probe_name][probe_number] = (read_pcd, path)

        for probe_name, name_dict in my_dict.items():
            my_dict[probe_name] = MyProbeDict(name_dict)
        self.data = my_dict


st = time.time()
test = Probes('./CHARLES/probes/probesOut')
et = time.time()

print(et-st)
print(test.data['x_1over6'][79743]['comp(u,0)'])
print(test.data['x_1over6'][79742]['comp(u,0)'])