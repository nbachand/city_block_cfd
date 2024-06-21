# %%
from pyCascade import probePost, physics, utils, probeReadWrite
from pyCascade.probeReadWrite import read_probes_file_switch
import numpy as np
import scipy as sp
import os
import sys
from IPython.core.debugger import set_trace
import pandas as pd
from fnmatch import fnmatch

def matchNewNamingConvention(input_str):
    # Find the position of the '-' in the string
    split_index = input_str.find('_h_')

    if split_index == -1:
        return input_str #return original if no house number
    
    n1 = int(input_str[split_index+3])
    n2 = int(input_str[split_index+5])
    
    # Modify the numbers
    new_n1 = n1 - 3
    new_n2 = n2 - 2
    
    # Format the output string with the modified numbers
    output_str = f"{new_n1}-{new_n2}"
    
    return f"{input_str[:split_index+3]}{output_str}{input_str[split_index+6:]}"

############ Universal ################
scratch_home = os.getenv('SCRATCH') #need to set SCRATCH (even if there is no real SCRATCH) to the location where results are written
oak_home = os.getenv('OAK_HOME')
scratch_dir = f'{scratch_home}/Cascade/city_block_cfd'
home_dir = f'{oak_home}/Cascade/city_block_cfd'

category = sys.argv[1]
R = sys.argv[2]
start = int(sys.argv[3])
stop  = int(sys.argv[4])

# category = "config2"
# R = 34
# start = 40000

print(category, R, f"{start} to {stop}")

# %%
hm = 6
window_dim = hm/2/4
velTenMeters = 4

velocity_scaling = 1/velTenMeters
ventilation_scaling = velocity_scaling/(window_dim**2)

@utils.no_kwargs
@utils.dict_apply
def norm_vel(df):
    return df * velocity_scaling

@utils.no_kwargs
@utils.dict_apply
def norm_vent(df):
    return df * ventilation_scaling

@utils.no_kwargs
@utils.dict_apply
def abs_values(df):
    return df.abs()

@utils.no_kwargs
@utils.dict_apply
def flip_data(df):
    return -df


# %%
qoisOutputed = [
    "mass_flux",
    "mass_flux(p)",
    "mass_flux(T)",
    "mass_flux(D)",
    "mass_flux(S)",
    "sn_prod(u)",
    "sn_prod(p)",
    "sn_prod(abs(u))",
    "sn_prod(u**2)"
]
qois= ["mass_flux"]


# %%
by = 1

# %%

connectedWindows = {
    "corner": [
        "xwindow_0-0",
        "zwindow_0-0",
        "skylight_0-0"
    ],
    "single": [
        "zwindow_1-0",
        "skylight_1-0"
    ],
    "dual": [
        "xwindow_0-1",
        "zwindow_0-1",
        "zwindow_1-1",
        "skylight_0-1",
        "skylight_1-1"
       ],
    "cross": [
        "zwindow_2-0",
        "zwindow_2-1",
        "skylight_2-0",
        "skylight_2-1"
    ]
}


# %%
allFlowStats = {}
allRoomVentilation = {}

probes_dir = f'{home_dir}/CHARLES/{category}/R{R}/probes/probesOut_parquet'
locations_dir = f'{scratch_dir}/CHARLES/{category}/R{R}/probes/locations'
print(probes_dir)
flowStatsPath = f"{probes_dir}/../flowStats-{start}to{stop}.csv"
roomVentilationPath = f"{probes_dir}/../roomVentiation-{start}to{stop}.csv"

probes = probePost.Probes(probes_dir, probe_type = "FLUX_PROBES", flux_quants = qoisOutputed, file_type = "parquet")

## X Flow

@utils.no_kwargs
def norm_norm_blocks(data_dict):
    if category == "config2":
        return probePost.mul_names(data_dict, [name for name in probes.probe_names if "Bxz" in name or "Bz" in name], -1)
    return data_dict

