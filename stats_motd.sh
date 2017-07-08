#!/bin/sh
# MOTD by Chris Purcell 2017
# Revised by Mike Donaghy
# Version 0.2 EVN BETR EDITION

# Load Bash Colors Library
. $(dirname "0")/bash_colors.sh

HNAME=`uname -n`
PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
IPADDR=`$(dirname "0")/ipa.sh eth0`
PRIVIP=`$(dirname "0")/ipa.sh eth1`
KERNEL=`uname -r`
UTIME=`uptime | sed 's/,  load.*//'`
LOADAVG=`uptime | sed 's/.*average://'`
CPUINFO=`cat /proc/cpuinfo | grep -m1 "model name" | awk -F: {'print $2'}`
CPUFREQ=`cat /proc/cpuinfo | grep -m1 "MHz" | awk -F: {'print $2'}`
MEMINFO=`cat /proc/meminfo | grep MemTotal | awk {'print $2 / 1024'}`
DISTRO=`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`
TMUXS=`tmux ls | head -1 | cut -d" " -f 2`

if [ $LOGNAME = 'root' ]; then
PRIVILEGED="Administrator"
else
PRIVILEGED="Regular User"
fi

## System Stats Section
echo "
$Pur|―――――――――――――――――: $Whi System Data$Pur :――――――――――――――――――――
$Pur|  $Whi Hostname    $Pur= $BGre$HNAME
$Pur|  $Whi Public IP   $Pur= $BGre$IPADDR
$Pur|  $Whi Private IP  $Pur= $BGre$PRIVIP
$Pur|  $Whi Kernel      $Pur= $BGre$KERNEL
$Pur|  $Whi Distro      $Pur= $BGre$DISTRO
$Pur|  $Whi Uptime      $Pur=$BGre$UTIME
$Pur|  $Whi Load Avg    $Pur=$BGre$LOADAVG
$Pur|  $Whi CPU         $Pur=$BGre$CPUINFO @ $CPUFREQ mhz
$Pur|  $Whi Memory      $Pur= $BGre$MEMINFO MB
$Pur|―――――――――――――――――: $Whi User Data$Pur :――――――――――――――――――――――
$Pur|  $Whi Username    $Pur= $BGre$LOGNAME
$Pur|  $Whi Privileges  $Pur= $BGre$PRIVILEGED
$Pur|  $Whi TMUX        $Pur= $BGre$TMUXS Windows
$Pur|  $Whi Processes   $Pur= $BGre$PROCCOUNT of `ulimit`
$Pur|――――――――――――――: $Whi Virtual Hosts$Pur :―――――――――――――――――――――$BGre"


## Nginx VHOST Config
if [ -f `dirname "0"`/nginx_vhost.sh ]; then
  echo "N̲g̲i̲n̲x̲ ̲V̲h̲o̲s̲t̲s̲ ̲D̲e̲t̲e̲c̲t̲e̲d̲:"
  $(dirname "0")/nginx_vhost.sh
    else
  echo 
fi

## Maintenance MOTD
if [ -f /etc/motd-maint ]; then
  echo "
$Pur――――――――――――: $RedMaintenance Information$Pur :――――――――――――――
$Red  `cat /etc/motd-maint`
$Pur―――――――――――――――――――――――――――――――――――――――――――――――――――――
$RCol
  "
else
  echo "$Pur―――――――――――――――――――――――――――――――――――――――――――――――――――――"
fi
