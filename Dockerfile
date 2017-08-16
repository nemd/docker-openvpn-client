FROM debian:stretch

MAINTAINER nemd <michal@reaper.pl>

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends iptables openvpn procps unzip \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    echo '#!/usr/bin/env bash' >/sbin/resolvconf && \
    echo 'conf=/etc/resolv.conf' >>/sbin/resolvconf && \
    echo '[[ -e $conf.orig ]] || cp -p $conf $conf.orig' >>/sbin/resolvconf && \
    echo 'if [[ "${1:-""}" == "-a" ]]; then' >>/sbin/resolvconf && \
    echo '    cat >${conf}' >>/sbin/resolvconf && \
    echo 'elif [[ "${1:-""}" == "-d" ]]; then' >>/sbin/resolvconf && \
    echo '    cat $conf.orig >$conf' >>/sbin/resolvconf && \
    echo 'fi' >>/sbin/resolvconf && \
    chmod +x /sbin/resolvconf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    addgroup --system vpn

WORKDIR /etc/openvpn
ADD https://torguard.net/downloads/OpenVPN-TCP.zip /etc/openvpn
RUN unzip /etc/openvpn/OpenVPN-TCP.zip
RUN	mv OpenVPN-TCP/* .
RUN	ls *.ovpn | sed -e 'p;s/.ovpn$/.conf/' | xargs -n2 mv
# RUN	rm -rf OpenVPN-TCP OpenVPN-TCP.zip
