import numpy as np
from scipy.optimize import minimize
from tqdm import tqdm
from pyCascade import utils
import pyafn

hm = 6
hr = hm / 2
# window_dim = hr/4
# A = window_dim ** 2 
A = 1 # predicting per area flux, so A is already included in flux

def getRoomTemp(row, tempStack=False):
    if tempStack:
        stack = []
        for i in range(6):
            stack.append(row[f"mean-T-room{i}"])
        return stack
    else:
        return row["mean-T-room"]

def update_flow_and_ventilation(flowStatsMI, roomVentilationMI, useDoors=True, pTypes = {"p-noInt": "p_avg-noInt"}, optTypes = ["optp0", "optp0Cd"], tempStack=False, doorCd=0.6, checkAnalytical=False):
    flowStatsMI = flowStatsMI.copy()
    roomVentilationMI = roomVentilationMI.copy()

    for pType in pTypes:
        roomVentilationMI[f"{pType}-success"] = False
    print(f"Processung {roomVentilationMI.shape[0]} rooms")
    for (run, room), row in tqdm(roomVentilationMI.iterrows()):
        flowParams = {
            "C_d": [],
            "A": [],
            "z": [],
            "delT": [],
            "q": [],
            "rooms": [],
            "hr": 3
        }
        windowKeyCols = roomVentilationMI.columns[
            roomVentilationMI.columns.str.contains("windowKeys")
        ].tolist()
        windowKeys = row[windowKeyCols].dropna()
        delT = getRoomTemp(row, tempStack=tempStack)
        for pType in pTypes:
            flowParams[pType] = []
        for windowKey in windowKeys:
            for pType, pCol in pTypes.items():
                flowParams[pType].append(flowStatsMI.loc[(run, windowKey), pCol])

            C_d = flowStatsMI.loc[(run, windowKey), "C_d"]
            if "pRMS" in flowStatsMI.columns:
                if "pRMS" not in flowParams:
                    flowParams["pRMS"] = []
                flowParams["pRMS"].append(flowStatsMI.loc[(run, windowKey), "pRMS"])
            if "qRMS" in flowStatsMI.columns:
                if "qRMS" not in flowParams:
                    flowParams["qRMS"] = []
                flowParams["qRMS"].append(flowStatsMI.loc[(run, windowKey), "qRMS"])
            flowParams["C_d"].append(C_d)
            flowParams["A"].append(A)
            flowParams["z"].append(flowStatsMI.loc[(run, windowKey), "y"])  # y is vertical in simulation
            flowParams["delT"].append(delT)
            flowParams["q"].append(flowStatsMI.loc[(run, windowKey), "flux"])
            if "dual" in room and useDoors:
                roomCord = windowKey.split("_")[1]
                if roomCord == "0-1":
                    roomRow = [1, 0]
                elif roomCord == "1-1":
                    roomRow = [0, 1]
                else:
                    raise Exception(f"Unrecognized room {roomCord} in dual room")
            else:
                roomRow = [1]
            flowParams["rooms"].append(roomRow)

        if "dual" in room and useDoors:
            for pType in pTypes:
                flowParams[pType].append(0)
            flowParams["C_d"].append(doorCd)
            flowParams["A"].append(A * 3)
            flowParams["z"].append(hr / 2)
            flowParams["delT"].append(np.zeros_like(delT)) # the temperature is modeled as equal in both rooms
            qRooms = np.matmul(np.array(flowParams["rooms"]).T, np.array(flowParams["q"]))
            flowParams["q"].append(np.diff(qRooms)[0])
            flowParams["rooms"].append([1, -1])
            if "pRMS" in flowParams:
                flowParams["pRMS"].append([0, 0])
            if "qRMS" in flowParams:
                flowParams["qRMS"].append([0, 0])

        flowParams = utils.dict_apply(np.array)(flowParams)

        for pType in pTypes:
            NRooms = flowParams["rooms"].shape[1]
            flowParams["p_w"] = flowParams[pType]
            p0_meas = [row["mean-p-room"] for i in range(NRooms)]
            C_ds = pyafn.getC(np.array(p0_meas), flowParams)

            for i, windowKey in enumerate(windowKeys):
                flowStatsMI.loc[(run, windowKey), f"{pType}-C_d"] = C_ds[i]

            n_rooms = flowParams["rooms"].shape[1]
                    
            for optType in optTypes:
                if optType == "optp0":
                    optResult = pyafn.findOptimalP0(flowParams, checkAnalytical=checkAnalytical)
                elif optType == "optp0Cd":
                    optResult = pyafn.findOptimalP0AndC(flowParams)
                else:
                    raise ValueError(f"Unknown optimization type: {optType}")
                
                flowParamsOpt = flowParams.copy()
                p0 = optResult.x[0:n_rooms]
                if optType == "optp0Cd":
                    flowParamsOpt["C_d"] = optResult.x[n_rooms:]

                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-p0"] = np.mean(p0)
                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-success"] = optResult.success
                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-fun"] = optResult.fun
                qs = pyafn.flowField(np.array(p0), flowParamsOpt)
                Cd = flowParamsOpt["C_d"]
                Cd_col = f"{pType}_{optType}-C_d"
                if len(Cd.shape) == 2 and Cd_col not in flowStatsMI.columns:
                    flowStatsMI[Cd_col] = None
                    flowStatsMI[Cd_col] = flowStatsMI[Cd_col].astype(object)


                for i, windowKey in enumerate(windowKeys):
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-q_model"] = qs[i]
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-netq_model"] = abs(qs[i])
                    flowStatsMI.at[(run, windowKey), f"{pType}_{optType}-C_d"] = Cd[i]
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-p0"] = np.mean(p0)
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-success"] = optResult.success
                    flowStatsMI.loc[(run, windowKey), f"p0meas"] = np.mean(p0_meas)

                if "dual" in room and useDoors:
                    qs = qs[0:-1]
                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-q_model"] = np.sum(abs(np.array(qs))) / 2
        
            

    return flowStatsMI, roomVentilationMI


