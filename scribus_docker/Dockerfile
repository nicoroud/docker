FROM debian:stable-slim

RUN sed -i 's/.*/& contrib/' /etc/apt/sources.list
RUN sed -i 's/stable/testing/g' /etc/apt/sources.list
RUN cat /etc/apt/sources.list

RUN apt-get -qq -y update \
	&& apt-get install -y wget \
	&& apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

RUN apt-get update
RUN apt-get install -y scribus

# Polices
RUN apt-get install -y ttf-bitstream-vera
RUN mkdir /root/fonts && cd /root/fonts
RUN wget http://ftp.fr.debian.org/debian/pool/main/f/fonts-sil-andikanewbasic/fonts-sil-andikanewbasic_5.500-3_all.deb \
	&& wget http://ftp.fr.debian.org/debian/pool/main/f/fonts-ubuntu-title/fonts-ubuntu-title_0.3-2_all.deb
RUN dpkg -i fonts-sil-andikanewbasic_5.500-3_all.deb \
	&& dpkg -i fonts-ubuntu-title_0.3-2_all.deb
RUN rm -f fonts-sil-andikanewbasic_5.500-3_all.deb
RUN apt-get purge -y wget fonts-liberation gsfonts fonts-urw-base35 fonts-texgyre \
	&& apt-get autoremove -y --purge \
	&& apt-get clean -y

# Add user
ARG UNAME=nicolas
ARG UID=1000
ARG GID=993
RUN groupadd -g $GID $UNAME
RUN useradd -m -u $UID -g $GID -s /bin/bash $UNAME
USER $UNAME
WORKDIR /home/$UNAME

CMD /usr/bin/scribus
