# Redis Docker image

This docker image run Redis or Sentinel server and convert environment variables prefixed with `REDIS_CONFIG_` or `SENTINEL_CONFIG_` to Redis configuration directives.

#### Examples:

Run Redis with `port=6379` and `requirepass=secret`
```
docker run -p 6379:6379 -ti -e REDIS_CONFIG_PORT=6379 -e REDIS_CONFIG_REQUIREPASS=secret  paweljpl/redis
```

Run Sentinel(because of `ROLE=sentinel`) with `daemonize=no`. Create monitor named `primary` (it can be changed) with master `127.0.0.1:6379` and quorum `1`. Use password `secret` to authenticate to master.
```
docker run -p 26379:26379 -ti -e ROLE=sentinel -e SENTINEL_CONFIG_GLOBAL_DAEMONIZE=no -e "SENTINEL_CONFIG_PRIMARY_MONITOR=127.0.0.1 6379 1" -e SENTINEL_CONFIG_PRIMARY_AUTH_PASS=secret paweljpl/redis
```
