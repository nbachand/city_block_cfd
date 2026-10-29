#!/bin/bash
# Clean up and resubmit the 40 matched pressure-only runs that were started (2026-10-28) with the stale
# 216-point probes/locations/extraProbe.txt copied from their templates, instead of the 360-point
# exterior-probe layout the original no-interior runs used (CHARLES/config<C>/noInt_locations/).
# Their jobs were cancelled at ~1.5 h in (R82 at ~3 h).
#
#   bash resubmit_badprobe_runs.sh --dry-run   # show what would be done
#   bash resubmit_badprobe_runs.sh             # clean up, install the correct layout, resubmit
#
# Per run: refuse if its job is still queued; rename the Oak slurm logs to *.badprobes; delete the
# partial scratch outputs (data/*, probes/probesOut/*, Images/*, probes/VolProbe90[XZ].svp); copy the
# verified extraProbe.txt + nameKey_extraProbe.txt into its scratch probes/locations; check the md5;
# then submit it with submit_matched_noint_runs.sh (which skips everything that still has a log).

set -u
DRY=${1:-}
CB=/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd
C=$CB/CHARLES
S=$SCRATCH/Cascade/city_block_cfd/CHARLES
RUNS="2:77 2:79 2:81 2:82 2:83 2:85 2:86 2:87 2:89 2:91 2:93 2:94 2:95 2:97 2:98 2:99
      3:76 3:77 3:78 3:79 3:80 3:81 3:82 3:83 3:84 3:85 3:86 3:87 3:88 3:89 3:90 3:91 3:92 3:93 3:94 3:95 3:96 3:97 3:98 3:99"
queued=$(squeue --me -h -o "%j")
for c in 2 3; do good[$c]=$(md5sum < $C/config$c/noInt_locations/extraProbe.txt | cut -d' ' -f1); done

n=0
for cr in $RUNS; do
    c=${cr%:*}; r=${cr#*:}
    o=$C/config$c/R$r; d=$S/config$c/R$r
    if grep -qx "cc${c}_R$r" <<< "$queued"; then echo "config$c R$r: job still queued/running, skipped"; continue; fi
    if [ ! -d "$d/probes/locations" ] || [ ! -f "$o/charles.slurm" ]; then echo "config$c R$r: folder missing, skipped"; continue; fi
    if [ -n "$DRY" ]; then
        echo "config$c R$r: would rename $(ls $o/slurm-*.out 2>/dev/null | wc -l) log(s), clear $(du -sh $d/data $d/probes/probesOut $d/Images 2>/dev/null | awk '{print $1}' | paste -sd/) of outputs, install layout"
        continue
    fi
    for f in "$o"/slurm-*.out; do [ -e "$f" ] && mv "$f" "$f.badprobes"; done
    rm -rf "$d"/data/* "$d"/probes/probesOut/* "$d"/Images/* "$d"/probes/VolProbe90X.svp "$d"/probes/VolProbe90Z.svp
    cp "$C/config$c/noInt_locations/extraProbe.txt" "$C/config$c/noInt_locations/nameKey_extraProbe.txt" "$d/probes/locations/"
    [ "$(md5sum < $d/probes/locations/extraProbe.txt | cut -d' ' -f1)" = "${good[$c]}" ] || { echo "config$c R$r: layout copy FAILED"; exit 1; }
    echo "config$c R$r: cleaned, layout installed"; n=$((n+1))
done
[ -n "$DRY" ] && exit 0
echo "$n runs cleaned; submitting"
bash "$CB/submit_matched_noint_runs.sh"
