import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
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

# Each window is (Cp table, head-on wind angle, mirrored). Wind angles are the LES roomA/AofA convention:
# the direction the wind blows toward in the canonical (B) house frame, 0 = +x, 90 = +z. House faces:
# x=54 (head-on 0), z=56 (90), z=64 (270); the effective angle is theta = head-on angle - wind angle.
# For theta > 0 the upwind corner of a face is: x=54 -> z=64 end, z=56 -> x=54 end, z=64 -> x=66 end.
# The off-centre tables (small_face_A, large_face_B) were read for a window offset toward that
# upwind corner (e.g. large_face_B: Cp(+90) = -0.4 near the leading edge, Cp(-90) = -0.2 downstream).
# Windows offset toward the other corner see the face mirrored, Cp(theta) -> Cp(-theta): mirrored=True.
rooms = {
    "cross": {
        "windows": [
            ("large_face_B", 90, True),    # z=56, x=64: offset toward x=66, not the theta>0 upwind x=54 end
            ("large_face_B", 270, False),  # z=64, x=64: offset toward x=66, the theta>0 upwind end
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
            ("small_face_A", 0, True),   # x=54, z=58: offset toward z=56, not the theta>0 upwind z=64 end
            ("large_face_B", 90, False),  # z=56, x=56: offset toward x=54, the theta>0 upwind end
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
            ("small_face_A", 0, False),   # x=54, z=62: offset toward z=64, the theta>0 upwind end
            ("large_face_B", 270, True),  # z=64, x=56: offset toward x=54, not the theta>0 upwind x=66 end
            ("large_face_AB", 270, False),  # z=64, x=60: centred, table is symmetric
            ("door", 0, False)
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
            ("large_face_AB", 90, False)  # z=56, x=60: centred, table is symmetric
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

def plot_polar_grid(series, angles, ncols, title, fname, panel_size=3.5):
    """One polar panel per entry of `series` (name -> rates at each angle), saved to `fname`."""
    nrows = int(np.ceil(len(series) / ncols))
    fig, axes = plt.subplots(
        nrows, ncols, subplot_kw=dict(projection="polar"),
        figsize=(panel_size * ncols, panel_size * nrows + 0.5), dpi=160,
        layout="constrained", squeeze=False,
    )
    theta = np.deg2rad(np.append(angles, angles[0]))  # close the polar curve
    for ax, (name, rates) in zip(axes.flat, series.items()):
        ax.plot(theta, np.append(rates, rates[0]), marker="o", markersize=3)
        ax.set_title(name)
        ax.set_theta_zero_location("W")
        ax.yaxis.set_major_locator(MaxNLocator(3))
        if np.min(rates) >= 0:
            ax.set_rmin(0)  # autoscale would otherwise put a nonzero value at the center
        else:
            # Signed flows: center is the most negative value, so mark the zero-flow ring
            ax.plot(np.linspace(0, 2 * np.pi, 200), np.zeros(200), "k--", lw=0.8)
        ax.tick_params(labelsize=8)
    for ax in axes.flat[len(series):]:
        ax.set_visible(False)
    fig.suptitle(title)
    fig.savefig(fname)
    plt.close(fig)


Cs = [2, 3]  # Shelter class adjustments
dfRooms = []
dfWindows = []
windowInfoDict = {
    "room": [],
    "window": [],
    "wind_angle" : [],
    "effective_angle": [],
    "table_angle": [],
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
            for window, angle, mirrored in room_dict["windows"]:
                effective_angle = (angle - wind_angle) % 360
                table_angle = (-effective_angle) % 360 if mirrored else effective_angle
                Cp = windows[window][table_angle]
                windowInfoDict["room"].append(room_name)
                windowInfoDict["window"].append(window)
                windowInfoDict["wind_angle"].append(wind_angle)
                windowInfoDict["effective_angle"].append(effective_angle)
                windowInfoDict["table_angle"].append(table_angle)
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

    plot_polar_grid(
        vent_rooms, angles, ncols=2,
        title=f"Room ventilation rate (m³/s) vs. wind angle, C = {C}",
        fname=f"ashrae_exports/roomASHRAE_C{C}.png",
    )
    plot_polar_grid(
        vent_windows, angles, ncols=4,
        title=f"Window flow rate (m³/s) vs. wind angle, C = {C}",
        fname=f"ashrae_exports/windowASHRAE_C{C}.png",
    )

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
