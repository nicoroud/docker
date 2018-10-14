FROM ubuntu:16.04

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8
RUN apt-get update && \
    apt install -y \
    wget \
      libpaper1 \
      libavformat-ffmpeg56 \
      libavcodec-ffmpeg56 \
      libswresample-ffmpeg1 \
      libswscale-ffmpeg3 \
      libavutil-ffmpeg54 \
      libx11-6 \
      libqt5webkit5 \
      libqt5svg5 \
      libqt5multimediawidgets5 \
      libqt5multimedia5 \
      libqt5xml5 \
      libqt5script5 \
      onboard \
      libqt5multimedia5-plugins

RUN wget https://github.com/OpenBoard-org/OpenBoard/releases/download/v1.4.1/openboard_ubuntu_16.04_1.4.1_amd64.deb && \
    dpkg -i openboard_ubuntu_16.04_1.4.1_amd64.deb && \
    rm openboard_ubuntu_16.04_1.4.1_amd64.deb

# Remove non-used packages
RUN echo "localepurge localepurge/nopurge multiselect fr, fr_FR, fr_FR.UTF8" | debconf-set-selections \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends localepurge \
    && dpkg-reconfigure localepurge
RUN localepurge \
    && apt-get purge -y wget gnupg2 localepurge \
    && apt-get autoremove -y --purge \
    && apt-get clean -y \
    && rm -fr /usr/share/man/*

# Add user
ARG UNAME=nicolas
ARG UID=1000
ARG GID=993
RUN groupadd -g $GID $UNAME
RUN useradd -m -u $UID -g $GID -s /bin/bash $UNAME
USER $UNAME
WORKDIR /home/$UNAME

CMD /usr/bin/openboard
