#!/bin/bash
NUMBER=5
let RESULT=NUMBER+3
echo $RESULT
RESULT=$(( NUMBER + 4 ))
echo $RESULT
RESULT=$[ NUMBER + 5 ]
echo $RESULT
RESULT=$(expr $NUMBER + 6)
echo $RESULT
RESULT=`echo "$NUMBER * 1.9" | bc`
echo $RESULT