FROM debian:bookworm-slim

ARG RATHOLE_VERSION=v0.5.0
ARG RATHOLE_ARCH=x86_64-unknown-linux-gnu

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl unzip \
    && curl -fsSL -o /tmp/rathole.zip \
       "https://github.com/rathole-org/rathole/releases/download/${RATHOLE_VERSION}/rathole-${RATHOLE_ARCH}.zip" \
    && unzip -j /tmp/rathole.zip rathole -d /usr/local/bin \
    && chmod 0755 /usr/local/bin/rathole \
    && rm -rf /tmp/rathole.zip /var/lib/apt/lists/*

COPY start-relay.sh /start-relay.sh
RUN chmod 0755 /start-relay.sh

EXPOSE 2333/tcp 62050/tcp
ENTRYPOINT ["/start-relay.sh"]
