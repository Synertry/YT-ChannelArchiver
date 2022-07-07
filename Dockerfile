FROM ubuntu:latest

# Create app directory
WORKDIR /root

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y \
  curl \
  gcc \
  libc-dev \
  python3 \
  python-is-python3 \
  python3-pip \
  tar \
  wget \
  && apt-get auto-remove -y \
  && rm -rf /var/lib/apt/lists/*

# alpine
# RUN apk update \
#   && apk upgrade --available \
#   && sync \
#   && apk add --no-cache \
#   bash \
#   curl \
#   gcc \
#   libc-dev \
#   pcre \
#   pcre-dev \
#   python3 \
#   py3-pip \
#   tar \
#   wget \
#   && ln -sf python3 /usr/bin/python

ENV PYTHONUNBUFFERED=1

# alpine
## RUN python3 -m ensurepip
# RUN pip3 install --no-cache --upgrade pip setuptools wheel
RUN python3 -m pip install --no-cache --upgrade setuptools wheel

RUN curl -fsSL https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/deploy/ytca-setup.sh | bash

ENTRYPOINT [ "/root/ytca.sh" ]