 
FROM debian:jessie

# Installation de nginx
RUN apt update && apt upgrade -y && apt-get install -y openvpn openssl easy-rsa openssh-server wget net-tools
ADD lcs.conf /etc/openvpn/
ADD lcs /etc/openvpn/lcs
