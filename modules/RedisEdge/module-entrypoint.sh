#!/bin/sh

## From https://github.com/docker-library/redis/blob/master/5.0-rc

echo '$@='"$@"

set -ex

## Added: Enable the hooks for the Edge runtime
## XXX Should this write to a log file?
python -u /module/edge-hooks.py &

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
else
	## Disable persistence
	## XXX Make this configurable
	set -- redis-server --save ''	
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	exec gosu redis "$0" "$@"
fi

exec "$@"