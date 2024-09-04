#!/bin/bash

bashScript="$1"

# Define an array of numbers
numbersC2=(46 47 48 49)
numbersC3=(16 17 18 19)

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
