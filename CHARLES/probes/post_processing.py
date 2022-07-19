#%%
import post.tools as tools
import time
# import pathlib

#%%
# working_dir = pathlib.Path().absolute()
working_dir = '/home/nbachand/Documents/Cascade/city_block'

st = time.time()
test = tools.Probes(f'{working_dir}/CHARLES/probes/probesOut')
test.get_locations(f'{working_dir}/CHARLES/probes/locations')
et = time.time()

print(et-st)
print(test.data['x_1over6'][79743]['comp(u,0)'])
print(test.data['x_1over6'][79743]['comp(u,0)'])

print(test.locations['x_1over6'])
print(test.locations['x_1over6'])
# %%
