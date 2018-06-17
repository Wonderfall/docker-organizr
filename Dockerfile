FROM wonderfall/nginx-php:7.2

ENV GID=991 UID=991 \
    UPLOAD_MAX_SIZE=10M \
    MEMORY_LIMIT=128M

RUN apk -U upgrade && apk add git \
 && git clone -b v2-develop --depth=1 https://github.com/causefx/Organizr \
 && mv Organizr organizr \
 && apk del git && rm -f /var/cache/apk/*

COPY rootfs /

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

VOLUME /organizr/db /organizr/api/config /php/session

EXPOSE 8888

CMD ["run.sh"]
