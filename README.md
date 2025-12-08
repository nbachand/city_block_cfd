# Data Guide

## Termanology

### Flow Parameters

#### A
The flo0w angle with respect to the domain. This is the same across all quadrants.

#### WS
The specified wind speed at 10 meters.

#### slALL
Whether or not all houses have skylights. If true, the house has a skylight. If false, the house does not have a skylight unless it is house type *sl*.

#### C
Denstiy type of the urban area. 2 is high density, 3 is low density.

#### delT
The temperature difference in Celcius specified between the house interior and exterior.

#### SS
Whether or not the ventilation scenario is intended to be steady state. When false, the ventilation scenario is transient by initalizing the temperature scalar as 5 in the house interior at the beggining of the data collection period. This would be similar to a night flush scenario.

#### Ri
The richardson number calculated using the temperature difference between the house interior and exterior $\Delta T$ (0 or 5 $^oC$), the room height $H$ (3 $m$), and the wind speed at 10 meters $V$ (2 of 4 $m/s$) as $Ri = \frac{g \cdot \Delta T}{T_{ref}} * \frac{H} {V^2}$. $T_ref$ is the refernece temperature, 288.15 K, and $g$ is the gravitational acceleration, 10 $m/s^2$.

#### Params
A string list of params meant for plotting and differentiating cases which includes wind speed, Ri, delT, SS, and C (densitytype).

### Window-Integrated Quantities

Below I will use *qoi* as a stand in for a general quantity of interest

#### mass_flux()
The mass flux across a window normalized by the window area.

#### mass_flux(*qoi*)
The mass flux across a window wighted by the *qoi* normalized by the window area.

#### sn_prod(*qoi*)
The integrated value of the *qoi* across a window normalized by the window area. For example, sn_prod(p) returns the normalized pressure. If a velocity, as in sn_prod(u), the velocity is projected onto the window normal. For sn_prod(u), this would then give the normalized volume flux.

### Flow properties

#### u
Velocity

#### p
Pressure

### Scalars

#### D
A passive tracer initialized as 1 in house interiors at the beggining of the data collection period. No-flux boundaries for interior walls, with the tracer eventually decaying to 0.

#### S
A passive tracer initialized as 1 in house interiors at the beggining of the data collection period. Interior walls are constant value boundaries set to 1. This scalar is meant to mimick temperature but act equivalently regrdless of the specified temperature.

##### T
Temperature, initialized as 5 or 0 in house interiors at the beggining of the data collection period. Interior walls are constant value boundaries set to the initial temperature.

### Statistics in Time

#### mean-*qoi*
The mean value of the *qoi*.

#### rms-*qoi*
The root mean squared of the *qoi* fluctuations, or equivalently the standard deviation of the *qoi*.

#### net-*qoi*

The mean of the absolute value of the *qoi*.

### Geometric Quantities

#### openingType

##### xwindow
Window where the plane of the window is along the x-axis

##### zwindow
Window where the plane of the window is along the z-axis

##### skylight
Skylight through the house roof

#### windowNumber
*i*-*k*, where *i* and *k* are the window indexes with respect to the bottom left corner: CCC Add Image CCC

#### houseType
*i*-*k*, where *i* and *k* are the house indexes with respect to the quadrant center: CCC Add Image CCC

#### blockType
##### B
Quadrant 1, unrotated

##### Bx
Quadrant 4, rotated 270 degrees

##### Bz
Quadrant 2, rotated 90 degrees

##### Bxz
Quadrant 3, rotated 180 degrees

#### area
Opening area

#### x
X location

#### y
Y location (vertical)

#### z
Z location

#### orientation
For windows, the orientation of the window normal. For rooms, the orientation with respect to the unrotated house. Room orientations are the same across each quadrant.

### Extra Probes - Openings
Each opening has an additional point probe located 1.5 meters away in the direction of the window normal

#### EP_x
X location of the extra probe

#### EP_y
Y location of the extra probe

#### EP_z
Z location of the extra probe

#### EP_*qoi*
The value of the *qoi* calculated at the extra probe

#### EP_mag
The velocity magnitude at the extra probe

#### EP_normal
The velocity magnitude projected onto the window normal pointing into the building interior. Positive values mean flow towards the window from the outside.

#### EP_shear
The velocity magnitude perpendicular to the window normal (both horizontally and vertically)

