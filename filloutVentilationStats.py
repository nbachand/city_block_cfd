import pandas as pd
from fnmatch import fnmatch

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
    df["Params"] = Params
    for param in ["mean", "net"]:
        df[f"{param}Norm"] = df[param] / df["WS"] * velTenMeters
        df[f"{param}NormEPR"] = df[param] / df["EPR_mag"] * velTenMeters
        # df["f{param}NormFractional"] = df[f"{param}Norm] / 
    # display(df)
    df.sort_values(["C", "WS", "B"])
    return df