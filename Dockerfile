FROM redis

COPY --chown=redis:redis redis.conf /data/redis.conf
COPY --chown=redis:redis certs /data/certs

CMD ["redis-server", "/data/redis.conf"]
