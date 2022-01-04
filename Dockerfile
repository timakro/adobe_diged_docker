FROM debian:bullseye

RUN sed -i 's/ main/ main contrib non-free/' /etc/apt/sources.list
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    wine \
    winetricks \
    x11vnc \
    xvfb \
    procps \
 && rm -rf /var/lib/apt/lists/*

RUN useradd --home /app --create-home app
USER app

WORKDIR /app

COPY container/ .
