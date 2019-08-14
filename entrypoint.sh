#!/bin/bash

green="\033[0;32m"
end="\033[0m"
# shadowsocks version
shadowsocks_ver=3.3.1
# mbedtls
mbedtls_ver=2.6.0
# pcre
pcre_ver=8.43
# libev
libev_ver=4.25
# c-ares
cares_ver=1.13.0
# set path
prefix_path='/opt/ss-mips'
# mips use mipel-linux-gnu, mips64 use mips64-linux-gnuabi64, default is mips
if [ $ARCHITECH == "mips64" ]
then
    host=mips64-linux-gnuabi64
    strip=mips64-linux-gnuabi64-strip
else
    host=mipsel-linux-gnu
    strip=mipsel-linux-gnu-strip
fi

echo -e "$green Installing mbedtls...$end"
wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$mbedtls_ver-gpl.tgz \
    && tar xvf mbedtls-$mbedtls_ver-gpl.tgz \
    && cd mbedtls-$mbedtls_ver \
    && sed -i "s|DESTDIR=/usr/local|DESTDIR=$prefix_path/mbedtls|g" Makefile \
    && CC=$host-gcc AR=$host-ar LD=$host-ld LDFLAGS=-static make \
    && make install

echo -e "$green Installing pcre...$end"
cd
wget https://ftp.pcre.org/pub/pcre/pcre-$pcre_ver.tar.bz2 \
    && tar xvf pcre-$pcre_ver.tar.bz2 \
    && cd pcre-$pcre_ver \
    && ./configure --host=$host --prefix=$prefix_path/pcre --disable-shared --enable-utf8 --enable-unicode-properties \
    && make \
    && make install

echo -e "$green Installing libsodium...$end"
cd
git clone https://github.com/jedisct1/libsodium \
    && cd libsodium/ \
        && git checkout stable \
    && ./autogen.sh \
    && ./configure --host=$host --prefix=$prefix_path/libsodium --disable-ssp --disable-shared \
    && make && make install

echo -e "$green Installing libev...$end"
cd
wget http://dist.schmorp.de/libev/Attic/libev-$libev_ver.tar.gz \
    && tar xvf libev-$libev_ver.tar.gz \
    && cd libev-$libev_ver \
    && ./configure --host=$host --prefix=$prefix_path/libev --disable-shared \
    && make \
    && make install

echo -e "$green Installing cares...$end"
cd
wget https://c-ares.haxx.se/download/c-ares-$cares_ver.tar.gz \
    && tar xvf c-ares-$cares_ver.tar.gz \
    && cd c-ares-$cares_ver \
    && ./configure --host=$host --prefix=$prefix_path/libcares --disable-shared --enable-utf8 --enable-unicode-properties \
    && make \
    && make install

echo -e "$green Installing shadowsocks-libev...$end"
cd
git clone https://github.com/shadowsocks/shadowsocks-libev
cd shadowsocks-libev
git checkout v$shadowsocks_ver -b v$shadowsocks_ver
git submodule update --init --recursive && ./autogen.sh
LIBS="-lpthread -lm" \
LDFLAGS="-Wl,-static -static -static-libgcc -L$prefix_path/libev/lib" \
CFLAGS="-I$prefix_path/libev/include" \
./configure --host=$host --prefix=$prefix_path/ss-bin \
--disable-ssp \
--disable-documentation \
--with-mbedtls=$prefix_path/mbedtls \
--with-pcre=$prefix_path/pcre \
--with-cares=$prefix_path/libcares \
--with-sodium=$prefix_path/libsodium \
&& make \
&& make install

echo -e "$green Installing simple-obfs...$end"
cd
git clone https://github.com/shadowsocks/simple-obfs
cd simple-obfs
git submodule init && git submodule update
./autogen.sh
LIBS="-lpthread -lm" \
LDFLAGS="-Wl,-static -static -static-libgcc \
-L$prefix_path/libsodium/lib \
-L$prefix_path/libev/lib \
-L$prefix_path/libcares/lib" \
CFLAGS="-I$prefix_path/libsodium/include \
-I$prefix_path/libev/include \
-I$prefix_path/libcares/include" \
./configure --host=$host  --prefix=$prefix_path/ss-bin \
--disable-ssp \
--disable-documentation \
&& make \
&& make install

if [ $ARCHITECH == "mips64" ]
then
    find $prefix_path/ss-bin/bin ! -name 'ss-nat' -type f | xargs $strip
else
    find $prefix_path/ss-bin/bin ! -name 'ss-nat' -type f | xargs $strip
    find $prefix_path/ss-bin/bin ! -name 'ss-nat' -type f | xargs upx
fi

