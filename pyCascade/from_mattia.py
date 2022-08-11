import copy
import multiprocessing as mp

from joblib         import Parallel, delayed
from scipy.signal   import welch, hanning
from scipy.optimize import curve_fit
from scipy.stats    import pearsonr

import matplotlib
matplotlib.use( 'TkAgg' )
import matplotlib.pyplot as plt

uStar = 0.4962

copy.copy(uStar)

z0 = 0.0032
Uref = uStar/0.41*np.log(1.975/z0)
q = 0.5*1.225*Uref**2
nCpu = 12

patches = {'F':'front','L':'leeward'}

angles = [10]
#deltas is the resolution of the LES, the 0.0005 the timestep associated
deltas = {'Coarsest':0.0005}

t0 =   25000
lastStep = np.arange(26000,32000,10000)

nTaps = 0
nLags = len(lastStep)

# readHRBDataset is a function that simply reads the data from the .pcd file and organizes it
# into a dictionary whose first entry is Refinement Level + Building orientation + Patch
# (first entry identify the case) while the second entry is the quantity of interest.
# initializer is used to initialize the dictionaries.
initializer = HRBProbes.readHRBDataset(deltas, angles, patches, t0, t0+1, nCpu, q, 'data')
for lvl in deltas:
    for ang in angles:
        for pl in patches:
           
            dictKey = lvl + str(ang) + pl
            nTaps += len(initializer[dictKey]['meanCp'])

meanCp = np.zeros((nTaps, len(lastStep)))
rmsCp = np.zeros(meanCp.shape)
peakMaxCp = np.zeros(meanCp.shape)
peakminCp = np.zeros(meanCp.shape)

# truth stores the quantity of interest average value with the full averaging window
# e.g. if simualtion runs from 0 to 100s then truth stores mean cp averaged over 100s
truth = HRBProbes.readDat(patches, angles, deltas, directory = 'probesToDat/')

cont = 0
# HERE YOU MIGHT WANNA FIX tf AND VARY t0
for tf in lastStep:
   
    print(tf)
    # probes contains QoIs value averaged between t0 and tf
    # tf grows larger as the averaging window size is increased all the way to 100s
    probes = HRBProbes.readHRBDataset(deltas, angles, patches, t0, tf, nCpu, q, 'data')
   
    idx = 0
    nTaps = 0
   
    for lvl in deltas:
        for pl in patches:
           
            dictKey = lvl + str(ang) + pl
           
            nTaps += len(initializer[dictKey]['meanCp'])
            #print(meanCp)
            meanCp[idx:nTaps,cont]    = abs(probes[dictKey]['meanCp'] - truth[dictKey]['meanCp'])/truth[dictKey]['meanCp']
            rmsCp[idx:nTaps,cont]     = abs(probes[dictKey]['rmsCp']  - truth[dictKey]['rmsCp'])/truth[dictKey]['rmsCp']
            #print(idx,nTaps)
            idx = nTaps
            #peakMaxCp[idx:nTaps,cont] = probes[dictKey]['peakMaxCp']
            #peakminCp[idx:nTaps,cont] = probes[dictKey]['peakminCp']
    cont+=1
       

#0.0008 is the simulation timestep in seconds
x = np.transpose((lastStep-25000)*0.0008)
y = np.transpose(np.arange(0,nTaps))
xPlot = np.tile(x,(nTaps,1))
yPlot = np.transpose(np.tile(y,(nLags,1)))
#Z = np.array([[2,2,1,1,0.3,0.2],[1,2,1,0.5,0.2,0.2],[1,1,0.5,0.5,0.5,0.3],[1,1,0.5,0.5,0.3,0.3]])

levels = np.arange(0,20,0.1)

print(xPlot.shape)
print(yPlot.shape)
#print(Z.shape)
plt.contourf(xPlot, yPlot, meanCp, levels = levels)
plt.colorbar()
plt.show(block=True)
plt.close('all')

##############################################################################