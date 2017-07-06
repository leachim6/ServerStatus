#!/bin/bash
# Quick hacky script to list nginx vhosts

if pgrep -x "nginx" > /dev/null; then
  grep -m1 -ir server_name /etc/nginx/sites-enabled/* | sed -r 's/(.*server_name\s*|;)//g' | tr " " "\n" | grep -v "_" | column -c 75 -x
else
  exit 1
fi
