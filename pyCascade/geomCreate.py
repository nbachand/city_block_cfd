from solid import *
import numpy as np
from pyCascade import probeSetup
# from numpy.polynomial import chebyshev as cheb
# from chaospy.quadrature import clenshaw_curtis

class ProbedGeom:
    def __init__(self, geom, probes = []):
        self.geom = geom
        self.probes = probes

    def __add__(self, x: "ProbedGeom"):
        """
        This makes u = a + b also aggegate the associated probes
        """
        return ProbedGeom(self.geom+x.geom, self.probes + x.probes)

    # def __radd__(self, x: "ProbedGeom"):
    #     """
    #     This makes u = a + b also aggegate the associated probes
    #     """
    #     return ProbedGeom(self.geom+x.geom, self.probes + x.probes)

    def __sub__(self, x: "ProbedGeom"):
        """
        This makes u = a - b also aggegate the associated probes
        """
        return ProbedGeom(self.geom-x.geom, self.probes + x.probes)

    def __mul__(self, x: "ProbedGeom"):
        """
        This makes u = a * b also aggegate the associated probes
        """
        return ProbedGeom(self.geom*x.geom, self.probes + x.probes)

    def translate(self, v):
        """
        translates geometry and probes
        """
        self.geom = translate(v)(self.geom)
        for probe_instance in self.probes: probe_instance["tile"]+=v 

    def scale(self, v):
        """
        scales geometry and probes
        """
        self.geom = scale(v)(self.geom)
        for probe_instance in self.probes: probe_instance["tile"]*=v

    def write_probes(self, directory):
        for probe in self.probes:
            tile = probe["tile"]
            fileName = f"{directory}{probe['name']}.txt"
            probeSetup.writeProbes(tile, fileName)


def sumProbedGeom(items: "list"):
    for i, item in enumerate(items):
        if i == 0:
            summed = item
        else:
            summed += item
    return summed

def makeProbedCube(size, nprobes, name, centered = False):
    geom = cube(size, centered)
    probe_span = []
    for i,n in enumerate(nprobes):
        cheby_points = np.arange(1,n+1)
        cheby_points = np.cos((2*cheby_points-1)*np.pi/(2*n))  #Chebyshev Nodes
        # cheby_points, _ = cheb.chebgauss(n)
        # print(cheby_points)
        cheby_points *= size[i]/2
        if centered == False:
            cheby_points += size[i]/2
        probe_span.append(cheby_points)
    tile = probeSetup.probe_fill(*probe_span)
    probes = [{
        "tile": tile,
        "name": name
    }]
    return ProbedGeom(geom, probes)


def makeRooms(x, y, z, wthick = .01, nx=1, ny=1, nz=1):
    offset = wthick/2
    x_empty = x - wthick
    y_empty= y - wthick
    z_empty = z - wthick
    size = (x_empty, y_empty, z_empty)

    rooms_list = []
    for i in range(nx):
        for j in range(ny):
            for k in range(nz):
                disp = (x*i + offset, y*j + offset, z*k + offset)
                rooms_list.append(translate(disp)(cube(size, False)))
    rooms = sum(rooms_list)

    rooms_params = {
        'x': x,
        'y': y,
        'z': z,
        'wthick': wthick,
        'nx': nx,
        'ny': ny,
        'nz': nz
    }

    return ProbedGeom(rooms), rooms_params


def identify_openings(rooms_params):
    nx = rooms_params['nx']
    nz = rooms_params['nz']

    window_locations = []
    door_locations = []

    for i in range(nx):
        for k in range(nz):
            if i == 0 or i == (nx-1):
                window_locations.append([i,k,'x'])
            if i > 0:
                door_locations.append([i,k,'x'])
            if k == 0 or k == (nz-1):
                window_locations.append([i,k,'z'])
            if k > 0:
                door_locations.append([i,k,'z'])

    rooms_params['window_locations'] = window_locations
    rooms_params['door_locations'] = door_locations
    rooms_params['wall_locations'] = door_locations

    return rooms_params


