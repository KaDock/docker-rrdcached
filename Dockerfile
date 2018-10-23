FROM alpine:3.8

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="CrazyMax" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="rrdcached" \
  org.label-schema.description="RRDcached" \
  org.label-schema.version=$VERSION \
  org.label-schema.url="https://github.com/crazy-max/docker-rrdcached" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/crazy-max/docker-rrdcached" \
  org.label-schema.vendor="CrazyMax" \
  org.label-schema.schema-version="1.0"

ARG RRDCACHED_VERSION="1.7.0-r0"
ARG RRDCACHED_UID="1000"
ARG RDDCACHED_GID="1000"

RUN set -x \
    \
    && addgroup -g ${RDDCACHED_GID} rrdcached \
    && adduser -u ${RRDCACHED_UID} -G rrdcached -s /sbin/nologin -D -H rrdcached

RUN set -x \
    \
    && apk add --no-cache \
        rrdtool-cached=${RRDCACHED_VERSION}

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 42217/udp

VOLUME [ "/var/lib/rrdcached/journal", "/var/lib/rrdcached/db", "/run/rrdcached" ]

ENTRYPOINT [ "/entrypoint.sh" ]
