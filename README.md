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




