
#!/bin/bash

# System Health Monitoring Script

LOG_DIR="logs"
LOG_FILE="$LOG_DIR/system_health.log"

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

mkdir -p "$LOG_DIR"

echo "========================================"
echo " System Health Monitoring"
echo "========================================"

echo "Timestamp: $(date)"
echo ""

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)

echo "CPU Usage: ${CPU_USAGE}%"

# Memory Usage
MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

echo "Memory Usage: ${MEMORY_USAGE}%"

# Disk Usage
DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Disk Usage: ${DISK_USAGE}%"

echo ""
echo "Top 5 CPU Consuming Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# Threshold Alerts
{
    echo "Timestamp: $(date)"
    echo "CPU Usage: ${CPU_USAGE}%"
    echo "Memory Usage: ${MEMORY_USAGE}%"
    echo "Disk Usage: ${DISK_USAGE}%"

    if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
        echo "ALERT: High CPU usage!"
    fi

    if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
        echo "ALERT: High Memory usage!"
    fi

    if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
        echo "ALERT: High Disk usage!"
    fi

    echo "----------------------------------------"
} >> "$LOG_FILE"

echo ""
echo "Health report saved to $LOG_FILE"

