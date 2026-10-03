#!/bin/sh
set -eu

: "${RATHOLE_TOKEN:?Set RATHOLE_TOKEN in Railway Variables}"
CONTROL_PORT=${RATHOLE_CONTROL_PORT:-2333}
DATA_PORT=${RATHOLE_DATA_PORT:-62050}
USER_PORT=${RATHOLE_USER_PORT:-8443}

cat > /tmp/rathole-server.toml <<EOF
[server]
bind_addr = "0.0.0.0:${CONTROL_PORT}"

[server.services.pasarguard_node]
type = "tcp"
token = "${RATHOLE_TOKEN}"
bind_addr = "0.0.0.0:${DATA_PORT}"

[server.services.user_traffic]
type = "tcp"
token = "${RATHOLE_TOKEN}"
bind_addr = "0.0.0.0:${USER_PORT}"
EOF

exec /usr/local/bin/rathole --server /tmp/rathole-server.toml