#### EP_vel_orientation
The angle between **EP_normal** and a the the window normal pointing away from the building interior. For example, 0 degrees would be flow directly away from window, 90 degrees would be fully perpendicular to the windo normal, and 180 degrees would be directly into the window.

### Extra Probes - Houses
Each house has an additional point probe located at the center of the house one house height above the roof (12 meters above the ground)

#### EPR_mag
The velocity magnitude at the extra roof probe

#### EPR_orientation
The orientation of the velocity vector horizontally with respect to the domain (e.g., 0 degrees would be aligned with the x-axis, 90 degrees would be aligned with the y-axis)

#### Ri_EPR
The richardson number calculated using the temperature difference between the house interior and exterior (0 or 5 $^oC$), the house height (9 $m$), and the wind speed at the extra roof probe located 12 meters above the ground. See Ri for more details on Richardson number calculations.

### Normalizations by Reference Velocities

#### *qoi*-Norm
The *qoi* normalized by the prescribed velocity at 10 meters

#### *qoi*-NormEP
The *qoi* normalized by the velocity magnitude at the extra probe (1.5 m outside the window)

#### *qoi*-NormEPR
The *qoi* normalized by the velocity magnitude at the extra roof probe (1 house height above the roof)

### Simulation Specifics

#### starts
The time step at which data collection begins.

#### stops
The time step at which data collection ends.

### Room Characteristics

#### roomType
Ventilation Configuration: corner, cross, dual, or single

#### roomOrientation
The orientation of the room with respect to the unrotated house. This is the same as the rotation of the associated quadrant.

#### roomA
The flow angle with respect to flow along the x-axis through the unrotated house.

### Window Characteristics

#### AofA
The of the flow with respect to the window normal (pointing outwards from the building interior). This is not specified for skylights.

#### AofA_resid
The residual of the AofA divided by 90 degrees, being either 0 degrees or 45 degrees. This is not specified for skylights.



### [flowStatsMI](CHARLES/multiRuns/flowStatsMI.csv)

Various results on flow through individual windows.

#### Column Descriptions

##### Index Columns
- **First column (unnamed)**: Case identifier
- **windowType**: Combination of openingType, windowNumber, houseType, and blockType (e.g., `xwindow_0-0_h_0--1_B`)

##### Window-Integrated Flow Quantities
- **mean-mass_flux**: Mean normalized mass flux through the window
- **mean-mass_flux(D)**: Mean mass flux weighted by scalar D
- **mean-mass_flux(S)**: Mean mass flux weighted by scalar S
- **mean-mass_flux(T)**: Mean mass flux weighted by temperature T
- **mean-mass_flux(p)**: Mean mass flux weighted by pressure p
- **mean-sn_prod(abs(u))**: Mean normalized absolute velocity projected onto window normal
- **mean-sn_prod(p)**: Mean normalized pressure at the window
- **mean-sn_prod(u)**: Mean normalized velocity projected onto window normal (volume flux)
- **mean-sn_prod(u**2)**: Mean normalized squared velocity at the window

##### RMS Flow Quantities
- **rms-mass_flux**: RMS (standard deviation) of mass flux fluctuations
- **rms-mass_flux(D)**: RMS of mass flux weighted by scalar D
- **rms-mass_flux(S)**: RMS of mass flux weighted by scalar S
- **rms-mass_flux(T)**: RMS of mass flux weighted by temperature T
- **rms-mass_flux(p)**: RMS of mass flux weighted by pressure p
- **rms-sn_prod(abs(u))**: RMS of absolute velocity projected onto window normal
- **rms-sn_prod(p)**: RMS of pressure at the window
- **rms-sn_prod(u)**: RMS of velocity projected onto window normal
- **rms-sn_prod(u**2)**: RMS of squared velocity at the window

##### Net Flow Quantities
- **net-mass_flux**: Mean of absolute value of mass flux
- **net-mass_flux(D)**: Mean of absolute value of mass flux weighted by scalar D
- **net-mass_flux(S)**: Mean of absolute value of mass flux weighted by scalar S
- **net-mass_flux(T)**: Mean of absolute value of mass flux weighted by temperature T
- **net-mass_flux(p)**: Mean of absolute value of mass flux weighted by pressure p
- **net-sn_prod(abs(u))**: Mean of absolute value of velocity projected onto window normal
- **net-sn_prod(p)**: Mean of absolute value of pressure at the window
- **net-sn_prod(u)**: Mean of absolute value of velocity projected onto window normal
- **net-sn_prod(u**2)**: Mean of absolute value of squared velocity at the window

