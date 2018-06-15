#!/bin/bash
ver=3.2.0
cd /usr/local/ss
git clone https://github.com/shadowsocks/shadowsocks-libev
cd shadowsocks-libev 
git checkout v$ver -b v$ver
git submodule update --init --recursive && ./autogen.sh
LIBS="-lpthread -lm" \
LDFLAGS="-Wl,-static -static -static-libgcc -L/usr/local/libev/lib" \
CFLAGS="-I/usr/local/libev/include" \
./configure --host=mipsel-linux-gnu --prefix=/usr/local/ss/erx \
--disable-ssp \
--disable-documentation \
--with-mbedtls=/usr/local/mbedtls \
--with-pcre=/usr/local/pcre \
--with-cares=/usr/local/libcares \
--with-sodium=/usr/local/libsodium \
&& make \
&& make install \
&& rm -rf ../shadowsocks-libev


