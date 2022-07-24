#!/bin/bash

if [ ! $# -eq 2 ]; then
    echo "Two arguments needed!"
    exit 1
fi

FIRST=$1
SECOND=$2

let RESULT=FIRST*SECOND

if [ $? -ne 0 ]; then
    echo "Arguments types not match"
    exit 1
else
    echo $RESULT
fi
