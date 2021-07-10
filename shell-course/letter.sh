#!/bin/bash

if [ ! $#  -eq 2 ]
then
    echo "Please use exactly two argument with letter text and letter param, like: ./letter.sh letter.txt letterparam.txt"
    exit 1
fi

LETTER_FILE=$1
PARAM_FILE=$2

if ! [ -f "$LETTER_FILE" ]
then
    echo "You must provide a valid file in the first parameter"
    exit 2
fi

if ! [ -f "$PARAM_FILE" ]
then
    echo "You must provide a valid file in the second parameter"
    exit 2
fi

while read LINE; do
    PARAMS=($LINE)
    NAME=${PARAMS[0]}
    DATE=${PARAMS[1]}
    ADDRESS=${PARAMS[2]}
    sed -e "s/<name>/$NAME/g" -e "s/<date>/$DATE/g" -e "s/<address>/$ADDRESS/g" -e 's/./*/77' $LETTER_FILE
done <$PARAM_FILE

exit 0

