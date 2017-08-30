#!/bin/bash
# Quick hacky script to list nginx vhosts
source $(dirname "0")/bash_colors.sh

if pgrep -x "nginx" > /dev/null; then
 grep -I -m1 -ir server_name /etc/nginx/* |grep -v "#"| sed -r 's/(.*server_name\s*|;)//g' | tr " " "\n" | grep -v "_" | pr -2 -t | while read line; do /bin/echo -e "$Pur|$BGre$line"; done
fi
