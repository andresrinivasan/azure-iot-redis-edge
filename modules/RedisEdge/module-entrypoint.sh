#!/usr/bin/env sh

redis-server --save "" --port 6379 --daemonize yes

exec /module/edge-hooks.js
