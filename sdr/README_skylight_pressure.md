# All-Skylight Runs and Exterior-Only Runs

This dataset holds LES results for the paper *Improving Airflow Network Models of Natural Ventilation: Geometry-Specific Pressures and Fluctuation Corrections*. That paper also uses the dataset for the paper [Simulating the urban canopy's impact on wind-driven natural ventilation](https://doi.org/10.1017/flo.2025.10039) (*Flow* 6, E1, 2026; dataset [doi:10.25740/vb900bf9392](https://doi.org/10.25740/vb900bf9392)), which this dataset supplements. That original dataset (`flowStatsMI.csv`, `roomVentilationMI.csv`) holds the runs where only the skylight house has skylights (slAll = False). This dataset adds two sets of LES results from the same simulation campaign:

1. **All-skylight runs.** Window and room statistics for the runs where every house has skylights (slAll = True).
2. **Exterior-only runs.** Opening statistics from matched exterior-only runs, which give the exterior pressures and velocities at each opening without flow through the houses.

The datasets use two kinds of simulation. **Interior-exterior runs** simulate the flow inside the houses and around them together. All window and room statistics in both datasets come from these runs. **Exterior-only runs** simulate the same cases without house interiors.

The data were processed with the code in the GitHub repository [city_block_cfd](https://github.com/nbachand/city_block_cfd). The [Terminology](#terminology) section at the end defines the columns shared with the original dataset. It is the same as in the original dataset's README.

## Files

| File | Rows | Contents |
| --- | --- | --- |
| `flowStatsMI_slAll.csv` | 8,064 | Window statistics, runs with slAll = True |
| `roomVentilationMI_slAll.csv` | 2,304 | Room statistics, runs with slAll = True |
| `pointCloudStatsNoIntMatchedMI.csv` | 16,128 | Opening statistics of the matched exterior-only runs |

## Row IDs

The first two columns of every file identify the row.

- **Run ID:** $1000\,C + 10\,R + V$, for configuration $C$ (2 or 3), run number $R$ and collection window $V$. $V = 0$ is the steady $\Delta T = 0$ window (time steps 40,000–120,000). $V = 1$ is the transient window after the interior is heated (120,000–160,000). $V = 2$ is the steady $\Delta T = 5\,^oC$ window (160,000–240,000). For example, 2610 is config2 R61, window 0.
- **Window ID** (window files): [openingType](#openingtype)-[windowNumber](#windownumber)\_h_[houseNumber](#housetype)_[blockType](#blocktype).
- **Room ID** (room files): [roomType](#roomtype)\_h_[houseNumber](#housetype)_[blockType](#blocktype). Data from individual windows are consolidated into rooms based on their ventilation configuration (corner, cross, dual, single).

## All-skylight runs

`flowStatsMI_slAll.csv` and `roomVentilationMI_slAll.csv` have the same columns and index as `flowStatsMI.csv` and `roomVentilationMI.csv` in the original dataset. Every house has skylights in these runs, so the house at position -1-0 is named `h_-1-0` like the others, not `sl`. They hold these runs:

- config2 R61–R64
- config3 R29–R31 and R33

Each run has three collection windows (run IDs ending in 0, 1 and 2), for 24 run IDs in total. Stacking a file with its counterpart in the original dataset (e.g. `pd.concat`) gives the full table for all runs.

## Exterior-only runs

### Matching

Each steady-state collection window of each interior-exterior run has its own matched exterior-only run. That run is the same case (configuration, wind angle and wind speed) simulated without house interiors, restarted from the interior-exterior run's flow state.

- **Exterior-only runs:** R76–R99 in both config2 and config3.
- **$\Delta T = 0$ windows** (run IDs ending in 0): R76–R87.
- **$\Delta T = 5\,^oC$ windows** (run IDs ending in 2): R88–R99.
- **Transient windows** (run IDs ending in 1): no exterior-only run.

The exterior-only runs cover the steady-state windows of all 24 interior-exterior runs, both slAll = False and slAll = True, for 48 run IDs.

The slAll = False conditions were each simulated twice: two interior-exterior runs with the same `csId` (e.g. config2 R46 and R53). Each exterior-only run is restarted from the flow state of its own interior-exterior run, so the two realizations of a condition have separate exterior-only runs. Every condition with slAll = False therefore has two independent exterior-only runs per temperature difference. The slAll = True conditions were simulated once. Exterior-only run numbers are per configuration (config2 R76 and config3 R76 are different runs), and they do not follow the same order in the two configurations.

| Config | Interior-exterior run | A | WS | slAll | csId | $\Delta T = 0$ exterior-only run | $\Delta T = 5\,^oC$ exterior-only run |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2 | R46 | 45 | 2 | False | 253 | R76 | R88 |
| 2 | R53 | 45 | 2 | False | 253 | R80 | R92 |
| 2 | R47 | 45 | 4 | False | 254 | R77 | R89 |
| 2 | R54 | 45 | 4 | False | 254 | R81 | R93 |
| 2 | R48 | 0 | 2 | False | 255 | R78 | R90 |
| 2 | R55 | 0 | 2 | False | 255 | R82 | R94 |
| 2 | R49 | 0 | 4 | False | 256 | R79 | R91 |
| 2 | R56 | 0 | 4 | False | 256 | R83 | R95 |
| 2 | R61 | 45 | 2 | True | 261 | R84 | R96 |
| 2 | R62 | 45 | 4 | True | 262 | R85 | R97 |
| 2 | R63 | 0 | 2 | True | 263 | R86 | R98 |
| 2 | R64 | 0 | 4 | True | 264 | R87 | R99 |
| 3 | R16 | 45 | 2 | False | 321 | R76 | R88 |
| 3 | R21 | 45 | 2 | False | 321 | R80 | R92 |
| 3 | R18 | 45 | 4 | False | 322 | R78 | R90 |
| 3 | R22 | 45 | 4 | False | 322 | R81 | R93 |
| 3 | R17 | 0 | 2 | False | 323 | R77 | R89 |
| 3 | R23 | 0 | 2 | False | 323 | R82 | R94 |
| 3 | R19 | 0 | 4 | False | 324 | R79 | R91 |
| 3 | R24 | 0 | 4 | False | 324 | R83 | R95 |
| 3 | R29 | 45 | 2 | True | 329 | R84 | R96 |
| 3 | R30 | 45 | 4 | True | 330 | R85 | R97 |
| 3 | R31 | 0 | 2 | True | 331 | R86 | R98 |
| 3 | R33 | 0 | 4 | True | 333 | R87 | R99 |

### Index

The first two columns, `run` and `index`, are the ID of the interior-exterior run the exterior-only run is matched to and the opening ID. Opening IDs follow the window statistics, except that the house at position -1-0 is always named `h_-1-0`.

- **slAll = True runs:** the window statistics also name that house `h_-1-0`, so the IDs match as they are.
- **slAll = False runs:** the window statistics name it `sl`, the skylight house. Replace `_h_-1-0` with `_sl` before joining. For example, `skylight_0-0_h_-1-0_B` here is `skylight_0-0_sl_B` in `flowStatsMI.csv`.

The table lists the skylight positions of every house, including houses that have no skylight in slAll = False runs. Those 3,840 rows have no counterpart in `flowStatsMI.csv`.

### Columns

Every column has the suffix `-noInt` (no interior), apart from the `pOnly_*` columns. `noInt` and `pOnly` (pressure-only) are the processing code's names for exterior-only runs, and they are kept in the file and column names.

| Column | Meaning |
| --- | --- |
| `p_avg-noInt` | Mean pressure at the opening: time average over the collection window, averaged over the opening's probe points |
| `p_rms-noInt` | RMS of the pressure fluctuations at the opening, averaged the same way |
| `comp(u_avg,0)-noInt`, `comp(u_avg,1)-noInt`, `comp(u_avg,2)-noInt` | Mean velocity components at the opening (x, y and z; y is vertical) |
| `windowType-noInt`, `openingType-noInt`, `windowNumber-noInt`, `houseType-noInt`, `blockType-noInt` | Opening labels, as in [Geometric Quantities](#geometric-quantities) (`houseType` uses `-1-0` for the skylight house) |
| `x-noInt`, `y-noInt`, `z-noInt`, `orientation-noInt` | Opening location and outward-normal orientation (orientation is empty for skylights) |
| `EP_*-noInt` | Extra probe 1.5 m outside the opening, as in [Extra Probes - Openings](#extra-probes---openings) |
| `EPR_mag-noInt`, `EPR_vel_orientation-noInt` | Extra roof probe, as in [Extra Probes - Roofs](#extra-probes---roofs) |
| `pOnly_runs` | The exterior-only run the row comes from, e.g. `R84` (in the run's configuration) |
| `pOnly_nMatched`, `pOnly_nMembers`, `run-noInt` | Bookkeeping from the matching step. They are 1, 1 and empty on every row, meaning each row comes from its own matched exterior-only run. |
