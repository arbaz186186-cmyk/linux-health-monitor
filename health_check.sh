#!/bin/bash

echo "================================"
echo "   LINUX SERVER HEALTH REPORT"
echo "================================"

echo ""
echo "DATE AND TIME:"
date

echo ""
echo "DISK USAGE:"
df -h /

echo ""
echo "MEMORY USAGE:"
free -h

echo ""
echo "CPU INFORMATION:"
lscpu | grep -E '^Model name|^CPU\(s\):'

echo ""
echo "DISK HEALTH STATUS:"

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is high!"
else
    echo "HEALTHY: Disk usage is normal."
fi

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is high!"
    echo "$(date '+%F %T') WARNING: Disk usage is ${DISK_USAGE}%" >> /home/adminarbaz186/linux-health-monitor/health_alerts.log
else
    echo "HEALTHY: Disk usage is normal."
fi
echo ""
echo "RAM HEALTH STATUS:"

RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

if [ "$RAM_USAGE" -ge 80 ]; then
    echo "WARNING: RAM usage is high!"
else
    echo "HEALTHY: RAM usage is normal."
fi

if [ "$RAM_USAGE" -ge 80 ]; then
    echo "WARNING: RAM usage is high!"
    echo "$(date '+%F %T') WARNING: RAM usage is ${RAM_USAGE}%" >> /home/adminarbaz186/linux-health-monitor/health_alerts.log
else
    echo "HEALTHY: RAM usage is normal."
fi
echo ""
echo "CPU LOAD STATUS:"
uptime

echo ""
echo "================================"
echo "OVERALL SERVER HEALTH"
echo "================================"

if [ "$DISK_USAGE" -lt 80 ] && [ "$RAM_USAGE" -lt 80 ]; then
    echo "SERVER STATUS: HEALTHY"
else
    echo "SERVER STATUS: WARNING"
fi
