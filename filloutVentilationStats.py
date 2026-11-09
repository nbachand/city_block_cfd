import pandas as pd
from fnmatch import fnmatch
from pyCascade import physics
import itertools
import numpy as np
import os
import warnings
from collections.abc import Sequence

hm = 6
window_dim = hm/2/4
velTenMeters = 1 #4
T_ref = 5
Cp = 1005
rho = 1.225

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

roomkey = {
    "0-0": "corner",
    "1-0": "single",
    "2-0": "cross",
    "1-1": "dual",
    "2-1": "cross-CONNECTED",
    "0-1": "dual-CONNECTED"
}

x = 4
y = 3
wall_area = x*y
floor_area = x**2
window_area = (.25*y)**2
door_area = (0.25*y) * (0.75*y)

room_areas = {
    "walls": {
        "single": 4*wall_area - window_area,
        "corner": 4*wall_area - 2*window_area,
        "dual": 8*wall_area - 3*window_area - door_area,
        "cross": 6*wall_area - 2*window_area,
    },
    "floors": {
        "single": floor_area,
        "corner": floor_area,
        "dual": 2 * floor_area,
        "cross": 2 * floor_area,
    },
    "ceilings": {
        "single": floor_area - window_area,
        "corner": floor_area - window_area,
        "dual": 2 * (floor_area - window_area),
        "cross": 2 * (floor_area - window_area),
    }
}

room_volumes = {
    "single": y * floor_area,
    "corner": y * floor_area,
    "dual": 2 * y * floor_area,
    "cross": 2 * y * floor_area
}


def getWindowOrientations(flowStats):
    flowStats["orientation"] = pd.Series(dtype=float)

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "B") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "Bxz"))
        ) | (
            (flowStats.openingType == "zwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]'))) & (flowStats.blockType == "Bz"))
        ), "orientation"] = 0

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "B") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "Bxz"))
        ) | (
            (flowStats.openingType == "zwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "Bz"))
        ), "orientation"] = 180

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "Bz"))
        ) | (                                                                             
            (flowStats.openingType == "zwindow") & (                                    
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "Bxz") |
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]')))& (flowStats.blockType == "B"))
        ), "orientation"] = 90

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "Bz"))
        ) | (
            (flowStats.openingType == "zwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]'))) & (flowStats.blockType == "Bxz") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "B"))
        ), "orientation"] = 270

    flowStats.loc[flowStats.blockType == "B", "roomOrientation"] = 0
    flowStats.loc[flowStats.blockType == "Bz", "roomOrientation"] = 90
    flowStats.loc[flowStats.blockType == "Bxz", "roomOrientation"] =180
    flowStats.loc[flowStats.blockType == "Bx", "roomOrientation"] = 270

    return flowStats

def getRoomOrientations(roomVentilation):
    roomVentilation["orientation"] = pd.Series(dtype=float)

    roomVentilation.loc[roomVentilation.blockType == "B", "orientation"] = 0
    roomVentilation.loc[roomVentilation.blockType == "Bz", "orientation"] = 90
    roomVentilation.loc[roomVentilation.blockType == "Bxz", "orientation"] =180
    roomVentilation.loc[roomVentilation.blockType == "Bx", "orientation"] = 270

    return roomVentilation

# def houseTypeRename(houseType):
#     if houseType == "-1-0":
#         return "-1-0"
#     else:
#         return "sl"

