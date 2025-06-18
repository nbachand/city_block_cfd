import numpy as np
from scipy.optimize import minimize
from tqdm import tqdm
from pyCascade import utils

g = 10
beta = 0.0034
rho = 1.225
hm = 6
window_dim = hm/2/4
A = window_dim ** 2

def getWindBuoyantP(rho, flowParams):
    p_w = flowParams["p_w"]
    z = flowParams["z"]
    delT = flowParams["delT"]
    delrho = -rho * beta * delT
    return (delrho * g * z) + p_w # delP is outdoor minus indoor, while p0/rho is indoor minus outdoor, driving positive flow into the room (oppiste textbook)

def flowFromP(rho, C_d, A, delp):
    delp=np.array(delp)
    S = np.sign(delp)
    return S * C_d * A * np.sqrt(2 * abs(delp) / rho)

def CFromFlow(rho, q, A, delp):
    delp = np.array(delp, dtype=float)
    # prepare output filled with NaNs
    C = np.full_like(delp, np.nan, dtype=float)
    # mask non‐NaN, non‐zero delp
    mask = ~np.isnan(delp) & (delp != 0)
    S = np.sign(delp[mask])
    C[mask] = q[mask] / (S * A[mask] * np.sqrt(2 * np.abs(delp[mask]) / rho))
    return C

def flowField(p_0, rho, flowParams):
    C_d = flowParams["C_d"]
    A = flowParams["A"]
    rooms = flowParams["rooms"]
    delP = -np.matmul(rooms, p_0) + getWindBuoyantP(rho, flowParams) 
    return flowFromP(rho, C_d, A, delP)

def getC(p_0, rho, flowParams):
    A = flowParams["A"]
    q = flowParams["q"]
    rooms = flowParams["rooms"]
    delP = -np.matmul(rooms, p_0) + getWindBuoyantP(rho, flowParams)
    return CFromFlow(rho, q, A, delP)

def qObjective(p_0, rho, flowParams):
    qs = flowField(p_0, rho, flowParams)
    rooms = flowParams["rooms"]
    qRooms = np.matmul(rooms.T, qs)
    return np.sum(qRooms**2)

def findOptimalP0(rho, flowParams):
    bounds = np.array([np.min(getWindBuoyantP(rho, flowParams)), np.max(getWindBuoyantP(rho, flowParams))])
    x0 = np.mean(bounds)
    NRooms = flowParams["rooms"].shape[1]
    bounds = np.tile(bounds, (NRooms, 1))
    x0 = np.tile(x0, NRooms)
    return minimize(qObjective, x0=x0, bounds=bounds, args=(rho, flowParams))


##############

def matchObjective(x, rho, flowParams, weight):
    """
    Objective = 
      1) sum of squared errors between predicted opening flows and target flows
      2) + weight × variance(C_d)
    x = [p0_1 ... p0_N, Cd_1 ... Cd_M]
    """
    rooms   = flowParams["rooms"]
    N       = rooms.shape[1]    # # rooms
    M       = rooms.shape[0]    # # openings

    # unpack decision vector
    p_0 = x[:N]
    Cd = x[N:]

    # compute driving pressures
    params    = flowParams.copy()
    params["C_d"] = Cd
    delP = -np.matmul(rooms, p_0) + getWindBuoyantP(rho, flowParams)

    # 1) predicted opening flows
    qs_pred = flowFromP(rho, Cd, params["A"], delP)

    # 2) flow-matching error (per opening)
    q_target = params["q"]
    f1 = np.sum((qs_pred - q_target)**2)

    # 3) uniform-C penalty (variance)
    meanCd = np.mean(Cd)
    f2     = np.sum((Cd - meanCd)**2)

    return f1 + weight * f2

