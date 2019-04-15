FROM alpine:latest

ENV PUID 1001
ENV PGID 1001
ENV PUSER rtorrent
ENV PGROUP data

COPY root /

RUN apk add --no-cache --upgrade rtorrent mysql-client nano shadow su-exec && \
	addgroup -g $PGID $PGROUP && \
	adduser -D -G $PGROUP -u $PUID $PUSER && \
	mkdir -m 775 -p /config/config.d \
	/config/.session \
	/data/film \
	/data/games \
	/data/music \
	/data/television \
	/data/rtorrent/downloads \
	/data/rtorrent/watch \
	/log \
	/scripts && \
	chmod 755 /usr/local/bin/docker-entrypoint.sh /etc/rtorrent.conf

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["rtorrent", "-n", "-o", "import=/etc/rtorrent.conf"]

VOLUME /config /data/film /data/games /data/music /data/television /data/rtorrent /log /scripts

WORKDIR /data/rtorrent/
