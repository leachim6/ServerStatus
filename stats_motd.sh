#!/bin/sh
# MOTD by Chris Purcell 2017
# Revised by Mike Donaghy
# Version 0.2 EVN BETR EDITION


PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
IPADDR=`$HOME/bin/ipa.sh eth0`
PRIVIP=`$HOME/bin/ipa.sh eth1`
KERNEL=`uname -r`
UTIME=`uptime | sed 's/,  load.*//'`
LOADAVG=`uptime | sed 's/.*average://'`
CPUINFO=`cat /proc/cpuinfo | grep -m1 "model name" | awk -F: {'print $2'}`
CPUFREQ=`cat /proc/cpuinfo | grep -m1 "MHz" | awk -F: {'print $2'}`
MEMINFO=`cat /proc/meminfo | grep MemTotal | awk {'print $2 / 1024'}`
DISTRO=`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`

if `pgrep tmux`; then
  TMUXS=`tmux ls | head -1 | cut -d" " -f 2`
else
  TMUXS="0"
fi

if [ $LOGNAME = 'root' ]; then
PRIVILEGED="Administrator"
else
PRIVILEGED="Regular User"
fi

## System Stats Section
echo -e "
\033[0;35m|―――――――――――――――――: \033[0;37mSystem Data\033[0;35m :――――――――――――――――――――
\033[0;35m|  \033[0;37mHostname    \033[0;35m= \033[1;32m`uname -n`
\033[0;35m|  \033[0;37mPublic IP   \033[0;35m= \033[1;32m$IPADDR
\033[0;35m|  \033[0;37mPrivate IP  \033[0;35m= \033[1;32m$PRIVIP
\033[0;35m|  \033[0;37mKernel      \033[0;35m= \033[1;32m$KERNEL
\033[0;35m|  \033[0;37mDistro      \033[0;35m= \033[1;32m$DISTRO
\033[0;35m|  \033[0;37mUptime      \033[0;35m=\033[1;32m$UTIME
\033[0;35m|  \033[0;37mLoad Avg    \033[0;35m=\033[1;32m$LOADAVG
\033[0;35m|  \033[0;37mCPU         \033[0;35m=\033[1;32m$CPUINFO @ $CPUFREQ mhz
\033[0;35m|  \033[0;37mMemory      \033[0;35m= \033[1;32m$MEMINFO MB
\033[0;35m|―――――――――――――――――: \033[0;37mUser Data\033[0;35m :――――――――――――――――――――――
\033[0;35m|  \033[0;37mUsername    \033[0;35m= \033[1;32m$LOGNAME
\033[0;35m|  \033[0;37mPrivileges  \033[0;35m= \033[1;32m$PRIVILEGED
\033[0;35m|  \033[0;37mTMUX        \033[0;35m= \033[1;32m$TMUXS Windows
\033[0;35m|  \033[0;37mProcesses   \033[0;35m= \033[1;32m$PROCCOUNT of `ulimit`
\033[0;35m|――――――――――――――: \033[0;37mVirtual Hosts\033[0;35m :―――――――――――――――――――――\033[1;32m"


## Nginx VHOST Config
if [ -f $HOME/bin/nginx_vhost.sh ]; then
         $HOME/bin/nginx_vhost.sh
    else
  return
fi

## Maintenance MOTD
if [ -f /etc/motd-maint ]; then
  echo -e "
\033[0;35m――――――――――――: \033[0;31mMaintenance Information\033[0;35m :――――――――――――――
\033[0;31m  `cat /etc/motd-maint`
\033[0;35m―――――――――――――――――――――――――――――――――――――――――――――――――――――
\033[0;0m
  "
else
  echo -e "\033[0;35m―――――――――――――――――――――――――――――――――――――――――――――――――――――"
fi
