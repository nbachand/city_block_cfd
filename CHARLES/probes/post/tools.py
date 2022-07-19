import pandas as pd
import glob
import time

def read_pcd(filename):
    print(f'type: {type(pd.read_csv(filename, delim_whitespace=True))}')
    return pd.read_csv(filename, delim_whitespace=True)
            
class MyProbeDict(dict):
    def __getitem__(self, item):
        value=dict.__getitem__(self, item)
        if not isinstance(value, pd.core.frame.DataFrame):
            function, arg = value
            value = function(arg)
            dict.__setitem__(self, item, value)
        return value


class Probes:
    def __init__(self, directory):
        self.data = None

        my_dict= {}
        path_generator = glob.iglob(f'{directory}/*.pcd')
        i = 0
        for path in path_generator:
            i+=1
            if i > 10000:
                break

            file_name = path.split('/')[-1]
            probe_info = file_name.split('.')
            probe_name, probe_number, _ = probe_info[:]
            probe_number = int(probe_number)
            probe = f'{probe_name}{probe_number}'

            # if probe_number in self.data[probe_name]:
            #     print("WARNING: duplicate probes")
            my_dict[probe] = (read_pcd, path)
        self.data = MyProbeDict(my_dict)


st = time.time()
test = Probes('./probesOut')
# print(test.data)
et = time.time()

print(et-st)
probe = 'x_1over6'+'88300'
print(test.data[probe])
print(test.data[probe])