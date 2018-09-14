#!/usr/bin/env sh

set -e

## From https://github.com/docker-library/redis/blob/master/5.0-rc

# # first arg is `-f` or `--some-option`
# # or first arg is `something.conf`
# if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
# 	set -- redis-server "$@"
# else
# 	## Disable persistence
# 	## XXX Make this configurable
# 	set -- redis-server --save ''	
# fi

# # allow the container to be started with `--user`
# if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
# 	chown -R redis .
# 	exec gosu redis "$0" "$@"
# fi

redis-server --save "" --port 16739 --daemonize yes

PYTHONUNBUFFERED=true
exec /module/edge-hooks.py