## mean statistics
x_mean = probes.statistics(
    names = [name for name in  probes.probe_names if "xwindow" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, probePost.time_average, norm_norm_blocks],
    parrallel=False
    )

## rms statistics
x_rms = probes.statistics(
    names = [name for name in  probes.probe_names if "xwindow" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, probePost.time_rms],
    parrallel=False
    )

## Net flow
x_net = probes.statistics(
    names = [name for name in  probes.probe_names if "xwindow" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, abs_values, probePost.time_average],
    parrallel=False
    )

x_flowStats = pd.concat([x_mean, x_rms, x_net], axis = "index").T
x_flowStats.columns = ["mean", "rms", "net"]

## Z Flow

@utils.no_kwargs
def norm_norm_windows(data_dict):
    return probePost.mul_names(data_dict, [name for name in probes.probe_names if fnmatch(name, "*window_?-1*")], -1)

@utils.no_kwargs
def norm_norm_blocks(data_dict):
    if category == "config2":
        return probePost.mul_names(data_dict, [name for name in probes.probe_names if "Bxz" in name or "Bx" in name], -1)
    return data_dict

## mean statistics
z_mean = probes.statistics(
    names = [name for name in  probes.probe_names if "zwindow" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, probePost.time_average, norm_norm_windows, norm_norm_blocks],
    parrallel=False
    )

## rms statistics
z_rms = probes.statistics(
    names = [name for name in  probes.probe_names if "zwindow" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, probePost.time_rms],
    parrallel=False
    )

## Net flow
z_net = probes.statistics(
    names = [name for name in  probes.probe_names if "zwindow" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, abs_values, probePost.time_average],
    parrallel=False
    )

z_flowStats = pd.concat([z_mean, z_rms, z_net], axis = "index").T
z_flowStats.columns = ["mean", "rms", "net"]
## Y Flow

## mean statistics
y_mean = probes.statistics(
    names = [name for name in  probes.probe_names if "skylight" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, probePost.time_average, flip_data],
    parrallel=False
    )

## rms statistics
y_rms = probes.statistics(
    names = [name for name in  probes.probe_names if "skylight" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, probePost.time_rms],
    parrallel=False
    )

## Net flow
y_net = probes.statistics(
    names = [name for name in  probes.probe_names if "skylight" in name], 
    steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_vent, abs_values, probePost.time_average],
    parrallel=False
    )

y_flowStats = pd.concat([y_mean, y_rms, y_net], axis = "index").T
y_flowStats.columns = ["mean", "rms", "net"]

locations = probes.get_avg_locations()
areas = probes.areas
flowStats = pd.concat([x_flowStats, y_flowStats, z_flowStats], axis = "index")
if category == "config2" and int(R) < 40:
    flowStats = flowStats.rename(index=lambda x: matchNewNamingConvention(x))
    locations = locations.rename(index=lambda x: matchNewNamingConvention(x))
    areas = pd.Series(areas).rename(index=lambda x: matchNewNamingConvention(x))

# %%
#### Extra Probes ####

EPprobes = probePost.Probes(probes_dir, directory_parquet = probes_dir, file_type = "parquet")

nameKey = read_probes_file_switch(f"{locations_dir}/nameKey_extraProbe.txt")
nameKey = nameKey.compute()

extraProbe = nameKey.copy()
extraProbe = pd.concat([extraProbe, EPprobes.locations["extraProbe"]], axis = "columns")
for qoi in ["comp(u_avg,0)", "comp(u_avg,1)", "comp(u_avg,2)"]:
    df = probePost.ddf_to_pdf(EPprobes.data[("extraProbe", qoi)]).iloc[-1]
    df.name = qoi
    extraProbe = pd.concat([extraProbe, df], axis = "columns")
extraProbe.set_index(0, inplace=True)
extraProbe = extraProbe.rename(columns=lambda x: f"EP_{x}")
extraProbe = extraProbe.rename(index=lambda x: x.replace("extraProbe_", ''))

