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
import re

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


def sum_columns_by_room(df):
    # Dictionary to hold the grouped column names
    grouped_volumes = {}

    # Loop over each column in the DataFrame
    for row, v in df.iterrows():
        room_code = row.split('_')[1]
        if room_code == "0-1": # dual room
            room_code = "1-1"
        elif room_code == "2-1":
            room_code = "2-0"
        # Extract the base name by removing the room number
        base_name = re.sub(r'room\d+_\d-\d', f'room_{room_code}', row)
        if base_name not in grouped_volumes:
            grouped_volumes[base_name] = []
        grouped_volumes[base_name].append(row)
    
    # Sum the rows based on the grouped row names
    summed_df = {}
    for base_name, rows in grouped_volumes.items():
        dfCombined = df.loc[rows].apply(sum) / len(rows)
        summed_df[base_name] = {}
        for col, s in dfCombined.items():
            summed_df[base_name][col] = s

    return pd.DataFrame(summed_df).T

############ Universal ################
scratch_home = os.getenv('SCRATCH') #need to set SCRATCH (even if there is no real SCRATCH) to the location where results are written
oak_home = os.getenv('OAK_HOME')
scratch_dir = f'{scratch_home}/Cascade/city_block_cfd'
home_dir = f'{oak_home}/Cascade/city_block_cfd'

category = sys.argv[1]
R = sys.argv[2]
starts = list(map(int, sys.argv[3].split(',')))
stops = list(map(int, sys.argv[4].split(',')))
# category = "config2"
# R = "46"
# starts = [40000,120000]
# stops = [120000, 160000]
print(f"starts: {starts}")
print(f"stops: {stops}")
by = 1

# category = "config2"
# R = 34
# start = 40000

# %%
hm = 6
window_dim = hm/2/4
velTenMeters = 1 #4
T_ref = 5
rho = 1.225

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
def norm_Temp(df):
    return df / T_ref

@utils.no_kwargs
@utils.dict_apply
def get_Cp(df):
    return df / (0.5 * rho * velTenMeters**2)

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
qois = qoisOutputed




# %%
allFlowStats = {}
allRoomVentilation = {}

probes_dir = f'{home_dir}/CHARLES/{category}/R{R}/probes/probesOut_parquet'
locations_dir = f'{scratch_dir}/CHARLES/{category}/R{R}/probes/locations'
print(probes_dir)

probes = probePost.Probes(probes_dir, probe_type = "FLUX_PROBES", flux_quants = qoisOutputed, file_type = "parquet")
print(category, R)

print("Compiling window stats")

## X Flow

@utils.no_kwargs
def norm_norm_blocks(data_dict):
    if category == "config2" and int(R) < 40:
        return probePost.mul_names(data_dict, [name for name in probes.probe_names if "Bxz" in name or "Bz" in name], -1)
    return data_dict


dfX = probes.statistics(
    names = [name for name in  probes.probe_names if "xwindow" in name], 
    # steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_norm_blocks],
    parrallel=False
    )

## Z Flow

@utils.no_kwargs
def norm_norm_windows(data_dict):
    return probePost.mul_names(data_dict, [name for name in probes.probe_names if fnmatch(name, "*window_?-1*")], -1)

@utils.no_kwargs
def norm_norm_blocks(data_dict):
    if category == "config2" and int(R) < 40:
        return probePost.mul_names(data_dict, [name for name in probes.probe_names if "Bxz" in name or "Bx" in name], -1)
    return data_dict


dfZ = probes.statistics(
    names = [name for name in  probes.probe_names if "zwindow" in name], 
    # steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [norm_norm_windows, norm_norm_blocks],
    parrallel=False
    )

## Y Flow

dfY = probes.statistics(
    names = [name for name in  probes.probe_names if "skylight" in name], 
    # steps = probes.probe_steps[start:stop:by],
    quants = qois,
    processing = [flip_data, norm_norm_blocks],
    parrallel=False
    )

