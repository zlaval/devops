#!/bin/bash
echo -n "Enter first number:"
read FIRST
echo -n "Enter second number:"
read SECOND

let RESULT=FIRST+SECOND
echo $RESULT

RESULT=`echo "$FIRST^$SECOND" | bc`
echo $RESULT