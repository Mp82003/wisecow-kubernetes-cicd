
#!/bin/bash

# Application Health Checker

URL="${1:-http://localhost:4499}"
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/app_health.log"
TIMEOUT=10

mkdir -p "$LOG_DIR"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

RESULT=$(curl -s -o /dev/null \
    -w "%{http_code} %{time_total}" \
    --max-time "$TIMEOUT" "$URL" 2>/dev/null)

HTTP_STATUS=$(echo "$RESULT" | awk '{print $1}')
RESPONSE_TIME=$(echo "$RESULT" | awk '{print $2}')

if [[ "$HTTP_STATUS" == "200" ]]; then
    STATUS="UP"
    MESSAGE="Application is healthy"
else
    STATUS="DOWN"
    MESSAGE="Application is unavailable or returned an error"
    HTTP_STATUS="${HTTP_STATUS:-000}"
    RESPONSE_TIME="${RESPONSE_TIME:-N/A}"
fi

echo "=================================="
echo " Application Health Checker"
echo "=================================="
echo "URL: $URL"
echo "Status: $STATUS"
echo "HTTP Status: $HTTP_STATUS"
echo "Response Time: $RESPONSE_TIME seconds"
echo "Message: $MESSAGE"

{
    echo "$TIMESTAMP | URL=$URL | STATUS=$STATUS | HTTP=$HTTP_STATUS | RESPONSE=${RESPONSE_TIME}s"
} >> "$LOG_FILE"

echo "Log saved to $LOG_FILE"