#### Extra Probes ####

EPprobes = probePost.Probes(probes_dir, directory_parquet = probes_dir, file_type = "parquet")

nameKey = read_probes_file_switch(f"{probes_dir}/../locations/nameKey_extraProbe.txt")
nameKey = nameKey.compute()
nameKey = pd.concat([nameKey, EPprobes.locations["extraProbe"]], axis = "columns")

for i, start in enumerate(starts):
    stop = stops[i]
    print(f"... from steps {start} to {stop}")
    flowStats = []
    for df in [dfX, dfZ, dfY]:
        df_sub = df.map(lambda s: s.loc[start:stop-1])

        mean = df_sub.map(probePost.time_average)
        rms = df_sub.map(probePost.time_rms)
        net = df_sub.map(abs)
        net = net.map(probePost.time_average)

        dfs_calced = [mean, rms, net]
        calcs = ["mean", "rms", "net"]

        for i, calc in enumerate(calcs):
            dfs_calced[i].columns = [f"{calc}-{c}" for c in dfs_calced[i].columns]
        dfs_calced = pd.concat(dfs_calced, axis = "columns")
        flowStats.append(dfs_calced)


    # %%
    flowStats = pd.concat(flowStats, axis = "index")

    locations = probes.get_avg_locations()
    locations = locations.loc[flowStats.index.values]
    areas = {k: v for k, v in probes.areas.items() if k in flowStats.index}

    if category == "config2" and int(R) < 40:
        flowStats = flowStats.rename(index=lambda x: matchNewNamingConvention(x))
        locations = locations.rename(index=lambda x: matchNewNamingConvention(x))
        areas = pd.Series(areas).rename(index=lambda x: matchNewNamingConvention(x))


    # apply proper post processing to qois
    for qoi in flowStats.columns.values:
        if fnmatch(qoi, '*mass_flux*') or fnmatch(qoi, '*sn_prod(*u*)'):
            flowStats[qoi] = flowStats[qoi].apply(norm_vent)
        if fnmatch(qoi, '*sn_prod(u**2)"'):
            flowStats[qoi] = flowStats[qoi].apply(norm_vel) # normalize again because velocity squared
        if fnmatch(qoi, '*mass_flux(T)'):
            flowStats[qoi] = flowStats[qoi].apply(norm_Temp)
        if fnmatch(qoi, '*sn_prod(p)'):
            flowStats[qoi] = flowStats[qoi].apply(get_Cp)
    # %%
    df = EPprobes.statistics(
        names = [name for name in  EPprobes.probe_names if "extraProbe" in name], 
        steps = [stop],
        quants = ["comp(u_avg,0)", "comp(u_avg,1)", "comp(u_avg,2)", "mag(u)_avg", "p_avg", "D_avg", "S_avg", "T_avg"],
        parrallel=False
        )

    extraProbe = nameKey.copy()
    extraProbe = pd.concat([extraProbe, df], axis = "columns")
    extraProbe.set_index(0, inplace=True)
    extraProbe = extraProbe.rename(columns=lambda x: f"EP_{x}")
    extraProbe = extraProbe.rename(index=lambda x: x.replace("extraProbe_", ''))

    flowStats = probePost.addWindowDetails(flowStats, locations, areas, extraProbe)
    flowStats["blockType"].fillna("B", inplace = True)

    flowStatsPath = f"{probes_dir}/../flowStats-{start}to{stop}.csv"
    flowStats.to_csv(flowStatsPath)

    # %%
    ##### Room Interior Probing ####
    # %%


    # @utils.no_kwargs
    # @utils.dict_apply
    # def seriesToFloat(s):
    #     return s.values[0]


del dfX, dfY, dfZ, df

##### Flux Probes ####
print("Writing floor and ceiling flux probe moments")

mean = pd.DataFrame()
rms = pd.DataFrame()

mean_rooms = pd.DataFrame()
rms_rooms = pd.DataFrame()

