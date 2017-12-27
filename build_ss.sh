#!/bin/bash

# Step 1. Install required software
apt update && apt install -y \
	wget \
	curl \
	git \
	autoconf \
	automake \
	g++-mipsel-linux-gnu \
	gcc-mipsel-linux-gnu \
	gettext build-essential \
	libtool

# Set path
ss_path=$(pwd)

# return to ss path
cd $ss_path

# Install mbedtls
mbedtls_ver=2.6.0 \
	&&  wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$mbedtls_ver-gpl.tgz \
	&& tar xvf mbedtls-$mbedtls_ver-gpl.tgz \
	&& cd mbedtls-$mbedtls_ver \
	&& sed -i "s/DESTDIR=\/usr\/local/DESTDIR=\/usr\/local\/mbedtls/g" Makefile \
	&& CC=mipsel-linux-gnu-gcc AR=mipsel-linux-gnu-ar LD=mipsel-linux-gnu-ld LDFLAGS=-static make \
	&& make install


# Install pcre
cd $ss_path
ver=8.40 \
	&& wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$ver.tar.gz \
	&& tar xvf pcre-$ver.tar.gz \
	&& cd pcre-$ver \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/pcre --disable-shared --enable-utf8 --enable-unicode-properties \
	&& make \
	&& make install

# Install libsodium
cd $ss_path
git clone https://github.com/jedisct1/libsodium \
	&& cd libsodium/ \
	&& ./autogen.sh \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/libsodium --disable-ssp --disable-shared \
	&& make && make install

# Install libev
cd $ss_path
ver=4.24 \
	&& wget http://dist.schmorp.de/libev/libev-$ver.tar.gz \
	&& tar xvf libev-$ver.tar.gz \
	&& cd libev-$ver \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/libev --disable-shared \
	&& make \
	&& make install

# Install c-ares
cd $ss_path
ver=1.12.0 \
	&& wget https://c-ares.haxx.se/download/c-ares-$ver.tar.gz \
	&& tar xvf c-ares-$ver.tar.gz \
	&& cd c-ares-$ver \
	&& ./configure --host=mipsel-linux-gnu --prefix=/usr/local/libcares --disable-shared --enable-utf8 --enable-unicode-properties \
	&& make \
	&& make install

# Install shadowsocks-libev
cd $ss_path
ver=3.1.1 \
	&& git clone https://github.com/shadowsocks/shadowsocks-libev \
	&& cd shadowsocks-libev \
	&& git checkout v$ver -b v$ver \
	&& git submodule update --init --recursive \
	&& ./autogen.sh \
	&& LIBS="-lpthread -lm" \
	LDFLAGS="-Wl,-static -static -static-libgcc -L/usr/local/libev/lib" \
	CFLAGS="-I/usr/local/libev/include" \
	./configure --host=mipsel-linux-gnu --prefix=$ss_path/shadowsocks-libev \
	--disable-ssp \
	--disable-documentation \
	--with-mbedtls=/usr/local/mbedtls \
	--with-pcre=/usr/local/pcre \
	--with-sodium=/usr/local/libsodium \
	--with-cares=/usr/local/libcares \
	&& make \
	&& make install
