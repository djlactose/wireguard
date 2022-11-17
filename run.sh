if [ ! -f "/etc/wireguard/server_public.key" ]
then
    mkdir -p /etc/wireguard/
    wg genkey | tee /etc/wireguard/server_private.key | wg pubkey | tee /etc/wireguard/server_public.key
    sed -i "s~<server_public>~$(cat /etc/wireguard/server_public.key)~g" /etc/wireguard/wg-client.sample
    sed -i "s~<server_private>~$(cat /etc/wireguard/server_private.key)~g" /etc/wireguard/wg0.conf
    date=$(date +%Y%m%d%H%M%S%N)
    cp /etc/wireguard/wg-client.sample /etc/wireguard/$date.conf
    wg genkey | tee /etc/wireguard/client_private.key | wg pubkey | tee /etc/wireguard/client_public.key
    sed -i "s~<client_public>~$(cat /etc/wireguard/client_public.key)~g" /etc/wireguard/wg0.conf
    sed -i "s~<client_private>~$(cat /etc/wireguard/client_private.key)~g" /etc/wireguard/$date.conf
    sed -i "s~<server_address>~$server_address~g" /etc/wireguard/$date.conf
    sed -i "s~<dns>~$dns~g" /etc/wireguard/$date.conf
    rm /etc/wireguard/client_private.key
    rm /etc/wireguard/client_public.key
    rm /etc/wireguard/server_public.key
    rm /etc/wireguard/server_private.key
    chmod 600 /etc/wireguard/ -R
    qrencode -t ansiutf8 -r /etc/wireguard/$date.conf
fi
iptables -I FORWARD -i wg0 -o wg0 -j ACCEPT
wg-quick up /etc/wireguard/wg0.conf
sleep infinity