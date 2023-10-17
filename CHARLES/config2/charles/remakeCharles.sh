#!/bin/bash
find . -maxdepth 1 -mindepth 1 -not -path '*/.*' -type d -exec sbatch Make.slurm
