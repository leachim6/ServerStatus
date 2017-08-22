#!/bin/bash
for i in `ip -o -4 addr |awk -F" " '{ print $2":=:" $4 }'`; do echo $RED $i; done | grep -v ^lo
