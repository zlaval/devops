#!/bin/bash

array=($(ls *.sh))
count=0

for file in "${array[@]}"
do 
    echo -n $file
    echo -n "[${#array[$count]}]"
    if [ -w $file ]
    then
        echo -e "\t YES"
    else
        echo -e "\t NO"
    fi
    let count++
done