##### Geometric Properties
- **openingType**: Type of opening (xwindow, zwindow, skylight)
- **windowNumber**: Window index within house
- **houseType**: House index within quadrant
- **blockType**: Quadrant identifier (B, Bx, Bz, Bxz)
- **area**: Opening area (m²)
- **x**: X location of window center (m)
- **y**: Y location (vertical) of window center (m)
- **z**: Z location of window center (m)
- **orientation**: Orientation angle of window normal (degrees)

##### Extra Probe Properties (1.5 m outside window)
- **EP_x**: X location of extra probe
- **EP_y**: Y location of extra probe
- **EP_z**: Z location of extra probe
- **EP_D_avg**: Average scalar D at extra probe
- **EP_S_avg**: Average scalar S at extra probe
- **EP_T_avg**: Average temperature T at extra probe
- **EP_comp(u_avg,0)**: Average x-component of velocity at extra probe
- **EP_comp(u_avg,1)**: Average y-component of velocity at extra probe
- **EP_comp(u_avg,2)**: Average z-component of velocity at extra probe
- **EP_mag(u)_avg**: Average velocity magnitude at extra probe
- **EP_p_avg**: Average pressure at extra probe
- **EP_mag**: Velocity magnitude at extra probe
- **EP_vel_orientation**: Angle between velocity and window normal pointing away from building
- **EP_normal**: Velocity magnitude projected onto window normal pointing into building interior (positive = toward window from outside)
- **EP_shear**: Velocity magnitude perpendicular to window normal

##### Extra Roof Probe Properties (1 house height above roof)
- **EPR_mag**: Velocity magnitude at extra roof probe
- **EPR_vel_orientation**: Horizontal orientation of velocity vector with respect to domain

##### Simulation Parameters
- **csId**: Case ID number
- **A**: Flow angle with respect to domain (degrees)
- **WS**: Wind speed at 10 meters (m/s)
- **slAll**: Whether all houses have skylights (True/False)
- **C**: Density type (2 = high density, 3 = low density)
- **starts**: Time step when data collection begins
- **stops**: Time step when data collection ends
- **delT**: Temperature difference between house interior and exterior (°C)
- **SS**: Steady state ventilation scenario (True/False)
- **u10_2**: Reference velocity (appears to be empty in data)
- **Params**: String list of parameters for plotting (includes WS, Ri, delT, SS, C)

##### Room Characteristics
- **roomType**: Ventilation configuration (corner, cross, dual, single)
- **roomOrientation**: Room orientation with respect to unrotated house (degrees)
- **roomA**: Flow angle with respect to flow along x-axis through unrotated house (degrees)

##### Window Flow Characteristics
- **AofA**: Angle of flow with respect to window normal pointing outward (degrees, not specified for skylights)
- **AofA_resid**: Residual of AofA divided by 90 degrees (0 or 45 degrees, not specified for skylights)

##### Richardson Numbers
- **Ri**: Richardson number calculated using house height (3 m), wind speed at 10 m, and temperature difference
- **EPR_Ri**: Richardson number calculated using house height (9 m) and wind speed at extra roof probe

##### Normalized Flow Quantities (by reference velocity at 10 m)
All mean, rms, and net quantities have corresponding **-Norm** versions normalized by the prescribed wind speed at 10 meters.

##### Normalized Flow Quantities (by extra probe velocity)
All mean, rms, and net quantities have corresponding **-NormEP** versions normalized by the velocity magnitude at the extra probe (1.5 m outside window).

##### Normalized Flow Quantities (by extra roof probe velocity)
All mean, rms, and net quantities have corresponding **-NormEPR** versions normalized by the velocity magnitude at the extra roof probe (1 house height above roof).

##### Normalized Flow Quantities (by ABL velocity)
All mean, rms, and net quantities have corresponding **-NormABL** versions (column appears to be empty in current data).





### [roomVentilationMI](CHARLES/multiRuns/roomVentilationMI.csv)

Various results on flow through individual rooms. Data from individual windows are consolidated into rooms based on their ventilation configuration (corner, cross, dual, single).

#### Column Descriptions

