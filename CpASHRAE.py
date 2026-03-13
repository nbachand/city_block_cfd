import numpy as np
import matplotlib.pyplot as plt
import pyafn
from pyafn import rho, Cd, g, beta
import pandas as pd

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
            "zwindow_1-0"
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
    # "Single-Sided": {
    #     ("large_face_AB", 270),
    # ],
}

vent_rooms = {room_name: [] for room_name in rooms}
vent_windows = {}

for room_name, room_dict in rooms.items():
    for window_equivalent in room_dict["window_equivalent"]:
        if "door" not in window_equivalent: 
            vent_windows[window_equivalent] = []
    for wind_angle in angles:
        p_w = []
        for window, angle in room_dict["windows"]:
            effective_angle = (wind_angle + angle) % 360
            Cp = windows[window][effective_angle]
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
        if "dual" in room_name:
            flows = flows[0:-1]  # Exclude the door flow for dual-room
        vent_rooms[room_name].append(np.sum(np.abs(flows)) / 2)
        for i, flow in enumerate(flows):
            vent_windows[room_dict["window_equivalent"][i]].append(flow)

fig, axes = plt.subplots(3, 1, subplot_kw=dict(projection="polar"), figsize=(2, 6), dpi=160)
for ax, (room_name, rates) in zip(axes.flat, vent_rooms.items()):
    theta = np.deg2rad(angles)
    # Close the polar curve
    theta_closed = np.append(theta, theta[0])
    rates_closed = np.append(rates, rates[0])

    ax.plot(theta_closed, rates_closed)
    ax.set_title(room_name, pad=15)
    ax.set_theta_zero_location("W")
    ax.set_theta_direction(-1)
    ax.set_xlabel("Total Ventilation Rate (m³/s)")

plt.tight_layout()
# plt.show()

fig, axes = plt.subplots(1, 7, subplot_kw=dict(projection="polar"), figsize=(6, 2), dpi=160)
for ax, (window_name, rates) in zip(axes.flat, vent_windows.items()):
    theta = np.deg2rad(angles)
    # Close the polar curve
    theta_closed = np.append(theta, theta[0])
    rates_closed = np.append(rates, rates[0])

    ax.plot(theta_closed, rates_closed)
    ax.set_title(window_name, pad=15)
    ax.set_theta_zero_location("W")
    ax.set_theta_direction(-1)
    ax.set_xlabel("Total Ventilation Rate (m³/s)")

plt.tight_layout()
# plt.show()

dfRooms = pd.DataFrame(vent_rooms)
dfWindows = pd.DataFrame(vent_windows)
dfRooms ["roomA"] = angles
dfWindows ["roomA"] = angles
dfRooms = dfRooms.melt(id_vars=["roomA"], var_name="roomType", value_name="ventilationRate")
dfWindows = dfWindows.melt(id_vars=["roomA"], var_name="windowType", value_name="ventilationRate")
dfRooms.to_csv("roomASHRAE.csv", index=True)
dfWindows.to_csv("windowASHRAE.csv", index=True)
