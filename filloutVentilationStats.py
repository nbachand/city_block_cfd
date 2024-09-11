import pandas as pd
from fnmatch import fnmatch
from pyCascade import physics
import itertools
import numpy as np

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
    
    EP_mag = []
    EP_vel_orientation = []
    EP_normal = []
    EP_shear = []
    EPR_mag = []
    EPR_vel_orientation = []
    if extraProbe is not None:
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
            for qoi in roomQois:
                roomVentilation[roomKey][qoi] = [] #initlialize list for extra probes
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
            if fnmatch(col, '*sn_prod(u**2)"'):
                udim = 2
            else:
                udim = 1
            new_columns[f"{col}-Norm"] = df[col] / (df["WS"] / velTenMeters)**udim
            new_columns[f"{col}-NormEP"] = df[col] / (df["EP_mag"] / velTenMeters)**udim
            new_columns[f"{col}-NormEPR"] = df[col] / (df["EPR_mag"] / velTenMeters)**udim

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