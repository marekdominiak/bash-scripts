#!/bin/bash

# $1 = number of threads which use the most of the CPU for the process

# find java process
PID=$(top -n1 | grep -m1 java | cut -f2 -d' ')

# get thread dump of the process
JS_RESULT=$( jstack $PID )

# find all thread ids which use the most of the CPU
ALL_NIDS=$(top -n$1 -H | grep -m$1 java | cut -f2 -d' ')
for NID in $ALL_NIDS;
do
  echo "$JS_RESULT" | grep -A500 $( printf "%x" $NID ) | grep -m1 "^$" -B 500;
done
