FROM alpine:edge
MAINTAINER Christoph Wiechert <wio@psitrax.de>

RUN apk update \
    && apk add bash mariadb-client
RUN apk add pdns pdns-backend-mysql pdns-backend-sqlite3\
      --update-cache \
      --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
      --allow-untrusted

# fix __flt_rounds: symbol not found" bug
RUN apk add -u musl

RUN rm -rf /var/cache/apk/*

RUN mkdir -p /docker/libexec
ADD libexec /docker/libexec
RUN ln -sf /docker/libexec/manage /usr/bin/manage

EXPOSE 53

ENTRYPOINT ["manage"]
CMD ["bash"]