#!/bin/bash
for i in `$HOME/bin/nginx_vhost.sh`; do
      echo "\033[0;35m|  \033[0;37mVhosts      \033[0;35m= \033[1;32m$i\033[0;0m"
done
