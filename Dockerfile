FROM alpine:latest

ENV PUID 1001
ENV PGID 1001
ENV PUSER rtorrent
ENV PGROUP rtorrent

COPY root/etc/rtorrent.conf /etc/rtorrent.conf

RUN apk add --no-cache --upgrade rtorrent mysql-client nano && \
	mkdir -p /config/config.d && \
	mkdir -p /data/film && \
	mkdir -p /data/games && \
	mkdir -p /data/music && \
	mkdir -p /data/television && \
	mkdir -p /data/rtorrent/.session && \
	mkdir -p /data/rtorrent/downloads && \
	mkdir -p /data/rtorrent/watch && \
	mkdir -p /log && \
	mkdir -p /scripts && \
	addgroup -g $PGID $PGROUP && \
	adduser -D -G $PGROUP -u $PUID $PUSER && \
	chown -R $PUSER:$PGROUP /config /data /log /scripts /etc/rtorrent.conf

#COPY --chown=$PUSER:$PGROUP root/config/config.d/ /config/config.d/
#COPY --chown=$PUSER:$PGROUP root/etc/rtorrent.conf /etc/rtorrent.conf

VOLUME /config /data/film /data/games /data/music /data/television /data/rtorrent /log /scripts

EXPOSE 16891
#EXPOSE 6881
#EXPOSE 6881/udp
EXPOSE 50000

USER $PUSER

#CMD [ "rtorrent" ]
CMD [ "rtorrent", "-n", "-o", "import=/etc/rtorrent.conf" ]
