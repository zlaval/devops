#!/bin/bash

ARRAY=(one two three)

echo ${ARRAY[0]}
echo ${ARRAY[@]}  #all item
echo ${!ARRAY[@]} #all index
echo ${#ARRAY[@]} #number of items
echo ${#ARRAY[0]} #length of the 0. element

echo ${ARRAY[*]} #all item, delimiter is the IFS first character