#### EP Window Stats ####
roomQois = ["mean", "net", "EP_normal", "EP_shear", "EPR_mag"]
flowStats = probePost.addWindowDetails(flowStats, locations, areas, extraProbe)

sort_order = ["blockType", "houseType", "roomType"]
roomVentilation = probePost.roomStatistics(flowStats, connectedWindows, roomQois)
roomVentilation = roomVentilation.sort_values(by = sort_order)
sort_order.append("windowType")
flowStats = flowStats.sort_values(by = sort_order)
flowStats["blockType"].fillna("B", inplace = True)



#### EP Rooms ####
roomVentilation["nWindows"] = roomVentilation["mean"].apply(lambda l: len(l))
roomVentilation["contResid"] = roomVentilation["mean"].apply(lambda l: sum(l))
for qoi in ["mean", "net"]:
    roomVentilation[qoi] = roomVentilation[qoi].apply(lambda l : sum(np.abs(l))/2)
roomVentilation["EPR_mag"] = roomVentilation["EPR_mag"].apply(lambda l: np.mean(l))
roomVentilation["EP_shear"] = roomVentilation["EP_shear"].apply(lambda l: sum(l))
roomVentilation["EP_normal_mag"] = roomVentilation["EP_normal"].apply(lambda l: sum(np.abs(l)))
roomVentilation["EP_normal_sum"] = roomVentilation["EP_normal"].apply(lambda l: abs(sum(l)))
roomVentilation["EP_normal_ratio"] = roomVentilation["EP_normal_mag"] / (roomVentilation["EP_normal_mag"] + roomVentilation["EP_normal_sum"])

flowStats.to_csv(flowStatsPath)
roomVentilation.to_csv(roomVentilationPath)
# %%
##### Room Interior Probing ##3
# %%


@utils.no_kwargs
@utils.dict_apply
def seriesToFloat(s):
    return s.values[0]

    
##### Flux Probes ####
print("Writing flux probe moments")
## mean statistics
mean = probes.statistics(
    names = [name for name in  probes.probe_names if "Floor" in name or "Ceil" in name],
    steps = probes.probe_steps[start:stop:by],
    processing = [probePost.time_average, seriesToFloat],
    parrallel=False
    )
    
## rms statistics
rms = probes.statistics(
    names = [name for name in  probes.probe_names if "Floor" in name or "Ceil" in name], 
    steps = probes.probe_steps[start:stop:by],
    processing = [probePost.time_rms, seriesToFloat],
    parrallel=False
    )

retrievedIndex = mean.index
if areas is not None:
    print("adding areas")
    mean["area"] = areas
if locations is not None:
    print("adding locations")
    mean = pd.concat([mean, locations], axis = "columns")
mean = mean.loc[retrievedIndex]

retrievedIndex = rms.index
if areas is not None:
    rms["area"] = areas
if locations is not None:
    rms = pd.concat([rms, locations], axis = "columns")
rms = rms.loc[retrievedIndex]

mean.to_csv(f"{probes_dir}/../roomFluxMean-{start}to{stop}.csv")
rms.to_csv(f"{probes_dir}/../roomFluxRms-{start}to{stop}.csv")


# %%
###### Volume Probes ######
print("Writing volume probe moments")
qoisOutputed = ["comp(u,0)", "comp(u,1)", "comp(u,2)", "p", "T", "D", "S"]
probes = probePost.Probes(probes_dir, probe_type = "VOLUMETRIC_PROBES", flux_quants = qoisOutputed, file_type = "parquet")


## mean statistics
mean = probes.statistics(
    steps = probes.probe_steps[start:stop:by],
    processing = [probePost.time_average, seriesToFloat],
    parrallel=False
    )
    
## rms statistics
rms = probes.statistics( 
    steps = probes.probe_steps[start:stop:by],
    processing = [probePost.time_rms, seriesToFloat],
    parrallel=False
    )

mean.to_csv(f"{probes_dir}/../roomVolMean-{start}to{stop}.csv")
rms.to_csv(f"{probes_dir}/../roomVolRms.csv-{start}to{stop}")