def makeRoof(x_range,y_range,z_range):
    """
    pyramid roof with pointing towards y
    """
    x1, x2 = x_range[:]
    y1, y2 = y_range[:]
    z1, z2 = z_range[:]
    geom =  polyhedron(
        points=([x1,y1,z1],[x2,y1,z1],[x2,y1,z2],[x1,y1,z2],  # the four points at base
                [(x2-x1)/2,y2,(z1+z2)/2]),                                        # the apex point 
        faces=([0,1,4],[1,2,4],[2,3,4],[3,0,4],                               # each triangle side
                    [1,0,3],[2,1,3])                                          # two triangles for square base
        )

    return ProbedGeom(geom)

def makeDoors(rooms_params, w, h, nprobes_w, nprobes_h):
    x = rooms_params['x']
    y = rooms_params['y']
    z = rooms_params['z']
    wthick = rooms_params['wthick']
    door_locations =  rooms_params['door_locations']

    doors_list = []
    for door_location in door_locations:
        i, k, orientation = door_location
        if orientation == 'x':
            disp = (x*i, y/2, z*(k+.5))
            size = (wthick*2, h, w)
            nprobes = (1, nprobes_h, nprobes_w)
            door = makeProbedCube(size, nprobes, f"xdoor_{i}-{k}", True)
            door.translate(disp)
        elif orientation == 'z':
            disp = (x*(i+.5), y/2, z*k)
            size = (w, h, wthick*2)
            nprobes = (nprobes_w, nprobes_h, 1)
            door = makeProbedCube(size, nprobes, f"zdoor_{i}-{k}", True)
            door.translate(disp)
        doors_list.append(door)

    return sumProbedGeom(doors_list)

def makeWindows(rooms_params, w, h, nprobes_w, nprobes_h):
    x = rooms_params['x']
    y = rooms_params['y']
    z = rooms_params['z']
    wthick = rooms_params['wthick']
    window_locations =  rooms_params['window_locations']

    windows_list = []
    for window_location in window_locations:
        i, k, orientation = window_location
        if orientation == 'x':
            disp = (x*(i+(i!=0)), y/2, z*(k+.5))
            size = (wthick*2, h, w)
            nprobes = (1, nprobes_h, nprobes_w)
            window = makeProbedCube(size, nprobes, f"xwindow_{i}-{k}", True)
            window.translate(disp)
        elif orientation == 'z':
            disp = (x*(i+.5), y/2, z*(k+(k!=0)))
            size = (w, h, wthick*2)
            nprobes = (nprobes_w, nprobes_h, 1)
            window = makeProbedCube(size, nprobes, f"zwindow_{i}-{k}", True)
            window.translate(disp)
        windows_list.append(window)

    return sumProbedGeom(windows_list)

def openWalls(rooms_params, w, h, nprobes_w, nprobes_h):
    x = rooms_params['x']
    y = rooms_params['y']
    z = rooms_params['z']
    wthick = rooms_params['wthick']
    wall_locations =  rooms_params['wall_locations']

    walls_list = []
    for wall_location in wall_locations:
        i, k, orientation = wall_location
        if orientation == 'x':
            disp = (x*i, y/2, z*(k+.5))
            size = (wthick*2, h, w)
            nprobes = (1, nprobes_h, nprobes_w)
            door = makeProbedCube(size, nprobes, f"xwall_{i}-{k}", True)
            door.translate(disp)
        elif orientation == 'z':
            disp = (x*(i+.5), y/2, z*k)
            size = (w, h, wthick*2)
            nprobes = (nprobes_w, nprobes_h, 1)
            door = makeProbedCube(size, nprobes, f"zwall_{i}-{k}", True)
            door.translate(disp)
        walls_list.append(door)

    return sumProbedGeom(walls_list)