def addWindowDetails(flowStats, locations = None, areas = None, extraProbe = None):
    windowType = []
    openingType = []
    houseType = []
    blockType = []
    windowNumber = []
    for window, row in flowStats.iterrows():
        windowData = window.replace("_h_", '_')
        windowData = windowData.split('_')
        if len(windowData) == 3:
            windowData.append(np.nan)
        windowType.append(f"{windowData[0]}_{windowData[1]}")
        openingType.append(windowData[0])
        windowNumber.append(windowData[1])
        houseType.append(windowData[2])
        blockType.append(windowData[3])

    flowStats["windowType"] = windowType
    flowStats["openingType"] = openingType
    flowStats["windowNumber"] = windowNumber
    flowStats["houseType"] = houseType
    flowStats["blockType"] = blockType
    flowStats["blockType"].fillna("B", inplace = True)

    retrievedIndex = flowStats.index
    if areas is not None:
        flowStats["area"] = areas
    if locations is not None:
        flowStats = pd.concat([flowStats, locations], axis = "columns")
    flowStats = flowStats.loc[retrievedIndex]

    flowStats["orientation"] = pd.Series(dtype=float)

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "B") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "Bxz"))
        ) | (
            (flowStats.openingType == "zwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]'))) & (flowStats.blockType == "Bz"))
        ), "orientation"] = 0

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "B") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "Bxz"))
        ) | (
            (flowStats.openingType == "zwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "Bz"))
        ), "orientation"] = 180

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "Bz"))
        ) | (                                                                             
            (flowStats.openingType == "zwindow") & (                                    
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "Bxz") |
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]')))& (flowStats.blockType == "B"))
        ), "orientation"] = 90

    flowStats.loc[(
            (flowStats.openingType == "xwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '0-?'))) & (flowStats.blockType == "Bx") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '[!0]-?'))) & (flowStats.blockType == "Bz"))
        ) | (
            (flowStats.openingType == "zwindow") & (
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-[!0]'))) & (flowStats.blockType == "Bxz") | 
            (flowStats.windowNumber.apply(lambda str: fnmatch(str, '?-0'))) & (flowStats.blockType == "B"))
        ), "orientation"] = 270
    
    if extraProbe is not None:
        EP_mag = []
        EP_vel_orientation = []
        EP_normal = []
        EP_shear = []
        EPR_mag = []
        EPR_vel_orientation = []
        
        flowStats = pd.concat([flowStats.sort_index(), extraProbe.sort_index()], axis = "columns")
        for window, row in flowStats.iterrows():
            if np.isnan(row["x"]) == False and np.isnan(row["EP_x"]) == False:
                EP_vector = row[["EP_x", "EP_y", "EP_z"]].values - row[["x", "y", "z"]].values
                EP_vector = EP_vector / np.linalg.norm(EP_vector)
                # EP_vector
                EP_velocity = row[["EP_comp(u_avg,0)", "EP_comp(u_avg,1)", "EP_comp(u_avg,2)"]].values
                EP_mag.append(row["EP_mag(u)_avg"])
                EP_vector_mag = np.linalg.norm(EP_velocity)
                EP_normal.append(np.dot(EP_vector, EP_velocity))
                EP_vel_orientation.append(np.arccos(EP_normal[-1]/EP_vector_mag)*180/np.pi)
                EP_normal[-1] *= -1 # adjusting for positive being into the room
                EP_shear.append(np.sqrt(EP_vector_mag**2 - EP_normal[-1]**2))
            else:
                EP_mag.append(np.nan)
                EP_vel_orientation.append(np.nan)
                EP_normal.append(np.nan)
                EP_shear.append(np.nan)
            EPRoof = f"roof_h_{row['houseType']}_{row['blockType']}".removesuffix("_B")
            if "sl" in EPRoof:
                EPRoof = EPRoof.replace("_h_", "_")
            if EPRoof in flowStats.index:
                EPR_velocity = flowStats.loc[EPRoof, ["EP_comp(u_avg,0)", "EP_comp(u_avg,1)", "EP_comp(u_avg,2)"]].values
                EPR_magnitude = np.linalg.norm(EPR_velocity)
                EPR_mag.append(EPR_magnitude)
                EPR_vel_orientation.append(np.arccos(np.dot([1, 0, 0], EPR_velocity/EPR_magnitude))*180/np.pi)
            else:
                EPR_mag.append(np.nan)
                EPR_vel_orientation.append(np.nan)
        
        flowStats["EP_mag"] = EP_mag
        flowStats["EP_vel_orientation"] = EP_vel_orientation
        flowStats["EP_normal"] = EP_normal
        flowStats["EP_shear"] = EP_shear
        flowStats["EPR_mag"] = EPR_mag
        flowStats["EPR_vel_orientation"] = EPR_vel_orientation
        flowStats.dropna(subset = "x", inplace = True)

    return flowStats


def genKey(type, house, block):
    key = f"{type}_h_{house}_{block}"
    key = key.rstrip('_')
    return key.replace("h_sl", "sl")

def roomStatistics(windowStats, windowMap, roomQois):
    for key in ["houseType", "blockType", "windowType"]:
        if key not in windowStats:
            raise Exception("missing requisit information. Try running 'addWindowDetails' before this function")

    roomVentilation = {}
    roomList = []

    for windowKey, row in windowStats.iterrows():
        i = 0
        for room, windows in windowMap.items():
            i += 1
            if row["windowType"] in windows:
                break
            if i == len(windowMap.keys()):
                raise Exception(f"room not found for window f{windowKey}")

        roomKey = genKey(room, row["houseType"], row["blockType"])
        if roomKey not in roomVentilation:
            roomVentilation[roomKey] = {} #create room
            roomVentilation[roomKey]["windowKeys"] = [] #initlialize list for extra probes
            for qoi in roomQois:
                roomVentilation[roomKey][qoi] = [] #initlialize list for extra probes
        roomVentilation[roomKey]["windowKeys"].append(windowKey)
        for qoi in roomQois:
            addValue = windowStats.loc[windowKey, qoi] # keep as list to be combined later (outside function)
            roomVentilation[roomKey][qoi].append(addValue)

        roomVentilation[roomKey].update(row[["houseType", "blockType"]])
        roomVentilation[roomKey]["roomType"] = room
        roomList.append(room)

    windowStats["roomType"] = roomList # modifying in place, should modify outside function i.e. pass by reference
    roomVentilation = pd.DataFrame(roomVentilation).T

    return roomVentilation

def fillInParams(df, velTenMeters):
    def process_row(row):
        if "roomOrientation" in row.index:
            # Opening rows: orientation is the outward-normal angle and A the direction the wind blows toward,
            # both measured +x -> +z, so A - orientation is 180 head-on and 0 leeward on every face.
            row["AofA"] = (row["A"] - row["orientation"]) % 360
        else:
            # Room rows: orientation is minus the house rotation, so this is the wind angle in the house frame.
            row["AofA"] = (row["orientation"] + row["A"]) % 360
        row["AofA_resid"] = row["AofA"] % 90
        row["Ri"] = physics.getVentRi(row["delT"], row["WS"])
        row["EPR_Ri"] = physics.getVentRi(row["delT"], row["EPR_mag"])
        row["Params"] = f"Wind Speed: {row['WS']} m/s; Ri = {row['Ri']:.2f}; delT = {row['delT']}; SS = {row['SS']}"
        if row["C"] == 2:
            row["Params"] += "; High Density"
        elif row["C"] == 3:
            row["Params"] += "; Low Density"
        return row
    
    df = df.apply(process_row, axis="columns")

    new_columns = {}

    for col in df.columns:
        if fnmatch(col, '*mass_flux*') or fnmatch(col, '*sn_prod(*u*)') or fnmatch(col, 'q-*'):
            if fnmatch (col, '*mass_flux(p)*'):
                udim = 3
            elif fnmatch(col, '*sn_prod(u**2)'):
                udim = 2
            else:
                udim = 1
            new_columns[f"{col}-Norm"] =    df[col] / (df["WS"]      / velTenMeters)**udim
            new_columns[f"{col}-NormEP"] =  df[col] / (df["EP_mag"]  / velTenMeters)**udim
            new_columns[f"{col}-NormEPR"] = df[col] / (df["EPR_mag"] / velTenMeters)**udim
            new_columns[f"{col}-NormABL"] = df[col] / (df["u10_2"]   / velTenMeters)**udim

    # Combine new columns into a new DataFrame and concatenate with the original DataFrame
    new_df = pd.DataFrame(new_columns, index=df.index)
    df = pd.concat([df, new_df], axis=1)

    df.sort_values(["C", "WS", "delT", "SS"], inplace=True)
    return df



def getComparativeDf(df, split_cols, sort_cols = ['WS', 'AofA', 'C', 'delT', 'SS', 'roomType', 'houseType', 'blockType']):
    values = [df[col].unique() for col in split_cols]
    sort_cols = list(set(sort_cols) - set(split_cols))
    plotdfMulti = df.set_index([*split_cols, df.index]).sort_index(level = 0)
    dfs = []
    all_combinations = itertools.product(*values) # Use itertools.product to generate all combinations of values
    list_of_tuples = [comb for comb in all_combinations] # Create a list of sets from the combinations
    columnHeaders = []
    for vTuple in list_of_tuples:
        df_v = plotdfMulti.copy()
        validTuple = True
        for v in vTuple:
            try:
                df_v = df_v.xs(v, level=0) # cutting off levels each time so remains 0
            except KeyError as e:
                print(f"KeyError occurred: {e}; Likely a non-issue due to not having all possible split combinations in data")
                validTuple = False
                break
        if validTuple == True:
            columnHeaders.append(vTuple)
            df_v = df_v.set_index(sort_cols).sort_index()
            if df_v.index.is_unique == False:
                raise Exception(f"DataFrame for values {vTuple} in the provided list has a non-unique index.")
            dfs.append(df_v)
    print(f"split {split_cols} along values: ", columnHeaders)
    dfComp = pd.concat(dfs, axis = "columns", keys = columnHeaders)
    split_levels = [i for i in range(len(dfComp.columns.names) - 1)]
    dfComp = dfComp.reorder_levels([-1, *split_levels], axis = "columns")
    dfComp.sort_values(sort_cols, inplace=True)
    return dfComp, columnHeaders

def indMulti(ind: pd.core.indexes.multi.MultiIndex, cols: list):
    data = []
    for col in cols:
        colData = ind.get_level_values(col).astype(str)
        colData = colData.to_series()
        data.append(colData)
    if len(data) == 1:
        return data[0]
    return data

def string_to_list(s):
    # Check if the string contains square brackets and remove them if present
    if isinstance(s, str) and s.startswith('[') and s.endswith(']'):
        s = s.strip('[]')
        l = s.split()
        l = [s.replace(',','') for s in l]
        return [float(s) for s in l]
    else:
        return s

def indexPlusB(name):
    name_parts = name.split(("_"))
    if 'B' not in name_parts[-1]:
        name_parts.append('B')
    return '_'.join(name_parts)
    

def room_numbers_to_names(name, roomkey = roomkey):
    name = indexPlusB(name)
    name_parts = name.split(("_"))
    if name_parts[1] not in roomkey:
        raise Exception(f"room number not in room key")
    else:
        name_parts[1] = roomkey[name_parts[1]]
    return '_'.join(name_parts[1:])

def splitRoomStats(df):
    df['splitCol'] = df.index.map(lambda x: x.split('_')[0])
    df.index = df.index.map(room_numbers_to_names)
    splitVals = set(df['splitCol'])
    dfs = []

    for val in splitVals:
        split_df = df[df['splitCol'] == val].copy()
        split_df = split_df.drop(columns=['splitCol'])
        split_df.columns = [f"{c}-{val}" for c in split_df.columns]
        dfs.append(split_df)
    
    df = pd.concat(dfs, axis = "columns")
    return df


def norm_Temp(df, T_ref = T_ref):
    return df / T_ref

velocity_scaling = 1/velTenMeters
ventilation_scaling = velocity_scaling/(window_dim**2)

def norm_vel(df):
    return df * velocity_scaling

def norm_vent(df):
    return df * ventilation_scaling

def processTracerDecay(df):
    for qoi in df.columns.values:
        if fnmatch(qoi, "*tau*"):
            qoi_c = qoi.replace('tau', 'c')
            df[qoi_c] = df[qoi].apply(lambda l: l[1])
            df[qoi] = df[qoi].apply(lambda l: l[0])

            qoi_q = qoi.replace('tau', 'q')
            df[qoi_q] = np.nan
            for index, row in df.iterrows():

                room = index[1].split('_')[0]
                if fnmatch(qoi, "*-room"):
                    V = room_volumes[room]
                else: 
                    V = y/6 * floor_area
                tau = row[qoi]
                if tau > 0:
                    q = V * rho / tau
                else:
                    q = 0
                df.loc[index, qoi_q] = q

            df[qoi_q] = norm_vent(df[qoi_q]) # other ventilations normalized in getVentilationStats.py

        elif fnmatch(qoi, '*T*'):
            df[f"{qoi}-Norm"] = df[qoi].apply(norm_Temp)

    return df

def processConnectedRooms(df):
    duplicates = df.index.get_level_values(1).str.contains("CONNECTED")
    dfDuplicates = df[duplicates]
    df = df[~duplicates]

    dfDuplicates = dfDuplicates.reset_index()
    dfDuplicates["level_1"] = dfDuplicates["level_1"].str.replace("-CONNECTED", '')
    dfDuplicates.set_index(['level_0', 'level_1'], inplace=True)

    df.loc[dfDuplicates.index.values] = (df.loc[dfDuplicates.index.values] + dfDuplicates) / 2 # averaging the two volumes in cross and dual rooms

    return df, dfDuplicates

def find_sequence_columns(df):
    """
    Return names of all columns in df where every non-null entry
    is a Sequence (list, tuple, ndarray, etc.), but not a str/bytes.
    """
    seq_cols = []
    for col in df.columns:
        non_null = df[col].dropna()
        if non_null.empty:
            continue
        if non_null.apply(lambda x: isinstance(x, Sequence) and not isinstance(x, (str, bytes))).all():
            seq_cols.append(col)
    return seq_cols

def expand_variable_length_sequences(df, seq_cols=None, fill_value=np.nan):
    """
    Expand each list/tuple/array column into multiple new columns,
    padding shorter sequences up to the column's max length with fill_value.

    Params:
      df          - the original DataFrame
      seq_cols    - list of column names to expand; if None, auto-detect
      fill_value  - value to use to pad shorter sequences (default: np.nan)
    Returns:
      A new DataFrame with those columns dropped and their elements unpacked
      into new columns named <origcol>_0, <origcol>_1, … up to the max length.
    """
    df = df.copy()
    if seq_cols is None:
        seq_cols = find_sequence_columns(df)

    for col in seq_cols:
        # turn every entry into a list (so that tuples, arrays, etc. all become lists)
        sequences = df[col].apply(lambda x: list(x) if isinstance(x, Sequence) and not isinstance(x, (str, bytes)) else [])
        # figure out the max length
        max_len = sequences.apply(len).max()
        # pad each list up to max_len
        padded = sequences.apply(lambda lst: lst + [fill_value]*(max_len - len(lst)))
        # build the expanded DataFrame
        expanded = pd.DataFrame(
            padded.tolist(),
            index=df.index,
            columns=[f"{col}_{i}" for i in range(max_len)]
        )
        # drop original & join
        df = df.drop(columns=[col]).join(expanded)

    return df

def readRunStats(runs, home_dir, scratch_dir, multiRun_dir, readABLFits = True, saveResults = True):

    ### get Stat dfs for individual runs
    allFlowStats = {}
    allRoomVentilation = {}
    allFluxStats = {}
    allVolStats = {}
    allRoomVolStats = {}

    blockFitsABLPath = f'{home_dir}/CHARLES/multiRuns/blockFitsABL.csv'
    if os.path.exists(blockFitsABLPath) == False:
        warnings.warn("ABL fits not found. Run LESResults-multiRun.ipynb first.")
    blockFitsABL = pd.read_csv(blockFitsABLPath, index_col = ["runs", "blockType"])

    for run in runs:
        C = runs[run]['C']
        category = f"config{C}"
        R = run % 100
        probes_dir = f'{home_dir}/CHARLES/{category}/R{R}/probes/probesOut_parquet'
        locations_dir = f'{scratch_dir}/CHARLES/{category}/R{R}/probes/locations'
        print(probes_dir)
        starts = runs[run]['starts']
        stops = runs[run]['stops']
        delT = runs[run]['starts']
        SS = runs[run]['SS']
        if len(set([len(starts), len(stops), len(delT), len(SS)])) != 1:
            raise Exception(f"Run {runs} has array properties of different lengths")
        for j, start in enumerate(starts):
            runIndex = int(10*run + j)
            stop = stops[j]
            flowStatsPath = f"{probes_dir}/../flowStats-{start}to{stop}.csv"
            fluxStatsPath = f"{probes_dir}/../roomFluxStats-{start}to{stop}.csv" 
            volStatsPath = f"{probes_dir}/../volStats-{start}to{stop}.csv" 
            roomVolStatsPath = f"{probes_dir}/../roomVolStats-{start}to{stop}.csv" 
            paths = [flowStatsPath, fluxStatsPath, volStatsPath, roomVolStatsPath]
            for path in paths:
                if os.path.exists(path) == False:
                    warnings.warn(f"Run {run} from steps {start} to {stop} does not has associated ventilation file {path} Run createVentilationStats.slurm from run folder first.")

            flowStats = pd.read_csv(flowStatsPath, index_col=0)
            flowStats.index = flowStats.index.map(indexPlusB)
            runParams = []
            for k, v in runs[run].items():
                runParams.append(k)
                if isinstance(v, list):
                    flowStats[k] = v[j]
                else:
                    flowStats[k] = v

            flowStats["u10_2"] = np.nan
            if readABLFits:
                # read in ABL Fits
                for blockType in flowStats["blockType"].unique():
                    flowStats.loc[flowStats["blockType"] == blockType, "u10_2"] = blockFitsABL.loc[(runIndex, blockType), "u10_2"]


            # correct negative values introduced by flipping for window orientations
            for index, row in flowStats.iterrows():
                if row["mean-sn_prod(abs(u))"] < 0: # this indicates it was flipped since it should always be positive
                    flowStats.loc[index,["mean-sn_prod(abs(u))", "mean-sn_prod(u**2)", "mean-sn_prod(p)"]] *= -1

            roomQois = ["EP_normal", "EP_shear", "EPR_mag", "EP_mag", "u10_2"]
            roomQois += runParams
            roomQois += [q for q in flowStats.columns.values if 'net-' in q or 'mean-' in q]
            roomQois.append("rms-sn_prod(p)")
            roomQois += ['x', 'y', 'z', 'openingType', 'windowNumber']

            sort_order = ["blockType", "houseType", "roomType"]
            roomVentilation = roomStatistics(flowStats, connectedWindows, roomQois)

            roomVentilation = roomVentilation.sort_values(by = sort_order)
            sort_order.append("windowType")
            flowStats = flowStats.sort_values(by = sort_order)

            # room flux probes
            fluxStats = pd.read_csv(fluxStatsPath, index_col=0)
            fluxStats = splitRoomStats(fluxStats)

            volStats = pd.read_csv(volStatsPath, index_col=0)
            volStats = splitRoomStats(volStats)
            volStats = volStats.map(string_to_list)

            roomVolStats = pd.read_csv(roomVolStatsPath, index_col=0)
            roomVolStats = splitRoomStats(roomVolStats)
            roomVolStats = roomVolStats.map(string_to_list)
        
            allFlowStats[runIndex] = flowStats
            allRoomVentilation[runIndex] = roomVentilation
            allFluxStats[runIndex] = fluxStats
            allVolStats[runIndex] = volStats
            allRoomVolStats[runIndex] = roomVolStats

    ### compile into multi-run dfs
    fluxStatsMI = pd.concat(allFluxStats.values(), keys=allFluxStats.keys())
    volStatsMI = pd.concat(allVolStats.values(), keys=allVolStats.keys())
    roomVolStatsMI = pd.concat(allRoomVolStats.values(), keys=allRoomVolStats.keys())

    roomVolStatsMI = processTracerDecay(roomVolStatsMI)
    volStatsMI = processTracerDecay(volStatsMI)

    volStatsMI, _ = processConnectedRooms(volStatsMI)
    fluxStatsMI, _ = processConnectedRooms(fluxStatsMI)

    flowStatsMI = pd.concat(allFlowStats.values(), keys=allFlowStats.keys())
    roomVentilationMI = pd.concat(allRoomVentilation.values(), keys=allRoomVentilation.keys())

    ### process multi-run dfs

    flowStatsMI = pd.concat(allFlowStats.values(), keys=allFlowStats.keys())
    roomVentilationMI = pd.concat(allRoomVentilation.values(), keys=allRoomVentilation.keys())

    roomVentilationMI["nWindows"] = roomVentilationMI[roomQois[0]].apply(lambda l: len(l))
    roomVentilationMI["contResid"] = roomVentilationMI['mean-mass_flux'].apply(lambda l: np.mean(l))
    for qoi in roomQois:
        if fnmatch(qoi, '*mass_flux') or fnmatch(qoi, '*sn_prod(u)') or fnmatch(qoi, '*sn_prod(abs(u))'):  # flow quantities
            roomVentilationMI[qoi] = roomVentilationMI[qoi].apply(lambda l : sum(np.abs(l))/2)
        if fnmatch(qoi, '*mass_flux(?)') or fnmatch(qoi, '*sn_prod(u**2)') or fnmatch(qoi, 'rms-sn_prod(p)'): # net quantities
            roomVentilationMI[qoi] = roomVentilationMI[qoi].apply(lambda l : sum(l))
        elif fnmatch(qoi, '*sn_prod(p)'):
            # roomVentilationMI[qoi] = roomVentilationMI[qoi].apply(lambda l : sum(l))
            pass
        elif qoi in ['x', 'y', 'z']:
            roomVentilationMI[qoi] = roomVentilationMI[qoi].apply(lambda l : np.mean(l))
        elif qoi in runParams:
            roomVentilationMI[qoi] = roomVentilationMI[qoi].apply(lambda l : l[0])
    roomVentilationMI["u10_2"] = roomVentilationMI["u10_2"].apply(lambda l: np.mean(l))
    roomVentilationMI["EPR_mag"] = roomVentilationMI["EPR_mag"].apply(lambda l: np.mean(l))
    roomVentilationMI["EP_shear"] = roomVentilationMI["EP_shear"].apply(lambda l: sum(l))
    roomVentilationMI["EP_mag"] = roomVentilationMI["EP_mag"].apply(lambda l: sum(l))
    roomVentilationMI["EP_normal_mag"] = roomVentilationMI["EP_normal"].apply(lambda l: sum(np.abs(l)))
    roomVentilationMI["EP_normal_sum"] = roomVentilationMI["EP_normal"].apply(lambda l: abs(sum(l)))
    roomVentilationMI["EP_normal_ratio"] = roomVentilationMI["EP_normal_mag"] / (roomVentilationMI["EP_normal_mag"] + roomVentilationMI["EP_normal_sum"])

    flowStatsMI = getWindowOrientations(flowStatsMI)
    roomVentilationMI = getRoomOrientations(roomVentilationMI)

    flowStatsMI["roomA"] = flowStatsMI["roomOrientation"] + flowStatsMI["A"]

    roomVentilationMI = pd.concat([roomVentilationMI, fluxStatsMI, volStatsMI, roomVolStatsMI], axis = "columns")

    # flowStatsMI["houseType"].replace(["0--2", "0--1", "0-0", "0-1", "0-2"], ['3-0', '3-1', '3-2', '3-3', '3-4'], inplace = True)
    # roomVentilationMI["houseType"].replace(["0--2", "0--1", "0-0", "0-1", "0-2"], ['3-0', '3-1', '3-2', '3-3', '3-4'], inplace = True)

    scalar = 'S'
    calc = "mean"
    qoi = f"{calc}-mass_flux({scalar})"

    roomVentilationMI[f"{calc}-mass_flux-roomCeil-slEx"] = roomVentilationMI[f"{calc}-mass_flux-roomCeil"]
    roomVentilationMI[f"{qoi}-roomCeil-slEx"] = roomVentilationMI[f"{qoi}-roomCeil"]
    for index, row in roomVentilationMI.iterrows():
        windowKeys = row["windowKeys"]

        skylight_flow = 0
        skylight_flux = 0
        for window in row["windowKeys"]:
            if "skylight" in window:
                skylight_flow += flowStatsMI.loc[(index[0], window), f"{calc}-mass_flux"]
                skylight_flux += flowStatsMI.loc[(index[0], window), qoi]
        roomVentilationMI.loc[index, f"{calc}-mass_flux-roomCeil-slEx"] += skylight_flow
        roomVentilationMI.loc[index, f"{qoi}-roomCeil-slEx"] += skylight_flux

    errorCeil = roomVentilationMI[f"{calc}-mass_flux-roomCeil-slEx"] * roomVentilationMI[f"mean-{scalar}-room5"]
    errorFloor = roomVentilationMI[f"{calc}-mass_flux-roomFloor"] * roomVentilationMI[f"mean-{scalar}-room0"]

    roomVentilationMI[f"{qoi}-roomCeil-Zeroed"] = roomVentilationMI[f"{qoi}-roomCeil-slEx"] - errorCeil
    roomVentilationMI[f"{qoi}-roomFloor-Zeroed"] = roomVentilationMI[f"{qoi}-roomFloor"] - errorFloor

    roomVentilationMI[f"{qoi}-roomCeil-Zeroed"] = -roomVentilationMI[f"{qoi}-roomCeil-Zeroed"] # flipping because down is away from ceiling
    roomVentilationMI[f"{qoi}-roomWalls-Zeroed"] = -(roomVentilationMI[qoi] + roomVentilationMI[f"{qoi}-roomCeil-Zeroed"] + roomVentilationMI[f"{qoi}-roomFloor-Zeroed"])

    roomVentilationMI[f"{qoi}-roomCeil-perA"] = np.nan
    roomVentilationMI[f"{qoi}-roomFloor-perA"] = np.nan
    roomVentilationMI[f"{qoi}-roomWalls-perA"] = np.nan

    for index, row in roomVentilationMI.iterrows():
        room = row["roomType"]

        if "sl" in row["houseType"] or row["slAll"]:
            ceilA = room_areas["ceilings"][room]
        else:
            ceilA = room_areas["floors"][room]
        roomVentilationMI.loc[index, f"{qoi}-roomCeil-perA"] = row[f"{qoi}-roomCeil-Zeroed"] / ceilA
        roomVentilationMI.loc[index, f"{qoi}-roomFloor-perA"] = row[f"{qoi}-roomFloor-Zeroed"] / room_areas["floors"][room]
        roomVentilationMI.loc[index, f"{qoi}-roomWalls-perA"] = row[f"{qoi}-roomWalls-Zeroed"] / room_areas["walls"][room]

    T_in = roomVentilationMI[f"mean-{scalar}-room"]
    T_S = 1
    for surface in ["roomCeil", "roomFloor", "roomWalls"]:
        col = f"{qoi}-{surface}"
        roomVentilationMI[f"{col}-h"] = Cp * roomVentilationMI[f"{col}-perA"] / (T_S - T_in)

    flowStatsMI = fillInParams(flowStatsMI, velTenMeters)
    roomVentilationMI = fillInParams(roomVentilationMI, velTenMeters)
    roomVentilationMI = expand_variable_length_sequences(roomVentilationMI)

    if saveResults:
        flowStatsMI.to_csv(f"{multiRun_dir}/flowStatsMI.csv")
        roomVentilationMI.to_csv(f"{multiRun_dir}/roomVentilationMI.csv")

    return flowStatsMI, roomVentilationMI

def combine_stats(df, group, index_col = None):
    df = df.copy()
    rms_cols = [col for col in df.columns if "rms" in col]
    df[rms_cols] = df[rms_cols] ** 2
    
    df.index.names = ["run_id", "key"]
    df = df.reset_index()
    if index_col is None:
        index_col = "run_id"
    else:
        df[index_col] = df[index_col] * 10 + df["run_id"] % 10
        
    string_cols = df.select_dtypes(include=["object", "string"]).columns.tolist()
    group += string_cols
    print(f"Grouping by {group}")
    df = df.groupby(group, as_index=False, dropna=False).mean(numeric_only=True)
    
    df = df.set_index([index_col, "key"])

    df[rms_cols] = df[rms_cols] ** 0.5

    return df

def replace_sl_with_h(lbl):
    if type(lbl) == str:
        return lbl.replace("sl", "h_-1-0")
    return lbl

def replace_sl_with_h_df(df, level=1):
    df.rename(index=replace_sl_with_h, level=level, inplace=True)
    for col in df.columns:
        if "windowKeys" in col:
            df[col] = df[col].apply(replace_sl_with_h)
        if "houseType" in col:
            df[col] = df[col].apply(lambda s: s.replace("sl", "-1-0"))
    return df


#### Pressure-only (no-interior) opening stats for the flow model ####

def _read_noint_stats(path):
    """One pressure-only run's opening stats (probes/flowStats-*.csv) with the columns suffixed "-noInt"."""
    stats = pd.read_csv(path, index_col=0)
    stats.index = stats.index.map(lambda name: name if name.split("_")[-1][0] == "B" else f"{name}_B")
    stats.index.name = None
    stats.columns = [str(col).replace('-119000', '') + "-noInt" for col in stats.columns]
    return stats


def _combine_noint_stats(frames):
    """Average member runs' stats as combine_stats does: numeric columns averaged (rms columns in
    quadrature); other columns (opening metadata) must agree and are taken from the first frame."""
    if len(frames) == 1:
        return frames[0].copy()
    index = frames[0].index
    frames = [f.loc[index] for f in frames]
    out = frames[0].copy()
    for col in out.columns:
        if pd.api.types.is_numeric_dtype(out[col]):
            vals = np.stack([f[col].to_numpy(float) for f in frames])
            out[col] = np.sqrt((vals**2).mean(axis=0)) if "rms" in col else vals.mean(axis=0)
        else:
            for f in frames[1:]:
                same = (f[col].astype(str) == out[col].astype(str)) | (f[col].isna() & out[col].isna())
                if not same.all():
                    raise ValueError(f"pressure-only runs disagree on {col}")
    return out


def assign_noint_pressures(flowStatsMI, runsNoInt, home_dir, runs_csv=None, use_matched=True,
                           require_all=True, unmatched_sources=(), combined=True, verbose=True):
    """Pressure-only opening stats for every run in flowStatsMI, replacing the old one-run-per-case
    assignment.

    combined=True: flowStatsMI is the output of combine_stats (index: combined run id csId*10 + V,
        opening) and each run's member interior runs are read from runs_csv (the per-run
        flowStatsMI.csv). combined=False: flowStatsMI is per run (index: run id C*1000 + R*10 + V,
        opening), so each run is its own single member and is compared 1:1 with its own twin; runs_csv
        and require_all are then unused. The two id schemes overlap (e.g. 2530 is both the combined
        R46+R53 and R53 ΔT 0), so the caller has to say which one flowStatsMI uses.

    For each run, each member interior run uses
    its matched pressure-only twin (setup_matched_noint_runs.matched_run: CHARLES/config<C>/R76-R99,
    restarted from that interior run, file probes/flowStats-42000to119000.csv for ΔT 0 or
    -162000to240000.csv for ΔT 5) when the twin's file exists, otherwise the old pressure-only run of
    the same C, A, WS (runsNoInt, probes/flowStats-40000to119000.csv). Members are averaged as
    combine_stats averages the interior runs (rms in quadrature).

    require_all: use the twins for a combined run only if every member's twin is available, so each
        row is either fully matched or fully old. With False, members fall back one by one. Moot
        with combined=False (one member per run).
    unmatched_sources: (C, R) interior runs whose current stats do not come from the run their twins
        were restarted from; these always use the old pressure-only run. Empty since config2 R48 was
        reprocessed from its 2026 rerun (the run its twins R78, R90 were restarted from). Pass
        ((2, 48),) only with a flowStatsMI.csv built from the 2024 R48 stats (R48/run2024/probes).
    use_matched=False reproduces the old assignment.

    Returns (pcStatsMI, sources): pcStatsMI is indexed (run, index) with the "-noInt" columns the
    notebook has always used, plus pOnly_nMatched / pOnly_nMembers (floats) and pOnly_runs (str);
    sources lists, per run, where each member's pressures came from.
    """
    from setup_matched_noint_runs import matched_run

    run_ids = np.sort(flowStatsMI.index.get_level_values(0).unique())
    if combined:
        if runs_csv is None:
            runs_csv = f"{home_dir}/CHARLES/multiRuns/flowStatsMI.csv"
        runs = pd.read_csv(runs_csv, index_col=[0, 1])
        runs = runs.groupby(level=0)[["csId", "C", "A", "WS"]].first()
        members = {}
        for run_id, row in runs.iterrows():
            members.setdefault(int(row.csId) * 10 + int(run_id) % 10, []).append(int(run_id))
    else:
        members = {int(run): [int(run)] for run in run_ids}

    noIntRuns = pd.DataFrame(runsNoInt).T
    unmatched_sources = {tuple(s) for s in unmatched_sources}
    cache, pcStats, sources = {}, [], []

    def read(path):
        if path not in cache:
            cache[path] = _read_noint_stats(path)
        return cache[path]

    for run in run_ids:
        first = flowStatsMI.loc[run].iloc[0]
        A, WS, C, V = first["A"], first["WS"], int(first["C"]), int(run) % 10
        old = noIntRuns[(noIntRuns["A"] == A) & (noIntRuns["WS"] == WS) & (noIntRuns["C"] == C)].index[0]
        old_path = f"{home_dir}/CHARLES/config{C}/R{old % 100}/probes/flowStats-40000to119000.csv"

        chosen = []
        for m in members[int(run)]:
            src = (m // 10) % 100
            twin = matched_run(C, src, V) if use_matched and (C, src) not in unmatched_sources else None
            path = twin and f"{home_dir}/CHARLES/config{C}/R{twin[0]}/probes/{twin[1]}"
            if path and os.path.exists(path):
                chosen.append((m, f"R{twin[0]}", path, True))
            else:
                chosen.append((m, f"R{old % 100} (old)", old_path, False))
        if require_all and not all(c[3] for c in chosen):
            chosen = [(m, f"R{old % 100} (old)", old_path, False) for m, *_ in chosen]

        paths = list(dict.fromkeys(c[2] for c in chosen))
        stats = _combine_noint_stats([read(p) for p in paths])
        n_matched = sum(c[3] for c in chosen)
        stats["run"] = run
        stats["run-noInt"] = old * 10 + V if n_matched == 0 else np.nan
        stats["pOnly_nMatched"] = float(n_matched)
        stats["pOnly_nMembers"] = float(len(chosen))
        stats["pOnly_runs"] = "+".join(dict.fromkeys(c[1] for c in chosen))
        stats = replace_sl_with_h_df(stats, level=0)
        pcStats.append(stats)
        for m, label, _, matched in chosen:
            sources.append({"run": run, "C": C, "A": A, "WS": WS, "V": V, "interior run": f"R{(m // 10) % 100}",
                            "pressures from": f"config{C} {label}", "matched": matched})

    pcStatsMI = pd.concat(pcStats, axis="rows").reset_index().set_index(["run", "index"])
    sources = pd.DataFrame(sources)
    if verbose:
        per_run = sources.groupby("run")["matched"].agg(["sum", "size"])
        kind = "combined runs" if combined else "runs (per run, not combined)"
        print(f"pressure-only stats: {int((per_run['sum'] == per_run['size']).sum())} of {len(per_run)} {kind} "
              f"use matched twins ({int(sources['matched'].sum())} of {len(sources)} member runs)")
    return pcStatsMI, sources
