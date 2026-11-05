#!/bin/bash

LOG_FILE="/var/log/squid/access.log"
NTFY_TOPIC="secure-dev-alerts"
NTFY_SERVER="http://ntfy-server"

echo "Proxy alert monitor started, watching $LOG_FILE..."

# Wait until the log file appears (Squid initialization)
while [ ! -f "$LOG_FILE" ]; do
    sleep 2
done

# Tail the log file continuously
stdbuf -oL tail -F "$LOG_FILE" | while read -r line; do
    if echo "$line" | grep -qE "TCP_DENIED|403"; then
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        message="Blocked egress attempt detected at $timestamp:\n\n$line"
        
        # Send push notification to your local self-hosted ntfy server
        http_code=$(curl -s -o /dev/null -w "%{http_code}" \
            -d "$message" \
            -H "Title: ⚠️ Security Alert" \
            -H "Priority: high" \
            -H "Tags: warning,shield" \
            "$NTFY_SERVER/$NTFY_TOPIC")

        if [ "$http_code" -eq 200 ]; then
            echo "[$timestamp] Local ntfy alert successfully dispatched."
        else
            echo "[$timestamp] ERROR: Failed to send ntfy alert (HTTP $http_code)"
        fi
    fi
done