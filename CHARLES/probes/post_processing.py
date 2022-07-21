#%%
import post.tools as tools
import time
import matplotlib as plt
import numpy as np
# import pathlib

#%%
# working_dir = pathlib.Path().absolute()
working_dir = '/home/nbachand/Documents/Cascade/city_block'

st = time.time()
probes = tools.Probes(f'{working_dir}/CHARLES/probes/probesOut')
probes.get_locations(f'{working_dir}/CHARLES/probes/locations')
et = time.time()

print(et-st)
# print(probes.data['x_1over6'][79743]['comp(u,0)'])
# print(probes.data['x_1over6'][79743]['comp(u,0)'])

# print(probes.locations['x_1over6'])
# print(probes.locations['x_1over6'])
# %%
# print(probes.data['x_1over6'].items())

# %%
probes.create_data_lists()
print(probes.data_list[0][:5])#['comp(u,0)'][0])
# %%
# %%
