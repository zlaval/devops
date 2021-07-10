#!/bin/bash

for FILE in *.txt
do
    echo $(date) >> $FILE
    ps -ef | head -5 >> $FILE
done

