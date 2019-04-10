#!/bin/sh
# /usr/local/bin/docker-entrypoint.sh

set -e

if [ ! $(id -u $PUSER) == $PUID ]; then
	usermod -u $PUID $PUSER
fi

if [ ! $(id -g $PUSER) == $PGID ]; then
	groupmod -g $PGID $PGROUP
fi

chown $PUSER:$PGROUP /config /data/film /data/games /data/music /data/rtorrent/.session /data/rtorrent/downloads /data/rtorrent/watch /log /scripts /etc/rtorrent.conf

exec su-exec $PUSER:$PGROUP "$@"
