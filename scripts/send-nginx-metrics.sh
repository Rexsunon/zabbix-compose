#!/bin/sh

# Load environment variables
set -a
. /scripts/.env
set +a

METRICS=$(curl -s http://host.docker.internal:4040/metrics)

REQ_200=$(echo "$METRICS" | grep 'nginx_http_requests_total{method="GET",path="/",status="200"}' | awk '{print $2}')
REQ_500=$(echo "$METRICS" | grep 'nginx_http_requests_total{status="500"}' | awk '{print $2}')

/usr/bin/zabbix_sender -z "$ZBX_SERVER_HOST" -s "$ZBX_HOSTNAME" -k nginx.req.200 -o "$REQ_200"
/usr/bin/zabbix_sender -z "$ZBX_SERVER_HOST" -s "$ZBX_HOSTNAME" -k nginx.req.500 -o "$REQ_500"

