#!/bin/bash

IFS=","
echo "Script name: $0"
echo "First arg: $1"
echo "Second arg: $2"
echo "All args with \$@: $@"
echo "All args with \$*: $*"
echo "Args count: $#"