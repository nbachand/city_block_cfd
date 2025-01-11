#!/bin/bash

bashScript="$1"

# Define an array of numbers
# numbersC2=(53 54 55 56)
# numbersC3=(21 22 23 24)
# numbersC2=(57 58 59 60)
numbersC3=(25 26 27 28)

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
