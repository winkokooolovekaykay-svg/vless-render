# Xray-core VLESS + WebSocket on Render (free web service)
# TLS is terminated by Render's edge (*.onrender.com:443).
# Xray listens plain WS on $PORT inside the container.
FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl unzip

ARG XRAY_VERSION=26.10.31
RUN curl -fsSL -o /tmp/xray.zip \
      https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip \
    && unzip -o /tmp/xray.zip -d /usr/local/bin/ \
    && rm /tmp/xray.zip \
    && chmod +x /usr/local/bin/xray \
    && /usr/local/bin/xray version

COPY config-template.json /etc/xray/config-template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
