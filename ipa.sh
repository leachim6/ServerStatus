#!/bin/bash
[ -n "$1" ] || exit 1
IP=$(ip -4 -o addr show dev $1 primary 2>/dev/null)
IP=${IP%%/*}
IP=${IP##* }
[ -n "$IP" ] && echo $IP || exit 1
