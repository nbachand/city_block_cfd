# Data Guide

## Table of Contents

- [Data Guide](#data-guide)
    - [Table of Contents](#table-of-contents)
    - [Paper](#paper)
    - [Datasets](#datasets)
    - [Terminology](#terminology)
        - [Flow Properties](#flow-properties)
        - [Scalars](#scalars)
        - [Flow Parameters](#flow-parameters)
        - [Statistics in Time](#statistics-in-time)
        - [Window-Integrated Quantities](#window-integrated-quantities)
        - [Geometric Quantities](#geometric-quantities)
        - [Extra Probes - Openings](#extra-probes---openings)
        - [Extra Probes - Houses](#extra-probes---houses)
        - [Normalizations by Reference Velocities](#normalizations-by-reference-velocities)
        - [Simulation Specifics](#simulation-specifics)
        - [Room Characteristics](#room-characteristics)
        - [Window Characteristics](#window-characteristics)
        - [Room-Level Aggregations](#room-level-aggregations)

### Paper
This guide presents the data used in the paper [Simulating The Urban Canopy's Impact on Wind-Driven Natural Ventilation and Cooling](https://arxiv.org/abs/2508.04091). The two main datasets are:

### GitHub
These datasets were processed using code in the github repository [city_block_cfd](https://github.com/nbachand/city_block_cfd)

### Datasets

**[flowStatsMI](CHARLES/multiRuns/flowStatsMI.csv)**

Various results on flow through individual windows. First two columns provide and index, [*run ID*, *window ID*], to identify each row. The *window ID* is [openingType](#openingtype)-[windowNumber](#windownumber)\_h_[houseNumber](#housetype)_[blockType](#blocktype).

**[roomVentilationMI](CHARLES/multiRuns/roomVentilationMI.csv)**

Various results on flow through individual rooms. Data from individual windows are consolidated into rooms based on their ventilation configuration (corner, cross, dual, single). First two columns provide and index, [*run ID*, *room ID*], to identify each row. The *room ID* is [roomType](#roomtype)\_h_[houseNumber](#housetype)_[blockType](#blocktype).

## Terminology
The following sections define the various terms and quantities used in the datasets, primarily in the column headers. Some terms are used in combination to form more complex column headers, and not all terms are individually present as columns.

### Flow Properties

#### u
Velocity

#### p
Pressure

### Scalars

#### D
A passive tracer initialized as 1 in house interiors at the beginning of the data collection period. No-flux boundaries for interior walls, with the tracer eventually decaying to 0.

#### S
A passive tracer initialized as 1 in house interiors at the beginning of the data collection period. Interior walls are constant value boundaries set to 1. This scalar is meant to mimic temperature is a passive scalar. It will act equivalently regardless of the specified temperature.

#### T
Temperature, initialized as 5 or 0 in house interiors at the beginning of the data collection period. Interior walls are constant value boundaries set to the initial temperature.

### Primary Parameters Differentiating Runs

#### A
The flow angle with respect to the domain. This is the same across all quadrants.

#### WS
The specified wind speed at 10 meters.

#### C
Density type of the urban area. 2 is high density, 3 is low density.

#### delT
The temperature difference in Celsius specified between the house interior and exterior.

#### Ri
The Richardson number calculated using the temperature difference between the house interior and exterior $\Delta T$ (0 or 5 $^oC$), the room height $H$ (3 $m$), and the wind speed at 10 meters $V$ (2 or 4 $m/s$) as $Ri = \frac{g \cdot \Delta T}{T_{ref}} \cdot \frac{H}{V^2}$. $T_{ref}$ is the reference temperature, 288.15 K, and $g$ is the gravitational acceleration, 10 $m/s^2$.

#### SS
Whether or not the ventilation scenario is intended to be steady state. When false, the ventilation scenario is transient by initializing the temperature scalar as 5 in the house interior at the beginning of the data collection period. This would be similar to a night flush scenario.

#### slAll
Whether or not all houses have skylights. If true, the house has a skylight. If false, the house does not have a skylight unless it is house type *sl*.

#### Params
A string list of parameters meant for plotting and differentiating cases which includes [WS](#ws), [Ri](#ri), [delT](#delt), [SS](#ss), and [C](#c).

### Statistics in Time

#### mean-*qoi*
The mean value of the *qoi* (quantity of interest).

#### rms-*qoi*
The root mean squared of the *qoi* fluctuations, or equivalently the standard deviation of the *qoi*.

#### net-*qoi*
The mean of the absolute value of the *qoi*.

### Window-Integrated Quantities

Below, *qoi* is used as a stand-in for a general quantity of interest. These statistics (mean-, rms-, net-) combine with window-integrated quantities to produce columns like `mean-mass_flux`, `rms-sn_prod(u)`, etc.

#### mass_flux()
The mass flux across a window normalized by the window area.

#### mass_flux(*qoi*)
The mass flux across a window weighted by the *qoi* normalized by the window area. For example, `mass_flux(D)` is the mass flux weighted by scalar D concentration.

#### sn_prod(*qoi*)
The integrated value of the *qoi* across a window normalized by the window area. For example, `sn_prod(p)` returns the normalized pressure. For velocities, as in `sn_prod(u)`, the velocity is projected onto the window normal, giving the normalized volume flux. `sn_prod(abs(u))` uses the absolute velocity magnitude, while `sn_prod(u**2)` uses squared velocity.

### Geometric Quantities

#### openingType

##### xwindow
Window where the window normal is along the x-axis

##### zwindow
Window where the window normal is along the z-axis

##### skylight
Skylight through the house roof

#### windowNumber
*i*-*k*, where *i* and *k* are the window indexes with respect to the bottom left corner

<img width="2809" height="2057" alt="dataWindows" src="https://github.com/user-attachments/assets/9881af46-2f87-4d4f-b5a6-33e1f52f030b" />

#### houseType
*i*-*k*, where *i* and *k* are the house indexes with respect to the quadrant center
<img width="3272" height="1760" alt="dataHouses" src="https://github.com/user-attachments/assets/f6de7013-639f-4a43-a231-453a64aa82f5" />

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
X coordinate

#### y
Y coordinate (y-axis is vertical)

#### z
Z coordinate

#### orientation
For windows, the orientation of the window normal (pointing outwards from the building interior). For rooms, the orientation with respect to the unrotated house. Room orientations are the same across each quadrant.

### Extra Probes - Openings
Each opening has an additional point probe located 1.5 meters away in the direction of the window normal

#### EP_x
X coordinate of the extra probe

#### EP_y
Y coordinate of the extra probe

#### EP_z
Z coordinate of the extra probe

#### EP_*qoi*
The value of the *qoi* calculated at the extra probe

#### EP_mag
The velocity magnitude at the extra probe

#### EP_normal
The velocity magnitude projected onto the negative window normal (pointing into the building interior). Positive values mean flow towards the window from the outside.

#### EP_shear
The velocity magnitude perpendicular to the window normal (both horizontally and vertically)

#### EP_vel_orientation
The angle between the velocity vector and the window normal (pointing away from the building interior). For example, 0 degrees would be flow directly away from the window, 90 degrees would be fully perpendicular to the window normal, and 180 degrees would be directly into the window.

### Extra Probes - Roofs
Each house has an additional point probe located at the center of the house one house height above the roof (12 meters above the ground)

#### EPR_mag
The velocity magnitude at the extra roof probe

#### EPR_vel_orientation
The orientation of the velocity vector horizontally with respect to the domain (e.g., 0 degrees would be aligned with the x-axis, 90 degrees would be aligned with the y-axis)

#### EPR_Ri
The Richardson number calculated using the temperature difference between the house interior and exterior (0 or 5 $^oC$), the house height (3 $m$), and the wind speed at the extra roof probe located 12 meters above the ground. See [Ri](#ri) for more details on Richardson number calculations.

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
The angle of the flow with respect to the window normal (pointing outwards from the building interior). This is not specified for skylights which are all vertical.

#### AofA_resid
The residual of the AofA divided by 90 degrees, being either 0 degrees or 45 degrees. This is not specified for skylights.

### Room-Level Aggregations

#### Room Volume Slices
Room interior measurements are taken at multiple vertical slices within each room:
- **room0**: Bottom slice (near floor level)
- **room1**: Lower-middle slice
- **room2**: Middle slice
- **room3**: Upper-middle slice  
- **room4**: Upper slice
- **room5**: Top slice (near ceiling level)
- **room**: Average across all slices (full room volume)

#### Room Surface Designations
Surface flux measurements at room boundaries:
- **roomFloor**: Floor surface (probe below room)
- **roomCeil**: Ceiling surface (probe above room)
- **roomWalls**: Wall surfaces (derived from conservation)

#### Room Aggregation Methods
When consolidating window data to rooms:
- Flow quantities (`mass_flux`, `sn_prod(u)`, `sn_prod(abs(u))`): Sum of absolute values divided by 2 (approximates net exchange)
- Scalar-weighted quantities (`mass_flux(D)`, `mass_flux(S)`, `mass_flux(T)`): Direct sum across all windows
- Squared quantities (`sn_prod(u**2)`): Direct sum across all windows
- Pressure RMS (`rms-sn_prod(p)`): Direct sum across all windows
- Location properties (x, y, z): Mean across all windows
- Extra probe properties: Sum for `EP_mag` and `EP_shear`, mean for `EPR_mag` and `u10_2`

#### Tracer Decay Quantities
The following quantities are derived from exponential decay fits of scalars D and T

The exponential decay model fitted to tracer concentrations has the form:

$$y(t) = (1 - c) \cdot e^{-t/\tau} + c$$

where:
- $y(t)$ is the normalized tracer concentration at time $t$
- $\tau$ is the time constant (decay rate)
- $c$ is the steady-state concentration (background level)
- $t$ is time normalized such that $t=0$ at the start of data collection

The fit yields two parameters:


- **tau-D-room**, **tau-T-room**: Time constant (decay rate) for scalars.
- **c-D-room**, **c-T-room**: Decay constants from exponential fits.
- **q-D-room**, **q-T-room**: Ventilation rates calculated from decay (mass flow rate / room volume / density)

#### Surface Balance Corrections
- **-Zeroed**: Surface flux corrected by subtracting background concentration contribution. There seemed to be a systemic error where the background concentration was included in the flux for ceiling and floor surfaces, where the mass flux is 0 (unless there are skylights).
- **-perA**: Flux normalized by surface area
- **-h**: Heat transfer coefficient (for temperature-like scalars)
- **-slEx**: Ceiling flux excluding skylight contributions
