FROM alpine:latest

RUN apk add --no-cache curl zabbix-sender busybox-suid

COPY send-nginx-metrics.sh /scripts/
RUN chmod +x /scripts/send-nginx-metrics.sh

# Add cron entry (runs every minute)
RUN echo "* * * * * /scripts/send-nginx-metrics.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

CMD ["crond", "-f", "-L", "/var/log/cron.log"]