def findOptimalP0AndC(rho, flowParams, weight=1, disp=False):
    """
    Minimize matchObjective over p0 (N vars) and Cd (M vars).
    Returns OptimizeResult with .x = [p0*, Cd*].
    """
    rooms = flowParams["rooms"]
    N     = rooms.shape[1]
    M     = rooms.shape[0]

    # bounds for p0: between min/max wind-buoyancy pressures
    WBP      = getWindBuoyantP(rho, flowParams)
    p_bounds = [(np.min(WBP), np.max(WBP))] * N

    # bounds for Cd: e.g. [1e-3, 5.0]
    C_bounds = [(1e-3, 5.0)] * M
    bounds   = p_bounds + C_bounds

    # initial guess: mid-range p0, mean(C_d)
    x0 = np.concatenate([
        np.full(N, np.mean(WBP)),
        np.full(M, np.mean(flowParams["C_d"]))
    ])

    res = minimize(
        matchObjective,
        x0=x0,
        args=(rho, flowParams, weight),
        bounds=bounds,
        method="L-BFGS-B",
        options={"disp": disp}
    )
    return res


##############


def getC_ds_AofA(aCorner, aCross, aDual, aSingle, aSinA, aCosA, AofA = 180, roomType="corner"):
    AofA *= np.pi / 180
    C_d = aSinA * np.sin(AofA) + aCosA * np.cos(AofA)
    if roomType == "corner":
        return C_d + aCorner
    if roomType == "cross":
        return C_d + aCross
    if roomType == "dual":
        return C_d + aDual
    if roomType == "single":
        return C_d + aSingle
    
def getC_ds_AofA2(aCorner, aCross, aSingle, aCornerSinA, aCrossSinA, AofA = 180, roomType="corner"):
    AofA *= np.pi / 180
    if roomType == "corner":
        return aCornerSinA * np.sin(AofA) + aCorner
    if roomType == "cross":
        return aCrossSinA * np.sin(AofA) + aCross
    if roomType == "dual":
        return aCornerSinA * np.sin(AofA) + aCorner
    if roomType == "single":
        return aSingle

def getC_ds_AofA3(aCorner, aCross, aDual, aSingle, aSinA, aCosA, sSin2a, aCos2A, AofA = 180, roomType="corner"):
    AofA *= np.pi / 180
    C_d = aSinA * np.sin(AofA) + aCosA * np.cos(AofA) + sSin2a * np.sin(2 * AofA) + aCos2A * np.cos(2 * AofA)
    if roomType == "corner":
        return C_d + aCorner
    if roomType == "cross":
        return C_d + aCross
    if roomType == "dual":
        return C_d + aDual
    if roomType == "single":
        return C_d + aSingle

def getC_ds_EP(aCorner, aCross, aDual, aSingle, aShear, aNormal, shear=0, normal=0, roomType="corner"):
    C_d = aShear * shear + aNormal * normal
    if roomType == "corner":
        return C_d + aCorner
    if roomType == "cross":
        return C_d + aCross
    if roomType == "dual":
        return C_d + aDual
    if roomType == "single":
        return C_d + aSingle

def getC_ds_All(aCorner, aCross, aDual, aSingle, aSinA, aCosA,  aShear, aNormal, aWS, AofA = 180, shear=0, normal=0, WS=0, roomType="corner"):
    AofA *= np.pi / 180
    C_d = aSinA * np.sin(AofA) + aCosA * np.cos(AofA) + aShear * shear + aNormal * normal + aWS * WS
    if roomType == "corner":
        return C_d + aCorner
    if roomType == "cross":
        return C_d + aCross
    if roomType == "dual":
        return C_d + aDual
    if roomType == "single":
        return C_d + aSingle

def getC_ds_opening(aX, aZ, aXSinA, aZSinA, aXCosA, aZCosA, AofA=0, openingType="xwindow"):
    AofA *= np.pi / 180
    if openingType == "xwindow":
        return aX + aXSinA * np.sin(AofA) + aXCosA * np.cos(AofA)
    if openingType == "zwindow":
        return aZ + aZSinA * np.sin(AofA) + aZCosA * np.cos(AofA)

def getC_ds(params, typeC_d="AofA", AofA=0, shear=0, normal=0, openingType="xwindow", roomType="corner"):
    if typeC_d == "AofA":
        return getC_ds_AofA(*params, AofA=AofA, roomType=roomType)
    if typeC_d == "AofA2":
        return getC_ds_AofA2(*params, AofA=AofA, roomType=roomType)
    if typeC_d == "AofA3":
        return getC_ds_AofA3(*params, AofA=AofA, roomType=roomType)
    if typeC_d == "EP":
        return getC_ds_EP(*params, shear=shear, normal=normal, roomType=roomType)
    if typeC_d == "All":
        return getC_ds_All(*params, AofA=AofA, shear=shear, normal=normal, WS=1, roomType=roomType)
    if typeC_d == "opening":
        return getC_ds_opening(*params, openingType=openingType)



