#!/bin/bash

function add {
    local first=$1
    local second=$2
    let result=first+second
    echo "Result is: $result"
}

echo -n "First number: "
read first

echo -n "Second number: "
read second

add $first $second
