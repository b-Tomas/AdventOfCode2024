#!/bin/bash

FILE="input.txt"
# FILE="small.txt"

# Cut by colums separated by space and convert to arrays (IFS or Internal Field Separator is " " by default)
IFS=$'\n'
L1=(`cut -d' ' -f 1 $FILE`)
L2=(`cut -d' ' -f 4 $FILE`)
unset IFS

# Sort the arrays

# If they weren't arrays:
# Translate spaces into line breaks, sort, translate again into spaces, and turn into an array (IFS=" " by default)
# sorted1=`echo $L1 | tr ' ' '\n' | sort -n | tr '\n' ' '`
# sorted2=`echo $L2 | tr ' ' '\n' | sort -n | tr '\n' ' '`

# Feed the arrays into sort, which will output elements separated by line breaks
IFS=$'\n'
sorted1=($(sort <<< "${L1[*]}"))
sorted2=($(sort <<< "${L2[*]}"))
unset IFS

### Part 1

# Calculate sum of differences
sum=0
aux=0
for i in ${!sorted1[@]};
do
    (( aux = sorted1[i] - sorted2[i] ))
    if (( aux > 0 )); then
        (( sum += aux ))
    else
        (( sum -= aux ))
    fi
done

echo Part 1: The sum of distances is $sum
echo

### Part 2
# echo ${sorted1[@]}
# echo ${sorted2[@]}

i=0
j=0
repeats=1
len=${#sorted1[@]}
score=0
while [ $i -lt $len ]; do
    n=${sorted1[i]}

    if (( i+1 < len )) && [ $n -eq ${sorted1[i+1]} ]; then (( repeats++ ));
    else
        count=0
        k=${sorted2[j]}
        while [ $j -le $len  ] && [ $k -le $n ]; do
            if [ $k -eq $n ]; then (( count++ )); fi;
            (( j++ ))
            k=${sorted2[j]}
        done;
        echo $n appears $repeats times on the left and $count times on the right
        (( score += $n * $repeats * $count ))
        repeats=1;
    fi
    (( i++ ))
done

echo The total similarity score is $score
