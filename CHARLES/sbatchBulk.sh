#!/bin/bash

bashScript="$1"

# Define an array of numbers
# numbersC2=() #(53 54 55 56 46 47 48 49)
# numbersC3=(21 22 23 24 16 17 18 19)
numbersC2=(57 58 59 60)
numbersC3=(25 26 27 28)
# numbersC2=(46 47 48 49)
# numbersC3=(16 17 18 19)
# numbersC2=(61 62 63 64)
# numbersC3=(29 30 31 32)

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
