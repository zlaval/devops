#!/bin/bash

if [ $# -ne 1 ]
then
 echo "File name needed"
 exit 1
fi

if ! [ -f "$1" ]
then
    echo "File $1 does not exists"
    exit 2
fi

IFS=$'\n'

COUNT=1

while read line
do
 echo "$COUNT. $line"
 let COUNT++
done < $1