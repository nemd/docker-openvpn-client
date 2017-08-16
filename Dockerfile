FROM alpine:3.6

MAINTAINER nemd <michal@reaper.pl>

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories &&\
	apk add --update-cache openvpn@edge

WORKDIR /etc/openvpn
ADD https://torguard.net/downloads/OpenVPN-TCP.zip /etc/openvpn
RUN unzip /etc/openvpn/OpenVPN-TCP.zip
RUN	mv OpenVPN-TCP/* .
RUN	ls *.ovpn | sed -e 'p;s/.ovpn$/.conf/' | xargs -n2 mv
RUN	rm -rf OpenVPN-TCP OpenVPN-TCP.zip

CMD /bin/ash
