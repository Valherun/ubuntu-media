#ubuntu-media

FROM valherun/ubuntu-base:bionic

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
  echo "** Checkout linuxserver.io whom I have shamelessly **" && \
  echo "** used their baseimages/style in my Dockers **" && \
  echo "** Installing GPG package **" && \
  apt-get update && \
  apt-get install -y gpg-agent && \
  echo "** Installing new repos for Media **" && \
  echo "** Installing MKVToolNix **" && \
  wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | apt-key add - && \
  echo "deb https://mkvtoolnix.download/ubuntu/ bionic main" >> /etc/apt/sources.list.d/mkvtoolnix.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    mkvtoolnix && \
  echo "** Installing handbrake **" && \
  add-apt-repository -y ppa:stebbins/handbrake-releases && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    handbrake-cli  && \
  echo "** Installing other required packages **" && \
  add-apt-repository -y ppa:mc3man/bionic-media && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    mplayer \
    ffmpeg \
    flac \
    mp4v2-utils \
    mpv \
    mediainfo && \
  echo "** Cleanup **" && \
  apt-get clean && \
  rm -rf \ 
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*
