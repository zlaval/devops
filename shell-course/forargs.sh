#!/bin/bash

COUNT=1

for ARG in "$@"
do
    echo  "$COUNT. argument: $ARG"
    let COUNT++
done