##### Aggregated Window Properties
These properties are derived by aggregating data from all windows belonging to each room:
- **EP_shear**: Sum of velocity magnitudes perpendicular to window normals for all windows in the room
- **EPR_mag**: Mean velocity magnitude at extra roof probe (1 house height above roof)
- **EP_mag**: Sum of velocity magnitudes at extra probes for all windows in the room
- **u10_2**: Mean ABL velocity at 10 meters

##### Room Identification and Configuration
- **houseType**: House index within quadrant
- **blockType**: Quadrant identifier (B, Bx, Bz, Bxz)
- **roomType**: Ventilation configuration (corner, cross, dual, single)
- **nWindows**: Number of windows in the room
- **orientation**: Room orientation with respect to the unrotated house (degrees)

##### Simulation Parameters
- **csId**: Case ID number
- **A**: Flow angle with respect to domain (degrees)
- **WS**: Wind speed at 10 meters (m/s)
- **slAll**: Whether all houses have skylights (True/False)
- **C**: Density type (2 = high density, 3 = low density)
- **starts**: Time step when data collection begins
- **stops**: Time step when data collection ends
- **delT**: Temperature difference between house interior and exterior (°C)
- **SS**: Steady state ventilation scenario (True/False)
- **Params**: String list of parameters for plotting

##### Aggregated Flow Quantities (from windows)
Values aggregated from all windows in the room:
- **mean-mass_flux**: Mean of sum of absolute values of mass flux divided by 2 (approximates net exchange through room)
- **mean-mass_flux(D)**: Sum of mass flux weighted by scalar D across all windows
- **mean-mass_flux(S)**: Sum of mass flux weighted by scalar S across all windows
- **mean-mass_flux(T)**: Sum of mass flux weighted by temperature T across all windows
- **mean-mass_flux(p)**: Sum of mass flux weighted by pressure p across all windows
- **mean-sn_prod(abs(u))**: Mean of sum of absolute values of velocity flux divided by 2
- **mean-sn_prod(u)**: Mean of sum of absolute values of velocity projected onto window normals divided by 2
- **mean-sn_prod(u**2)**: Sum of squared velocity across all windows
- **net-mass_flux**: Mean of sum of absolute values of net mass flux divided by 2
- **net-mass_flux(D)**: Sum of net mass flux weighted by scalar D
- **net-mass_flux(S)**: Sum of net mass flux weighted by scalar S
- **net-mass_flux(T)**: Sum of net mass flux weighted by temperature T
- **net-mass_flux(p)**: Sum of net mass flux weighted by pressure p
- **net-sn_prod(abs(u))**: Mean of sum of absolute values of net velocity flux divided by 2
- **net-sn_prod(u)**: Mean of sum of absolute values of net velocity projected onto window normals divided by 2
- **net-sn_prod(u**2)**: Sum of net squared velocity across all windows
- **rms-sn_prod(p)**: Sum of RMS pressure fluctuations across all windows

##### Room Continuity Assessment
- **contResid**: Mean of mass flux values (measures continuity residual - should be near zero for mass conservation)
- **EP_normal_mag**: Sum of absolute values of EP_normal across all windows
- **EP_normal_sum**: Absolute value of sum of EP_normal across all windows
- **EP_normal_ratio**: Ratio indicating bidirectionality of flow (higher values = more balanced inflow/outflow)

##### Room Centroid Location
- **x**: Mean x-coordinate of windows in the room
- **y**: Mean y-coordinate of windows in the room
- **z**: Mean z-coordinate of windows in the room

##### Room Floor Surface Fluxes
Flow statistics at the room floor surface (probe located below room):
- **mean-mass_flux-roomFloor**: Mean mass flux through floor
- **rms-mass_flux-roomFloor**: RMS mass flux through floor
- **mean-mass_flux(D)-roomFloor**: Mean mass flux weighted by scalar D through floor
- **rms-mass_flux(D)-roomFloor**: RMS mass flux weighted by scalar D through floor
- **mean-mass_flux(S)-roomFloor**: Mean mass flux weighted by scalar S through floor
- **rms-mass_flux(S)-roomFloor**: RMS mass flux weighted by scalar S through floor
- **mean-mass_flux(T)-roomFloor**: Mean mass flux weighted by temperature through floor
- **rms-mass_flux(T)-roomFloor**: RMS mass flux weighted by temperature through floor
- **mean-mass_flux(p)-roomFloor**: Mean mass flux weighted by pressure through floor
- **rms-mass_flux(p)-roomFloor**: RMS mass flux weighted by pressure through floor
- **mean-sn_prod(abs(u))-roomFloor**: Mean absolute velocity through floor
- **rms-sn_prod(abs(u))-roomFloor**: RMS absolute velocity through floor
- **mean-sn_prod(p)-roomFloor**: Mean pressure at floor
- **rms-sn_prod(p)-roomFloor**: RMS pressure at floor
- **mean-sn_prod(u)-roomFloor**: Mean velocity through floor
- **rms-sn_prod(u)-roomFloor**: RMS velocity through floor
- **mean-sn_prod(u**2)-roomFloor**: Mean squared velocity at floor
- **rms-sn_prod(u**2)-roomFloor**: RMS squared velocity at floor
- **area-roomFloor**: Floor area
- **x-roomFloor**, **y-roomFloor**, **z-roomFloor**: Floor probe location

