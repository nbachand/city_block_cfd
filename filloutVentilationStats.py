import pandas as pd
from fnmatch import fnmatch
from pyCascade import physics
import itertools

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

def fillInParams(df, runs, velTenMeters):


    for run in runs:
        runs[run]["Ri"] = physics.getVentRi(runs[run]["delT"] * runs[run]['B'], runs[run]["WS"])

    A = pd.Series(index = df.index, dtype = float)
    AofA = pd.Series(index = df.index, dtype = float)
    WS = pd.Series(index = df.index, dtype = float)
    Buoyancy = pd.Series(index = df.index, dtype = bool)
    category = pd.Series(index = df.index, dtype = str)
    delT = pd.Series(index = df.index, dtype = float)
    delTPart = pd.Series(index = df.index, dtype = float)
    Ri = pd.Series(index = df.index, dtype = str)
    Params = pd.Series(index = df.index, dtype = str)
    for index, row in df.iterrows():
        run = index[0]
        A[index] = runs[run]["A"]
        AofA[index] = (row["orientation"] + A[index]) % 360
        WS[index] = runs[run]["WS"]
        Buoyancy[index] = runs[run]["B"]
        category[index] = runs[run]["C"]
        delT[index] = runs[run]["delT"]
        delTPart[index] = runs[run]["delTPart"]
        Ri[index] = runs[run]["Ri"]
        Params[index] = f"Wind Speed: {WS[index]} m/s; Ri = {Ri[index]:.2f}; T Partition = {delTPart[index]}"
        if category[index] == 2:
            Params[index] += "; High Density"
        elif category[index] == 3:
            Params[index] += "; Low Density"
    df["A"] = A
    df["AofA"] = AofA
    df["AofA_str"] = AofA.apply(lambda i: str(i))
    df["AofA_resid"] = AofA.apply(lambda i: str(i%90))
    df["WS"] = WS
    df["B"] = Buoyancy
    df["C"] = category
    df["Ri"] = Ri
    df["delT"] = delT
    df["delTPart"] = delTPart
    df["delTPartRatio"] = delTPart/delT
    df["delTPartRatio"].fillna(0, inplace = True)
    df["Params"] = Params
    for param in ["mean", "net"]:
        df[f"{param}Norm"] = df[param] / df["WS"] * velTenMeters
        df[f"{param}NormEPR"] = df[param] / df["EPR_mag"] * velTenMeters
        # df["f{param}NormFractional"] = df[f"{param}Norm] / 
    # display(df)
    df.sort_values(["C", "WS", "B"])
    return df


def getComparativeDf(df, split_cols, sort_cols = ['WS', 'AofA', 'C', 'Ri', 'delTPartRatio', 'roomType', 'houseType', 'blockType']):
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