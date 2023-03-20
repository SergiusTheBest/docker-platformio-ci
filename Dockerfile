FROM ubuntu:22.04
LABEL maintainer="sergey.podobry@gmail.com"
LABEL description="platformio ci"

COPY dummy-project /opt/dummy-project
WORKDIR /opt/dummy-project

RUN apt-get update &&\
    apt-get install -y --no-install-recommends python3-pip &&\
    python3 -m pip install -U platformio &&\
    pio platform install espressif8266 &&\
    pio platform install espressif32 &&\
    pio platform install raspberrypi &&\
    pio run &&\
    cd /opt &&\
    rm /opt/dummy-project -rf &&\
    pio system prune -f &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
