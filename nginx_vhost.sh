#!/bin/bash
# Quick hacky script to list nginx vhosts
source $(dirname "0")/bash_colors.sh

if pgrep -x "nginx" > /dev/null; then
 grep -m1 -ir server_name /etc/nginx/sites-enabled/* /etc/nginx/conf.d |grep -v "#"| sed -r 's/(.*server_name\s*|;)//g' | tr " " "\n" | grep -v "_" | pr -2 -t | while read line; do echo -e "$Pur|$BGre$line"; done
else
  exit 1
fi
