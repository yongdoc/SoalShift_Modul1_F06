#!/bin/bash

awk 'tolower($0) ~ !/sudo/,/cron/ {if(NF<=12)print}' /var/log/syslog >> ~/user.log
