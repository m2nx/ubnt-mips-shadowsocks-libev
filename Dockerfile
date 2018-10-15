From buildpack-deps:xenial-scm
LABEL maintainer="MMX <4isnothing@gmail.com>"

WORKDIR /opt/ss-mips/
COPY . .
RUN apt update && apt install -y \
	wget \
	curl \
	git \
	autoconf \
	automake \
	libtool \
    gettext  \
    pkg-config \
	g++-mipsel-linux-gnu \
	gcc-mipsel-linux-gnu \
	g++-mips64-linux-gnuabi64 \
	gcc-mips64-linux-gnuabi64 \
	build-essential

ENTRYPOINT ["/opt/ss-mips/entrypoint.sh"]
