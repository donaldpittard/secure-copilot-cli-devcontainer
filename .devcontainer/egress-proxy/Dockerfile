FROM ubuntu/squid:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

COPY alert.sh /usr/local/bin/alert.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/alert.sh /usr/local/bin/entrypoint.sh

EXPOSE 3128

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]