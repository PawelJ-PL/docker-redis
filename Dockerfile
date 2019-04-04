ARG REDIS_VERSION

FROM redis:${REDIS_VERSION}

COPY redis_entrypoint.sh /redis_entrypoint.sh
COPY run_redis_server.sh /run_redis_server.sh
COPY run_sentinel.sh /run_sentinel.sh

USER 999
ENTRYPOINT [ "/redis_entrypoint.sh" ]
