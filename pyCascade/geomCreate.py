from solid import *

class probed_geom:
    def __init__(self, geom, probes: "list"):
        self.geom = geom
        self.probes = probes

    def __add__(self, x: "probed_geom"):
        """
        This makes u = a + b also combine the associated probes
        """
        return probed_geom(self.geom+x.geom, self.probes+x.probes)

    def __radd__(self, x: "probed_geom"):
        """
        This makes u = a + b also combine the associated probes
        """
        return probed_geom(self.geom+x.geom, self.probes+x.probes)

    def __sub__(self, x: "probed_geom"):
        """
        This makes u = a - b also combine the associated probes
        """
        return probed_geom(self.geom-x.geom, self.probes+x.probes)

    def __mul__(self, x: "probed_geom"):
        """
        This makes u = a * b also combine the associated probes
        """
        return probed_geom(self.geom*x.geom, self.probes+x.probes)

    def translate(self, v):
        self.geom = translate(v)(self.geom)
        self.probes = [probe_instance+v for probe_instance in self.probes]

    def scale(self, v):
        self.geom = scale(v)(self.geom)
        self.probes = [probe_instance*v for probe_instance in self.probes]


# def makeProbedOpening()

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

    return rooms, rooms_params

def makeRoof(x_range,y_range,z_range):
    """
    pyramid roof with pointing towards y
    """
    x1, x2 = x_range[:]
    y1, y2 = y_range[:]
    z1, z2 = z_range[:]
    return polyhedron(
        points=([x1,y1,z1],[x2,y1,z1],[x2,y1,z2],[x1,y1,z2],  # the four points at base
                [(x2-x1)/2,y2,(z1+z2)/2]),                                        # the apex point 
        faces=([0,1,4],[1,2,4],[2,3,4],[3,0,4],                               # each triangle side
                    [1,0,3],[2,1,3])                                          # two triangles for square base
        )

def makeDoors(rooms_params, w, h):#, nw_probes, nh_probes):
    x = rooms_params['x']
    y = rooms_params['y']
    z = rooms_params['z']
    wthick = rooms_params['wthick']
    nx = rooms_params['nx']
    ny = rooms_params['ny']
    nz = rooms_params['nz']

    makeDoor = lambda disp, size : translate(disp)(cube(size, True))

    doors_list = []
    for i in range(nx):
        for k in range(nz):
            if i > 0:
                disp = (x*i, y/2, z*(k+.5))
                size = (wthick*2, h, w)
                # probe_space = (1, nh_probes, nw_probes)
                doors_list.append(makeDoor(disp, size))
            if k > 0:
                disp = (x*(i+.5), y/2, z*k)
                size = (w, h, wthick*2)
                doors_list.append(makeDoor(disp, size))

    return sum(doors_list)

def makeWindows(rooms_params, w, h):
    x = rooms_params['x']
    y = rooms_params['y']
    z = rooms_params['z']
    wthick = rooms_params['wthick']
    nx = rooms_params['nx']
    ny = rooms_params['ny']
    nz = rooms_params['nz']

    makeWindow = lambda disp, size : translate(disp)(cube(size, True))

    windows_list = []
    for i in range(nx):
        for k in range(nz):
            if i == 0 or i == (nx-1):
                disp = (x*(i+(i!=0)), y/2, z*(k+.5))
                size = (wthick*2, h, w)
                windows_list.append(makeWindow(disp, size))
            if k == 0 or k == (nz-1):
                disp = (x*(i+.5), y/2, z*(k+(k!=0)))
                size = (w, h, wthick*2)
                windows_list.append(makeWindow(disp, size))

    return sum(windows_list)