for qoi in probes.probe_quants:
    print(f"qoi = {qoi}")

    
    df = probes.statistics(
        names = [name for name in  probes.probe_names if "Floor" in name or "Ceil" in name],
        # steps = probes.probe_steps[start:stop:by],
        quants = [qoi],
        series_to_df=False,
        parrallel=False
        )

    for i, start in enumerate(starts):
        stop = stops[i]
        print(f"... from steps {start} to {stop}")
        df_sub = df.map(lambda s: s.loc[start:stop-1])
    
        mean[qoi] = df_sub.map(probePost.time_average)
        rms[qoi] = df_sub.map(probePost.time_rms)

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

mean = pd.DataFrame()
rms = pd.DataFrame()
taus = pd.DataFrame()

mean_rooms = pd.DataFrame()
rms_rooms = pd.DataFrame()
taus_rooms = pd.DataFrame()

for qoi in probes.probe_quants:
    print(f"qoi = {qoi}")

    df = probes.statistics(
        # names = probes.probe_names,
        # steps = steps,
        quants = [qoi],
        parrallel=False,
        series_to_df=False
        )

    for i, start in enumerate(starts):
        stop = stops[i]
        print(f"... from steps {start} to {stop}")
        steps = probes.probe_steps[start:stop:by]
        times = probes.probe_times[steps]

        # Define the fitting function for taus
        def exponential_fit(y, time = times, c = None):
            # Convert input to numpy arrays if they are pandas Series
            time = time.copy()
            y = y.copy()
            if hasattr(y, 'values'):
                    y = y.values
            if hasattr(time, 'values'):
                    time = time.values
            if y[0] == 0:
                    return 0
            time -= time[0]
            y += 1e-6
            y /= y[0]
            if c == None:
                exp_decay = lambda x, a, c: (1 - c) * np.exp(-x/a) + c #define theoretical exponential decay function
                popt, _ = sp.optimize.curve_fit(exp_decay, time, y, p0=[100, 0], bounds=([0, 0], [np.inf, 1]))
            else:
                exp_decay = lambda x, a: (1 - c) * np.exp(-x/a) + c #define theoretical exponential decay function
                popt, _ = sp.optimize.curve_fit(exp_decay, time, y, p0=100, bounds=(0, np.inf))
                popt = np.append(popt, c)
            return popt

        print(category, R, f"{start} to {stop}")
        df_sub = df.map(lambda s: s.loc[start:stop-1])
        mean[qoi] = df_sub.map(probePost.time_average)
        rms[qoi] = df_sub.map(probePost.time_rms)
        if qoi == 'D':
            taus[qoi] = df_sub[qoi].map(lambda y: exponential_fit(y, c = 0))
        if qoi == 'T':
            taus[qoi] = df_sub[qoi].map(exponential_fit)

        df_sub_rooms =  sum_columns_by_room(df_sub)

        mean_rooms[qoi] = df_sub_rooms.map(probePost.time_average)
        rms_rooms[qoi] = df_sub.map(probePost.time_rms)
        if qoi == 'D':
            taus_rooms[qoi] = df_sub[qoi].map(lambda y: exponential_fit(y, c = 0))
        if qoi == 'T':
            taus_rooms[qoi] = df_sub[qoi].map(exponential_fit)

    mean.to_csv(f"{probes_dir}/../volMean-{start}to{stop}.csv")
    rms.to_csv(f"{probes_dir}/../volRms.csv-{start}to{stop}")
    taus.to_csv(f"{probes_dir}/../volTaus.csv-{start}to{stop}")

    mean_rooms.to_csv(f"{probes_dir}/../roomVolMean-{start}to{stop}.csv")
    rms_rooms.to_csv(f"{probes_dir}/../roomVolRms.csv-{start}to{stop}")
    taus_rooms.to_csv(f"{probes_dir}/../roomVolTaus.csv-{start}to{stop}")