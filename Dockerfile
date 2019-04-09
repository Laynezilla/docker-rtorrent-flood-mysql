FROM alpine:latest

ENV PUID 1001
ENV PGID 1001
ENV PUSER rtorrent
ENV PGROUP data

#COPY root/etc/rtorrent.conf /etc/rtorrent.conf
#COPY root/usr/local/bin/docker-entrypoint.sh /usr/local/bin/
COPY root /

RUN apk add --no-cache --upgrade rtorrent mysql-client nano su-exec && \
	addgroup -g $PGID $PGROUP && \
	adduser -D -G $PGROUP -u $PUID $PUSER && \
	chmod +x /usr/local/bin/docker-entrypoint.sh && \
	mkdir -p /config/config.d \
	/data/film \
	/data/games \
	/data/music \
	/data/television \
	/data/rtorrent/.session \
	/data/rtorrent/downloads \
	/data/rtorrent/watch \
	/log \
	/scripts && \
	chmod 744 /etc/rtorrent.conf

#EXPOSE 16891
#EXPOSE 6881
#EXPOSE 6881/udp
#EXPOSE 50000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD [ "rtorrent", "-n", "-o", "import=/etc/rtorrent.conf" ]

VOLUME /config /data/film /data/games /data/music /data/television /data/rtorrent /log /scripts
