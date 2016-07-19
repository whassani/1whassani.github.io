#!/bin/sh
### BEGIN INIT INFO
# Provides: ROUTEUR
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Example initscript
# Description: This file should be used to construct scripts to be
# placed in /etc/init.d.
### END INIT INFO
# Vider les tables actuelles
iptables -t filter -F
# Vider les règles personnelles
iptables -t filter -X
# Interdire toute connexion entrante et sortante
iptables -t filter -P INPUT DROP
iptables -t filter -P OUTPUT DROP
# Ne pas casser les connexions établies
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
# Autoriser loopback
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT
# Activer NAT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# ICMP (Ping)
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT
##########################################
########## OUVERTURE PORT #############
#####################################
## SSH IN
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
# DNS Out
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
# NTP Out
iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT
# HTTP + HTTPS Out
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
# FTP Out
iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT
