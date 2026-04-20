import numpy as np
import matplotlib.pyplot as plt
import pyafn
from pyafn import rho, Cd, g, beta
import pandas as pd

angles = np.arange(0, 360, 45)  # Angles from 0 to 360 degrees in 1-degree increments

shelter_class = {
    "small_face_A" : 5,
    "large_face_B" : 4,
    "large_face_AB" : 4,
}

shelter_factor = {
    1: 1.00,
    2: 0.90,
    3: 0.70,
    4: 0.50,
    5: 0.30,
}

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
    },
    "door": {
        0: 0,
        45: 0,
        60: 0,
        90: 0,
        120: 0,
        135: 0,
        180: 0,
        225: 0,
        240: 0,
        270: 0,
        300: 0,
        315: 0,
    }
}

rooms = {
    "cross": {
        "windows": [
            ("large_face_B", 90),
            ("large_face_B", 270),
        ],
        "window_equivalent":
        [
            "zwindow_2-0",
            "zwindow_2-1"
        ],
        "rooms": [[1], [1]],
        "A": [1, 1]
    },
    "corner": {
        "windows": [
            ("small_face_A", 0),
            ("large_face_B", 90),
        ],
        "window_equivalent":
        [
            "xwindow_0-0",
            "zwindow_0-0"
        ],
        "rooms": [[1], [1]],
        "A": [1, 1]
    },
    "dual": {
        "windows": [
            ("small_face_A", 0),
            ("large_face_B", 270),
            ("large_face_AB", 270),
            ("door", 0)
        ],
        "window_equivalent":
        [
            "xwindow_0-1",
            "zwindow_0-1",
            "zwindow_1-1",
            "door_1-1"
        ],
        "rooms": [[1, 0], [1, 0], [0, 1], [1, -1]],
        "A": [1, 1, 1, 3]
        # "rooms": [[1], [1], [1]],
        # "A": [1, 1, 1]
    },
    "single": {
        "windows": [
            ("large_face_AB", 90)
        ],
        "window_equivalent":
        [
            "zwindow_1-0"
        ],
        "rooms": [[1]],
        "A": [1]
    }
}

U_10 = 1  # m/s
k = 0.41
y0 = 0.3  # m, roughness length for urban terrain
Ustar = U_10 * k / np.log(10 / y0)  # Assuming z0 = 0.1 m
H = 3  # Building height in meters
U_H = Ustar / k * np.log(3 / y0)  # Wind speed at building height (1.5 m)
print(f"Calculated wind speed at building height: {U_H:.2f} m/s")

Cs = [2, 3]  # Shelter class adjustments
dfRooms = []
dfWindows = []
windowInfoDict = {
    "room": [],
    "window": [],
    "wind_angle" : [],
    "effective_angle": [],
    "C_p": [],
}
for C in Cs:
    vent_rooms = {room_name: [] for room_name in rooms}
    vent_windows = {}

    for room_name, room_dict in rooms.items():
        for window_equivalent in room_dict["window_equivalent"]:
            if "door" not in window_equivalent: 
                vent_windows[window_equivalent] = []
        for wind_angle in angles:
            p_w = []
            Cp_max = -999
            shelter_factor_value = 0
            for window, angle in room_dict["windows"]:
                effective_angle = (angle - wind_angle) % 360
                Cp = windows[window][effective_angle]
                windowInfoDict["room"].append(room_name)
                windowInfoDict["window"].append(window)
                windowInfoDict["wind_angle"].append(wind_angle)
                windowInfoDict["effective_angle"].append(effective_angle)
                windowInfoDict["C_p"].append(Cp)

                Cp_max = max(Cp_max, Cp)
                if Cp == Cp_max and "door" not in window:
                    shelter_class_value = shelter_class[window]
                    if C == 3:
                        shelter_class_value -= 1
                    # if shelter_class_value == 5 and effective_angle != 0:
                    #     shelter_class_value = 4 # Lower class 5 shelter class for angled wind to class 4
                    shelter_factor_value = shelter_factor[shelter_class_value]

                p_w.append(Cp * 0.5 * rho * (1 ** 2))

            N = len(p_w)

            flowParams = pyafn.createFlowParams(
                C_d=[Cd for _ in range(N)],
                A=room_dict["A"],
                p_w=p_w,
                z=[1.5 for _ in range(N)],
                delT=[0 for _ in range(N)],
                rooms=room_dict["rooms"],
                hr=3
            )

            optResults = pyafn.findOptimalP0(flowParams)
            p_0s = optResults.x

            print(f"\nOptimization Status: {optResults.message}")
            print(f"Success: {optResults.success}")
            print(f"\nOptimal indoor pressure: {p_0s[0]:.4f} Pa")
            print(f"Final objective value: {optResults.fun:.6e}")

            flows = pyafn.flowField(p_0s, flowParams)
            flows = flows * U_H * shelter_factor_value
            if "dual" in room_name:
                flows = flows[0:-1]  # Exclude the door flow for dual-room
            vent_rooms[room_name].append(np.sum(np.abs(flows)) / 2)
            for i, flow in enumerate(flows):
                vent_windows[room_dict["window_equivalent"][i]].append(flow)

    fig, axes = plt.subplots(4, 1, subplot_kw=dict(projection="polar"), figsize=(2, 6), dpi=160)
    for ax, (room_name, rates) in zip(axes.flat, vent_rooms.items()):
        theta = np.deg2rad(angles)
        # Close the polar curve
        theta_closed = np.append(theta, theta[0])
        rates_closed = np.append(rates, rates[0])

        ax.plot(theta_closed, rates_closed)
        ax.set_title(room_name, pad=15)
        ax.set_theta_zero_location("W")
        # ax.set_theta_direction(-1)
        ax.set_xlabel("Total Ventilation Rate (m³/s)")

    plt.tight_layout()
    # plt.show()

    fig, axes = plt.subplots(1, 8, subplot_kw=dict(projection="polar"), figsize=(12, 4), dpi=160)
    for ax, (window_name, rates) in zip(axes.flat, vent_windows.items()):
        theta = np.deg2rad(angles)
        # Close the polar curve
        theta_closed = np.append(theta, theta[0])
        rates_closed = np.append(rates, rates[0])

        ax.plot(theta_closed, rates_closed)
        ax.set_title(window_name, pad=15)
        ax.set_theta_zero_location("W")
        # ax.set_theta_direction(-1)
        ax.set_xlabel("Total Ventilation Rate (m³/s)")

    plt.tight_layout()
    # plt.show()

    dfRoomsC = pd.DataFrame(vent_rooms)
    dfWindowsC = pd.DataFrame(vent_windows)
    dfRoomsC["AofA"] = angles
    dfWindowsC["roomA"] = angles
    dfRoomsC["C"] = C
    dfWindowsC["C"] = C
    dfRoomsC = dfRoomsC.melt(id_vars=["AofA", "C"], var_name="roomType", value_name="ventilationRate")
    dfWindowsC = dfWindowsC.melt(id_vars=["roomA", "C"], var_name="windowType", value_name="ventilationRate")
    dfRooms.append(dfRoomsC)
    dfWindows.append(dfWindowsC)
dfRooms = pd.concat(dfRooms, axis=0)
dfWindows = pd.concat(dfWindows, axis=0)
dfRooms.to_csv("ashrae_exports/roomASHRAE.csv", index=False)
dfWindows.to_csv("ashrae_exports/windowASHRAE.csv", index=False)
pd.DataFrame(windowInfoDict).to_csv("ashrae_exports/windowInfoASHRAE.csv", index=False)
plt.show()
