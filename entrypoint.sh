#!/bin/bash

cd /etc/openvpn

echo $vpnuser > auth.txt
echo $vpnpass >> auth.txt

torserver=TorGuard.$vpnserver.conf

openvpn $torserver