##### Room Ceiling Surface Fluxes
Flow statistics at the room ceiling surface (probe located above room):
- **mean-mass_flux-roomCeil**: Mean mass flux through ceiling
- **rms-mass_flux-roomCeil**: RMS mass flux through ceiling
- **mean-mass_flux(D)-roomCeil**, **rms-mass_flux(D)-roomCeil**: Mass flux weighted by scalar D
- **mean-mass_flux(S)-roomCeil**, **rms-mass_flux(S)-roomCeil**: Mass flux weighted by scalar S
- **mean-mass_flux(T)-roomCeil**, **rms-mass_flux(T)-roomCeil**: Mass flux weighted by temperature
- **mean-mass_flux(p)-roomCeil**, **rms-mass_flux(p)-roomCeil**: Mass flux weighted by pressure
- **mean-sn_prod(abs(u))-roomCeil**, **rms-sn_prod(abs(u))-roomCeil**: Absolute velocity statistics
- **mean-sn_prod(p)-roomCeil**, **rms-sn_prod(p)-roomCeil**: Pressure statistics
- **mean-sn_prod(u)-roomCeil**, **rms-sn_prod(u)-roomCeil**: Velocity statistics
- **mean-sn_prod(u**2)-roomCeil**, **rms-sn_prod(u**2)-roomCeil**: Squared velocity statistics
- **area-roomCeil**: Ceiling area
- **x-roomCeil**, **y-roomCeil**, **z-roomCeil**: Ceiling probe location

##### Room Volume-Averaged Quantities (by vertical slice)
Point probe measurements at different vertical positions within the room (room0-room5 represent different heights):
- **mean-D-room[0-5]**: Mean scalar D concentration at vertical slice
- **rms-D-room[0-5]**: RMS scalar D concentration at vertical slice
- **tau-D-room[0-5]**: Time constant for scalar D decay at vertical slice
- **mean-S-room[0-5]**: Mean scalar S concentration at vertical slice
- **rms-S-room[0-5]**: RMS scalar S concentration at vertical slice
- **mean-T-room[0-5]**: Mean temperature at vertical slice
- **rms-T-room[0-5]**: RMS temperature at vertical slice
- **tau-T-room[0-5]**: Time constant for temperature decay at vertical slice
- **mean-comp(u,0)-room[0-5]**: Mean x-component of velocity at vertical slice
- **rms-comp(u,0)-room[0-5]**: RMS x-component of velocity at vertical slice
- **mean-comp(u,1)-room[0-5]**: Mean y-component of velocity at vertical slice
- **rms-comp(u,1)-room[0-5]**: RMS y-component of velocity at vertical slice
- **mean-comp(u,2)-room[0-5]**: Mean z-component of velocity at vertical slice
- **rms-comp(u,2)-room[0-5]**: RMS z-component of velocity at vertical slice
- **mean-p-room[0-5]**: Mean pressure at vertical slice
- **rms-p-room[0-5]**: RMS pressure at vertical slice

##### Tracer Decay Analysis (by vertical slice)
Derived quantities from exponential decay fits:
- **c-D-room[0-5]**: Decay constant for scalar D at vertical slice
- **q-D-room[0-5]**: Ventilation rate derived from scalar D decay at vertical slice
- **mean-T-room[0-5]-Norm**: Normalized mean temperature at vertical slice
- **rms-T-room[0-5]-Norm**: Normalized RMS temperature at vertical slice
- **c-T-room[0-5]**: Decay constant for temperature at vertical slice
- **q-T-room[0-5]**: Ventilation rate derived from temperature decay at vertical slice

