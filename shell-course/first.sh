#!/bin/bash
MESSAGE="Enter your name:"
echo -n "$MESSAGE"
read NAME
echo "Hello $NAME"
read -p "Your age:" AGE
echo "You are $AGE years old"
