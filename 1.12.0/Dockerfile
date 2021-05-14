FROM debian:buster-slim as unbound
LABEL maintainer="Tinashe Chikomo"

ENV NAME=unbound \
    UNBOUND_VERSION=1.12.0 \
    UNBOUND_SHA256=5b9253a97812f24419bf2e6b3ad28c69287261cf8c8fa79e3e9f6d3bf7ef5835

WORKDIR /tmp/src

RUN build_deps="curl apt-utils gcc make libexpat1-dev libssl-dev libudev-dev libevent-dev libnghttp2-dev libsodium-dev" && \
    set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
      $build_deps \
      bsdmainutils \
      ca-certificates \
      ldnsutils && \
      curl -sSL "https://nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz" -o unbound.tar.gz && \
    echo "${UNBOUND_SHA256} *unbound.tar.gz" | sha256sum -c - && \
    tar xzf unbound.tar.gz && \
    rm -f unbound.tar.gz && \
    cd "unbound-${UNBOUND_VERSION}" && \
    groupadd _unbound && \
    useradd -g _unbound -s /etc -d /dev/null _unbound && \
    ./configure \
        --disable-dependency-tracking \
        --prefix=/opt/unbound \
        --with-pthreads \
        --with-username=_unbound \
        --with-libevent \
        --with-libnghttp2 \
        --enable-tfo-server \
        --enable-tfo-client \
        --enable-event-api && \
    make install && \
    mv /opt/unbound/etc/unbound/unbound.conf /opt/unbound/etc/unbound/unbound.conf.example && \
    apt-get purge -y --auto-remove \
      $build_deps && \
    rm -rf \
        /opt/unbound/share/man \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*


FROM debian:buster-slim
LABEL maintainer="Tinashe Chikomo"

ENV NAME=unbound \
    VERSION=1.2 \
    SUMMARY="${NAME} is a validating, recursive, and caching DNS resolver." \
    DESCRIPTION="${NAME} is a validating, recursive, and caching DNS resolver."

LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="Unbound ${UNBOUND_VERSION}" \
      name="hybridadmin/${NAME}" \
      maintainer="Tinashe Chikomo"

WORKDIR /tmp/src

COPY --from=unbound /opt /opt

RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
      sudo \
      curl \
      bsdmainutils \
      iproute2 \
      ca-certificates \
      ldnsutils \
      libexpat1-dev \
      libevent-dev \
      libnghttp2-dev && \
    groupadd _unbound && \
    useradd -g _unbound -s /etc -d /dev/null _unbound && \
    apt-get purge -y --auto-remove \
      $build_deps && \
    rm -rf \
        /opt/unbound/share/man \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

COPY unbound_dnsbl.sh /opt/unbound/etc/unbound/
RUN chmod +x /opt/unbound/etc/unbound/unbound_dnsbl.sh && /opt/unbound/etc/unbound/unbound_dnsbl.sh
COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

WORKDIR /opt/unbound/

ENV PATH /opt/unbound/sbin:"$PATH"

EXPOSE 53/tcp
EXPOSE 53/udp

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["/docker-entrypoint.sh"]
