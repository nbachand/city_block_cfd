#!/bin/bash

bashScript="$1"

# Define an array of numbers
# numbersC2=(21 22 23 24 25 27 28 29 30 33 34 35)
numbersC3=(5 6 7 8 9 10 11 12)

# Iterate through the array
cd ./config2
for num in "${numbersC2[@]}"; do
    cd "R$num"
    echo "$(pwd)"
    sbatch "./$bashScript" &
    cd ../
done

cd ../config3
for num in "${numbersC3[@]}"; do
    cd "R$num"
    echo "$(pwd)"
    sbatch "./$bashScript" &
    cd ../
done

cd ../
