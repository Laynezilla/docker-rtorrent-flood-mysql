#!/bin/sh
# /usr/local/bin/docker-entrypoint.sh

if [ ! "id -u $PUSER" = $PUID ]; then
	usermod -u $PUID $PUSER
fi

if [ ! "id -g $PUSER" = $PGID ]; then
	groupmod -g $PGID $PGROUP
fi

chown $PUSER:$PGROUP /config /data/{film,games,music,rtorrent/{.session/downloads/watch}} /log /scripts /etc/rtorrent.conf

su-exec $PUSER:$PGROUP "$@"
