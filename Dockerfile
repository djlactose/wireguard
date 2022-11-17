FROM alpine

EXPOSE 51820/UDP

ENV server_address=localhost
ENV dns=8.8.8.8

VOLUME /etc/wireguard/

COPY run.sh /root/bin/
COPY wg0.conf /etc/wireguard/
COPY wg-client.sample /etc/wireguard

WORKDIR /root/bin

RUN apk add --no-cache wireguard-tools iptables libqrencode

ENTRYPOINT /root/bin/run.sh