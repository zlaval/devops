#!/bin/bash

START=$(date +%s)
sleep 2
END=$(date +%s)
DIFFERENCE=$(( END - START ))
echo Time elapsed: $DIFFERENCE sec
