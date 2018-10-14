# on part d'une debian de base
FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive
# Ajout des fichiers nécessaires
ADD files/interfaces /etc/network/
ADD files/hosts /etc/
ADD files/hostname /etc/
ADD files/resolv.conf /etc/
ADD files/profile /etc/
ADD files/sources.list /etc/apt/
ADD files/se3.list /etc/apt/sources.list.d/
ADD files/local /etc/apt/apt.conf.d/
ADD se3.preseed /root/
ADD install_phase2.sh /root/
ADD pkg /root/pkg/

ARG ADMINPW=KorTeX50

RUN debconf-set-selections /root/se3.preseed

# Mise à jour des dépots et upgrade si necessaire
RUN apt-get update && apt-get upgrade --quiet --assume-yes

# installation de ssmtp, ntpdate, makepasswd, ssh, etc....
# les scripts se3 ont besoin de ifconfig qui n'est plus installé par défaut dans jessie
RUN apt-get install --quiet --assume-yes ssmtp ntpdate makepasswd ssh vim screen \
lshw atop htop smartmontools nmap tcpdump dos2unix net-tools apt-utils \
&& DEBIAN_PRIORITY="critical" \
&& DEBIAN_FRONTEND="noninteractive" \
&& export  DEBIAN_FRONTEND \
&& export  DEBIAN_PRIORITY

# Prise en compte de setup_se3.data
RUN mkdir /etc/se3
ADD setup_se3.data /etc/se3/
RUN cd /root/ \
&& chmod +x install_phase2.sh \
&& /root/install_phase2.sh

## generation pass en automatique
# Changement mot de passe root sql
#~ RUN MYSQLPW=$(makepasswd | LC_ALL=C sed -r 's/[^a-zA-Z0-9]//g') \
#~ && sed "s/MYSQLPW=\"AUTO\"/MYSQLPW=\"$MYSQLPW\"/" -i /etc/se3/setup_se3.data \
# Changement mot de passe admin ldap
#~ && ADMINPW=$(makepasswd | LC_ALL=C sed -r 's/[^a-zA-Z0-9]//g') \
#~ && sed "s/ADMINPW=\"AUTO\"/ADMINPW=\"$ADMINPW\"/" -i /etc/se3/setup_se3.data \
# Changement mot de passe adminse3
#~ && ADMINSE3PW=$(makepasswd | LC_ALL=C sed -r 's/[^a-zA-Z0-9]//g') \
#~ && sed "s/ADMINSE3PW=\"AUTO\"/ADMINSE3PW=\"$ADMINSE3PW\"/" -i /etc/se3/setup_se3.data 

# Mise à l'heure automatique du serveur sur internet...
#### MARCHE PÔ !!! #####
# RUN ntpdate -b fr.pool.ntp.org

# 1. Ajout du support de l'architecture i386 pour dpkg
# 2. Installation de Wine:i386
# 3. Installation du backport samba 4.4
# 4. On stopppe le service winbind
#~ RUN ifconfig
#~ RUN dpkg --add-architecture i386 && apt-get -qq update \
#~ && apt-get install wine-bin:i386 -y \
#~ && apt-get install samba smbclient winbind --allow-unauthenticated -y \
#~ && service winbind stop \
#~ && insserv -r winbind

# Pour éviter que mysql ne demande le mot de passe root
#~ RUN echo "mysql-server mysql-server/root_password password PdTza455" | debconf-set-selections \
#~ && echo "mysql-server mysql-server/root_password_again password PdTza455" | debconf-set-selections

# Pour éviter le "invoke-rc.d: policy-rc.d denied execution of start."
#~ RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

## 	*** ATTENTION  ***
# À chaque "RUN" le serveur mysql est stoppé !
# (Chaque RUN est un nouveau conteneur, donc même si le service est lancé,
# il ne sera pas en fonction dans le nouveau RUN)
# Donc, soit on le lance au début de chaque RUN, soit on enchaine les commandes
# avec des "&&"

# Installation du paquet se3 et de ses dependances
# On installe libapache2-mod-php5 avant se3 sinon libapache2-mod-php5 demande confirmation
# On lance le service mysql au cas où...
#~ RUN apt-get --yes --force-yes install libapache2-mod-php5 mysql-server mysql-client \
#~ && service mysql start \
#~ && apt-get --yes --force-yes install se3
# && mysqladmin -h localhost -u root -pPdTza455 create se3db \


#~ # se3-domain se3-logonpy
#~ RUN dpkg -i /root/pkg/se3-logonpy_3.0.6_all.deb

#~ # Suppression du paquet nscd
#~ RUN apt-get --yes remove nscd

#~ # maj departementale 
#~ RUN cd /var/cache/se3_install/depmaj && ./installdepmaj.sh && cd /

#~ RUN . /etc/profile

#~ RUN DEBIAN_PRIORITY="high"
#~ RUN DEBIAN_FRONTEND="dialog" 
#~ RUN export  DEBIAN_PRIORITY
#~ RUN export  DEBIAN_FRONTEND
