From buildpack-deps:xenial-scm

LABEL maintainer="MMX <4isnothing@gmail.com>"


WORKDIR /usr/local/ss/
# netease source
#COPY sources.list /etc/apt/sources.list
VOLUME /usr/local/ss/
COPY . /usr/local/ss/
RUN apt update && apt install -y \
	wget \
	curl \
	git \
	autoconf \
	automake \
	g++-mipsel-linux-gnu \
	gcc-mipsel-linux-gnu \
	gettext build-essential \
	libtool \
    gettext

# mbedtls
RUN mbedtls_ver=2.6.0 \
	&&  wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$mbedtls_ver-gpl.tgz \
	&& tar xvf mbedtls-$mbedtls_ver-gpl.tgz \
	&& cd mbedtls-$mbedtls_ver \
	&& sed -i "s/DESTDIR=\/usr\/local/DESTDIR=\/usr\/local\/mbedtls/g" Makefile \
	&& CC=mipsel-linux-gnu-gcc AR=mipsel-linux-gnu-ar LD=mipsel-linux-gnu-ld LDFLAGS=-static make \
	&& make install

# pcre
RUN ver=8.40 \
	&& wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$ver.tar.gz \
	&& tar xvf pcre-$ver.tar.gz \
	&& cd pcre-$ver \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/pcre --disable-shared --enable-utf8 --enable-unicode-properties \
	&& make \
	&& make install

# libsodium
RUN git clone https://github.com/jedisct1/libsodium \
	&& cd libsodium/ \
        && git checkout stable \
	&& ./autogen.sh \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/libsodium --disable-ssp --disable-shared \
	&& make && make install

# libev
RUN ver=4.24 \
	&& wget http://dist.schmorp.de/libev/libev-$ver.tar.gz \
	&& tar xvf libev-$ver.tar.gz \
	&& cd libev-$ver \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/libev --disable-shared \
	&& make \
	&& make install

# c-ares
RUN ver=1.12.0 \
	&& wget https://c-ares.haxx.se/download/c-ares-$ver.tar.gz \
	&& tar xvf c-ares-$ver.tar.gz \
	&& cd c-ares-$ver \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/libcares --disable-shared --enable-utf8 --enable-unicode-properties \
	&& make \
	&& make install

# shadowsocks-libev
RUN chmod +x /usr/local/ss/entrypoint.sh 

ENTRYPOINT ["/usr/local/ss/entrypoint.sh"]
