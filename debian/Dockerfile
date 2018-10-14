# On part d'une distribution debian
FROM debian:wheezy

MAINTAINER Nicolas Roudninski <nicoroud@gmail.com>

# Configure timezone and locale
#~ RUN export DEBIAN_FRONTEND=noninteractive
#~ ENV LANG fr_FR.UTF-8
#~ ENV LANGUAGE fr_FR:en
#~ ENV LC_ALL fr_FR.UTF-8
#~ RUN apt-get update \
    #~ && apt-get install -y --no-install-recommends tzdata locales task-french \
    #~ && ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    #~ && dpkg-reconfigure --frontend noninteractive tzdata \
    #~ && locale-gen fr_FR.UTF-8
#~ RUN export DEBIAN_FRONTEND=noninteractive
#~ ENV LANG fr_FR.UTF-8
#~ ENV LANGUAGE fr_FR:en
#~ ENV LC_ALL fr_FR.UTF-8
#~ RUN apt-get update \
    #~ && apt-get install -y --no-install-recommends tzdata locales task-french \
    #~ && ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    #~ && dpkg-reconfigure --frontend noninteractive tzdata \
    #~ && locale-gen fr_FR.UTF-8

# Mise à jour et installation des dépendances
#~ RUN apt-get update && apt-get install -y apt-utils && apt-get upgrade -y

# installation de wget et gnupg2 (pour apt-key)
RUN apt-get install -y --no-install-recommends wget gnupg2

COPY se3scripts/install_phase2.sh /tmp/
RUN bash /tmp/install_phase2.sh




