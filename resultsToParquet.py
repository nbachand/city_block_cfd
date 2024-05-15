from pyCascade import probePost, physics, utils
import os
import sys
scratch_home = os.getenv('SCRATCH') #need to set SCRATCH (even if there is no real SCRATCH) to the location where results are written
oak_home = os.getenv('OAK_HOME')
scratch_dir = f'{scratch_home}/Cascade/city_block_cfd'
home_dir = f'{oak_home}/Cascade/city_block_cfd'


def resultsToParquet(run, category, probe_type):
    probes_dir = f'{scratch_dir}/CHARLES/{category}/R{run}/probes/probesOut'
    oak_probes_dir =  f'{home_dir}/CHARLES/{category}/R{run}/probes/probesOut_parquet/'
    probes = probePost.Probes(probes_dir, directory_parquet = oak_probes_dir, probe_type = probe_type, file_type="csv")
    probes.to_parquet(overwrite = True)
    return

# qoisOutputed = ["mass_flux", "comp(u,0)", "T"] This does not matter for writing parquets
resultsToParquet(sys.argv[1], sys.argv[2], sys.argv[3])