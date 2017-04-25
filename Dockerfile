FROM erlang:19.3-slim

RUN DEBIAN_FRONTEND=noninteractive \
    && buildDeps=' \
        ca-certificates \
        gcc \
        make \
        wget \
      ' \
    && apt-get -qq update \
    && apt-get -y --no-install-recommends install $buildDeps \
    && wget https://github.com/jedisct1/libsodium/releases/download/1.0.12/libsodium-1.0.12.tar.gz \
    && tar xzf libsodium-1.0.12.tar.gz \
    && cd libsodium-1.0.12 \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /libsodium-1.0.12.tar.gz /libsodium-1.0.12 \
    && rm -rf /var/lib/apt/lists/*

CMD ["erl"]
