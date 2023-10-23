#!/bin/bash
find . -mindepth 1 -maxdepth 3 -name '*Make.slurm' -type f -execdir pwd \;;
find . -mindepth 1 -maxdepth 3 -name '*slurm-*' -type f -execdir rm {} \;;
find . -mindepth 1 -maxdepth 3 -name '*Make.slurm' -type f -execdir sbatch {} \;;