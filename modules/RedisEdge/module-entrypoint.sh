#!/bin/sh

## From https://github.com/docker-library/redis/blob/master/5.0-rc

set -e

## Added: Enable the hooks for the Edge runtime
#gosu redis bash -c 'python -u /module/edge-hooks.py >/var/log/edge-hook.log 2>&1 &'
python -u /module/edge-hooks.py &

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	exec gosu redis "$0" "$@"
fi

exec "$@"