##### Room Volume-Averaged Quantities (full room)
Averaged across all vertical slices in the room:
- **mean-D-room**: Mean scalar D concentration in entire room
- **rms-D-room**: RMS scalar D concentration in entire room
- **tau-D-room**: Time constant for scalar D decay in entire room
- **mean-S-room**: Mean scalar S concentration in entire room
- **rms-S-room**: RMS scalar S concentration in entire room
- **mean-T-room**: Mean temperature in entire room
- **rms-T-room**: RMS temperature in entire room
- **tau-T-room**: Time constant for temperature decay in entire room
- **mean-comp(u,0)-room**, **rms-comp(u,0)-room**: Velocity x-component statistics for entire room
- **mean-comp(u,1)-room**, **rms-comp(u,1)-room**: Velocity y-component statistics for entire room
- **mean-comp(u,2)-room**, **rms-comp(u,2)-room**: Velocity z-component statistics for entire room
- **mean-p-room**: Mean pressure in entire room
- **rms-p-room**: RMS pressure in entire room
- **c-D-room**: Decay constant for scalar D in entire room
- **q-D-room**: Ventilation rate derived from scalar D decay in entire room
- **mean-T-room-Norm**: Normalized mean temperature in entire room
- **rms-T-room-Norm**: Normalized RMS temperature in entire room
- **c-T-room**: Decay constant for temperature in entire room
- **q-T-room**: Ventilation rate derived from temperature decay in entire room

##### Surface Balance Quantities
Corrected surface fluxes accounting for concentration gradients:
- **mean-mass_flux-roomCeil-slEx**: Mean mass flux through ceiling including skylight contributions
- **mean-mass_flux(S)-roomCeil-slEx**: Scalar S flux through ceiling including skylights
- **mean-mass_flux(S)-roomCeil-Zeroed**: Scalar S flux through ceiling corrected for background concentration
- **mean-mass_flux(S)-roomFloor-Zeroed**: Scalar S flux through floor corrected for background concentration
- **mean-mass_flux(S)-roomWalls-Zeroed**: Scalar S flux through walls derived from conservation (residual)
- **mean-mass_flux(S)-roomCeil-perA**: Ceiling flux normalized by ceiling area
- **mean-mass_flux(S)-roomFloor-perA**: Floor flux normalized by floor area
- **mean-mass_flux(S)-roomWalls-perA**: Wall flux normalized by wall area
- **mean-mass_flux(S)-roomCeil-h**: Ceiling heat transfer coefficient (if treating S as temperature analog)
- **mean-mass_flux(S)-roomFloor-h**: Floor heat transfer coefficient
- **mean-mass_flux(S)-roomWalls-h**: Wall heat transfer coefficient

##### Flow Angle Characteristics
- **AofA**: Angle of attack with respect to room orientation (degrees)
- **AofA_resid**: Residual of AofA divided by 90 degrees (0 or 45 degrees)

##### Richardson Numbers
- **Ri**: Richardson number calculated using house height (3 m) and wind speed at 10 m
- **EPR_Ri**: Richardson number calculated using house height (9 m) and wind speed at extra roof probe

##### Normalized Quantities
All aggregated window flow quantities (mean-*, net-*, rms-sn_prod(p)) have four normalized versions:
- **[qoi]-Norm**: Normalized by wind speed at 10 meters
- **[qoi]-NormEP**: Normalized by velocity magnitude at extra probes
- **[qoi]-NormEPR**: Normalized by velocity magnitude at extra roof probe
- **[qoi]-NormABL**: Normalized by ABL velocity (may be empty)

All room floor surface fluxes have four normalized versions using the same normalizations.

All room ceiling surface fluxes have four normalized versions using the same normalizations.

All ventilation rates (q-D-room[0-5], q-T-room[0-5], q-D-room, q-T-room) have four normalized versions using the same normalizations.

All surface balance quantities have four normalized versions using the same normalizations.

##### Individual Window Details (expanded sequences)
Lists of properties for each window in the room (columns end with _0, _1, _2, _3, _4):
- **windowKeys_[0-4]**: Window identifier keys
- **EP_normal_[0-4]**: Velocity normal to each window
- **mean-sn_prod(p)_[0-4]**: Mean pressure at each window
- **net-sn_prod(p)_[0-4]**: Net pressure at each window
- **openingType_[0-4]**: Type of each opening (xwindow, zwindow, skylight)
- **windowNumber_[0-4]**: Window number for each opening

