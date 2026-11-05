#!/bin/bash

rm -f /run/squid.pid

/usr/local/bin/alert.sh &

exec squid -N -f /etc/squid/squid.conf