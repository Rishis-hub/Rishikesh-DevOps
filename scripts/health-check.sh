#!/bin/bash
# Post-deployment health check script
# Usage: bash health-check.sh <server-ip>

SERVER_IP=$1
PORT=80
ENDPOINT="http://${SERVER_IP}:${PORT}/health"
MAX_RETRIES=10
RETRY_INTERVAL=10

echo "========================================="
echo " Running Health Check"
echo " Target: ${ENDPOINT}"
echo "========================================="

for i in $(seq 1 $MAX_RETRIES); do
    echo "Attempt ${i}/${MAX_RETRIES}..."

    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 ${ENDPOINT})

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "========================================="
        echo " Health Check PASSED — App is running!"
        echo "========================================="
        exit 0
    else
        echo "Health check returned HTTP ${HTTP_STATUS}. Retrying in ${RETRY_INTERVAL}s..."
        sleep $RETRY_INTERVAL
    fi
done

echo "========================================="
echo " Health Check FAILED after ${MAX_RETRIES} attempts!"
echo "========================================="
exit 1
