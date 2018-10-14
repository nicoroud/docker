# On part d'une distribution debian
FROM debian:latest

MAINTAINER Nicolas Roudninski <nroudninski@protonmail.com>

# On vire les paquets non critiques
RUN apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends aptitude && \
apt-get purge -y $(aptitude search '~i!~M!~prequired!~pimportant!~R~prequired!~R~R~prequired!~R~pimportant!~R~R~pimportant!busybox!grub!initramfs-tools' | awk '{print $2}') && \
apt-get purge -y aptitude && \
apt-get autoremove -y --purge && \
echo "APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;" >/etc/apt/apt.conf

# Déplacement vers un dossier
WORKDIR /tmp/

# On configure la timezone et les locales
RUN export DEBIAN_FRONTEND=noninteractive
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:en
ENV LC_ALL fr_FR.UTF-8
RUN apt-get update && \
apt-get install -y --no-install-recommends tzdata locales task-french && \
ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
dpkg-reconfigure --frontend noninteractive tzdata && \
locale-gen fr_FR.UTF-8

# Mise à jour et installation des dépendances
#RUN apt-get update && apt-get install -y apt-utils && apt-get upgrade -y

# installation de wget et gnupg2 (pour apt-key)
RUN apt-get install -y --no-install-recommends wget gnupg2

# installation de inkscape
#RUN apt-get install -y --no-install-recommends inkscape

# installation de xia
RUN echo "deb http://repository.crdp.ac-versailles.fr/debian xia main" | tee /etc/apt/sources.list.d/xia.list && \
wget -q http://repository.crdp.ac-versailles.fr/crdp.gpg -O - | apt-key add - && \
apt-get update && apt-get install -y xia

# On vire les paquets inutiles
RUN echo "localepurge localepurge/nopurge multiselect fr, fr_FR, fr_FR.UTF8" | debconf-set-selections && \
export DEBIAN_FRONTEND=noninteractive && \
apt-get install -y --no-install-recommends localepurge && \
dpkg-reconfigure localepurge && \
localepurge && \
apt-get purge -y wget gnupg2 localepurge && \
apt-get autoremove -y --purge && \
apt-get clean -y && \
rm -fr /usr/share/man/*

# On ajoute l'utilisateur local du système hôte
ARG UNAME=nicolas
ARG UID=1000
ARG GID=993
RUN groupadd -g $GID $UNAME
RUN useradd -m -u $UID -g $GID -s /bin/bash $UNAME
USER $UNAME
WORKDIR /home/$UNAME

# Exécution du logiciel
CMD /usr/bin/xia
