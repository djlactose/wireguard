FROM alpine

EXPOSE 51820/UDP

ENV server_address=localhost
ENV dns=8.8.8.8

VOLUME /etc/wireguard/

COPY run.sh /root/bin/
COPY wg0.conf /root/
COPY wg-client.sample /root/

WORKDIR /root/bin

RUN apk add --no-cache wireguard-tools iptables libqrencode

ENTRYPOINT /root/bin/run.sh