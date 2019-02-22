#!/bin/bash

awk 'tolower($0) ~ /cron/,!/sudo/ {if(NF<=12)print}' /var/log/syslog >> ~/modul1/user.log
