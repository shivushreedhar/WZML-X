FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install qBittorrent-nox + dependencies
RUN apt update && \
    apt install -y software-properties-common python3 python3-pip curl git && \
    add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y && \
    apt update && \
    apt install -y qbittorrent-nox && \
    apt clean

WORKDIR /app

COPY . .

# Install Python packages
RUN pip3 install --upgrade setuptools wheel
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose optional qBittorrent port
EXPOSE 8080

CMD qbittorrent-nox -d --profile=/app && bash start.sh
