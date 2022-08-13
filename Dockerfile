FROM debian:bookworm

RUN sed -i 's/ main/ main contrib non-free/' /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    x11vnc \
    xvfb \
    procps \
 && dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    winetricks wine32 \
 && rm -rf /var/lib/apt/lists/*

RUN useradd --home /app --create-home app
USER app

WORKDIR /app

COPY container/ .