def update_flow_and_ventilation(flowStatsMI, roomVentilationMI, paramsC_d, useDoors=True, pTypes = {"p-noInt": "p_avg-noInt"}, typeC_d="AofA"):
    flowStatsMI = flowStatsMI.copy()
    roomVentilationMI = roomVentilationMI.copy()
    flowStatsMI["cosAofA"] = np.round(np.cos(flowStatsMI["AofA"] * np.pi / 180), 2)
    flowStatsMI["sinAofA"] = np.round(np.sin(flowStatsMI["AofA"] * np.pi / 180), 2)

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
        }
        windowKeyCols = roomVentilationMI.columns[
            roomVentilationMI.columns.str.contains("windowKeys")
        ].tolist()
        windowKeys = row[windowKeyCols].dropna()

        for pType in pTypes:
            flowParams[pType] = []
        for windowKey in windowKeys:
            for pType, pCol in pTypes.items():
                flowParams[pType].append(flowStatsMI.loc[(run, windowKey), pCol])
            C_d = getC_ds(
                paramsC_d,
                typeC_d = typeC_d,
                AofA=flowStatsMI.loc[(run, windowKey),"AofA"], 
                shear=flowStatsMI.loc[(run, windowKey),"EP_shear"], 
                normal=flowStatsMI.loc[(run, windowKey),"EP_normal"],
                openingType = flowStatsMI.loc[(run, windowKey),"openingType"],
                roomType = row["roomType"],
                )
            flowParams["C_d"].append(C_d)
            flowParams["A"].append(A)
            flowParams["z"].append(flowStatsMI.loc[(run, windowKey), "y"])  # y is vertical in simulation
            flowParams["delT"].append(row["mean-T-room"])
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
            H = 3
            for pType in pTypes:
                flowParams[pType].append(0)
            flowParams["C_d"].append(1)
            flowParams["A"].append(A * 3)
            flowParams["z"].append(H / 2)
            flowParams["delT"].append(row["mean-T-room"])
            qRooms = np.matmul(np.array(flowParams["rooms"]).T, np.array(flowParams["q"]))
            flowParams["q"].append(np.diff(qRooms)[0])
            flowParams["rooms"].append([1, -1])

        flowParams = utils.dict_apply(np.array)(flowParams)

        for pType in pTypes:
            NRooms = flowParams["rooms"].shape[1]
            flowParams["p_w"] = flowParams[pType]
            p0_meas = [row["mean-p-room"] for i in range(NRooms)]
            C_ds = getC(np.array(p0_meas), rho, flowParams)

            for i, windowKey in enumerate(windowKeys):
                flowStatsMI.loc[(run, windowKey), f"{pType}-C_d"] = C_ds[i]

            n_rooms = flowParams["rooms"].shape[1]
            optResults = {"optp0": findOptimalP0(rho, flowParams),
                            "optp0Cd": findOptimalP0AndC(rho, flowParams, weight=1e-6)}
            for optType, optResult in optResults.items():
                flowParamsOpt = flowParams.copy()
                p0 = optResult.x[0:n_rooms]
                if optType == "optp0Cd":
                    flowParamsOpt["C_d"] = optResult.x[n_rooms:]

                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-p0"] = np.mean(p0)
                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-success"] = optResult.success
                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-fun"] = optResult.fun
                qs = flowField(np.array(p0), rho, flowParamsOpt)

                for i, windowKey in enumerate(windowKeys):
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-q_model"] = qs[i]
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-netq_model"] = abs(qs[i])
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-C_d"] = flowParamsOpt["C_d"][i]
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-p0"] = np.mean(p0)
                    flowStatsMI.loc[(run, windowKey), f"{pType}_{optType}-success"] = optResult.success
                    flowStatsMI.loc[(run, windowKey), f"p0meas"] = np.mean(p0_meas)

                if "dual" in room and useDoors:
                    qs = qs[0:-1]
                roomVentilationMI.loc[(run, room), f"{pType}_{optType}-q_model"] = np.sum(abs(np.array(qs))) / 2
        
            

    return flowStatsMI, roomVentilationMI


