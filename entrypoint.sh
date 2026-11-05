#!/bin/sh
# Render injects $PORT; the VLESS UUID comes from the $UUID env var (never baked into the image).
set -e

if [ -z "$UUID" ]; then
  echo "ERROR: UUID env var is not set" >&2
  exit 1
fi

PORT="${PORT:-10000}"

sed -e "s/UUID_PLACEHOLDER/$UUID/g" -e "s/PORT_PLACEHOLDER/$PORT/g" \
  /etc/xray/config-template.json > /etc/xray/config.json

echo "[xray] starting VLESS+WS on 0.0.0.0:$PORT path /vless"
exec /usr/local/bin/xray run -config /etc/xray/config.json
