import numpy as np
import pyafn
from pyafn import rho, Cd, g, beta

angles = np.arange(0, 360, 45)  # Angles from 0 to 360 degrees in 1-degree increments

windows = {
    "small_face_A" : {
        0: 0.7,
        45: 0.45,
        60: 0.65,
        90: -0.5,
        135: -0.3,
        150: -0.26,
        180: -0.14,
        210: -0.26,
        225: -0.3,
        270: -0.3,
        300: 0.4,
        315: 0.2,
    },
    "large_face_B" : {
        0: 0.75,
        45: 0.5,
        60: 0.2,
        90: -0.4,
        120: -0.6,
        135: -0.55,
        180: -0.43,
        225: -0.3,
        240: -0.3,
        270: -0.2,
        300: 0.125,
        315: 0.2
    },
    "large_face_AB" : {
        0: 0.8,
        45: 0.35,
        60: 0.2,
        90: -0.2,
        120: -0.4,
        135: -0.4,
        180: -0.43,
        225: -0.4,
        240: -0.4,
        270: -0.2,
        300: 0.2,
        315: 0.35,
    }
}

rooms = {
    "Corner": {
        "small_face_A": 0,
        "large_face_B": 45,
    },
    "Dual-Room": {
        "small_face_A": 0,
        "large_face_B": 315,
        "large_face_AB": 315,
    },
    "Single-Sided":{
        "large_face_AB": 315,
    },
    "Cross-Ventilated": {
        "large_face_B": 45,
        "large_face_B": 315,
    }
}

for room_name, room_dict in rooms.items():
    for wind_angle in angles:
        p_w = []
        for window, angle in room_dict.items():
            effective_angle = (wind_angle + angle) % 360
            Cp = windows[window][effective_angle]
            p_w.append(Cp * 0.5 * rho * (1 ** 2))

        N = len(p_w)

        flowParams = pyafn.createFlowParams(
            C_d=[Cd for _ in range(N)],
            A=[1 for _ in range(N)],
            p_w=p_w,
            z=[1.5 for _ in range(N)],
            delT=[0 for _ in range(N)],
            rooms=[[1] for i in range(N)],
            hr=3
        )

        optResults = pyafn.findOptimalP0(flowParams)
        p_0s = optResults.x

        print(f"\nOptimization Status: {optResults.message}")
        print(f"Success: {optResults.success}")
        print(f"\nOptimal indoor pressure: {p_0s[0]:.4f} Pa")
        print(f"Final objective value: {optResults.fun:.6e}")

        print("\nFlow rates at optimal pressure (m³/s):")
        flows = pyafn.flowField(p_0s, flowParams)
        print(flows)