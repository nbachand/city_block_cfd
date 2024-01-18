from pyCascade import probePost, physics, utils
import os
import sys
scratch_home = os.getenv('SCRATCH') #need to set SCRATCH (even if there is no real SCRATCH) to the location where results are written
scratch_dir = f'{scratch_home}/Cascade/city_block_cfd'

def resultsToParquet(run, category, probe_type, qoisOutputed = None):
    probes_dir = f'{scratch_dir}/CHARLES/{category}/R{run}/probes/probesOut'
    probes = probePost.Probes(probes_dir, probe_type = probe_type, flux_quants = qoisOutputed)
    probes.to_parquet(overwrite = True)
    return

qoisOutputed = ["mass_flux", "comp(u,0)"]
resultsToParquet(sys.argv[1], sys.argv[2], sys.argv[3], qoisOutputed)