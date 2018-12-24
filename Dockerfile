FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
    git \
    xz-utils \
    software-properties-common \ 
    gcc-arm-none-eabi \
    u-boot-tools \
    make \
    g++ \ 
    wget \
    unzip \
    libboost-all-dev \
    cmake \
    lcov \
    ruby \
    bison \
    libxerces-c-dev \
    python3-pip \
    language-pack-ja-base language-pack-ja \
    clang-format \
    && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


WORKDIR /opt/

ENV EV3RT_MR_NAME=beta2.1.0

RUN \
  wget --no-check-certificate https://www.toppers.jp/download.cgi/mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}.tar.gz && \
  tar zxvf mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}.tar.gz && \
  rm mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}.tar.gz

# make mruby
WORKDIR /opt/mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}/mruby
RUN make

# make cfg
WORKDIR /opt/mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}/hr-tecs/cfg
RUN make

# make mruby-ev3rt with sd
WORKDIR /opt/mruby-on-ev3rt+tecs_package-${EV3RT_MR_NAME}/hr-tecs/workspace/sd
RUN make tecs
RUN make depend
RUN sed -i "s^#MKIMAGE = mkimage^MKIMAGE = mkimage^g" Makefile && \
    sed -i 's^MKIMAGE = $(SRCDIR)/../bin/mkimage.exe^#MKIMAGE = $(SRCDIR)/../bin/mkimage.exe^g' Makefile

RUN mkdir -p /cygdrive/e/
RUN make mrb

RUN ls -al /cygdrive/e/

# add build script
COPY build_app.sh /build_app.sh
RUN chmod +x /build_app.sh
