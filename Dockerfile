FROM ghcr.io/syslog-ng/dbld-ubuntu-focal

WORKDIR /app

COPY libpaho-mqtt_1.3.12_amd64.deb .

RUN apt-get install ./libpaho-mqtt_1.3.12_amd64.deb

