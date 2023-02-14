FROM ubuntu:focal

WORKDIR /app

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install build-essential git gcc make cmake debhelper dh-make devscripts libssl-dev

RUN git clone https://github.com/eclipse/paho.mqtt.c.git .

WORKDIR /app/build

COPY CMakeCache.txt .

RUN cmake ..
RUN cmake --build .
RUN cmake --build . --target package

FROM ghcr.io/syslog-ng/dbld-ubuntu-focal

WORKDIR /package

COPY --from=0 /app/build/libpaho-mqtt_1.3.12_amd64.deb .
RUN apt-get update
RUN apt-get install apt-utils
RUN apt-get install ./*.deb
