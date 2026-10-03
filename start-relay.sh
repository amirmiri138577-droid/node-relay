#!/bin/sh
set -eu

: "${RATHOLE_TOKEN:?Set RATHOLE_TOKEN in Railway Variables}"
CONTROL_PORT=${RATHOLE_CONTROL_PORT:-2333}
DATA_PORT=${RATHOLE_DATA_PORT:-62050}

cat > /tmp/rathole-server.toml <<EOF
[server]
bind_addr = "0.0.0.0:${CONTROL_PORT}"
default_token = "${RATHOLE_TOKEN}"

[server.services.pasarguard_node]
type = "tcp"
bind_addr = "0.0.0.0:${DATA_PORT}"
EOF

exec /usr/local/bin/rathole --server /tmp/rathole-server.toml
