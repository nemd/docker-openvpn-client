#!/bin/bash

cd /etc/openvpn

echo $vpnuser > auth.txt
echo $vpnpass >> auth.txt

/bin/bash