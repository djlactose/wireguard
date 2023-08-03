date=$(date +%Y%m%d%H%M%S%N)
cp /etc/wireguard/wg-client.sample /etc/wireguard/$date.conf
wg genkey | tee /etc/wireguard/client_private.key | wg pubkey | tee /etc/wireguard/client_public.key
PublicKey=$(cat /etc/wireguard/client_public.key)
PrivateKey=$(cat /etc/wireguard/client_private.key)
NextIP=$(tail -2 /etc/wireguard/wg0.conf |grep AllowedIPs|cut -d "." -f 4|cut -d "/" -f 1)
NextIP=$(($NextIP + 1))
echo -e "\n\n[Peer]\nPublicKey = $PublicKey\nAllowedIPs = 10.10.10.$NextIP/32" >> /etc/wireguard/wg0.conf
sed -i "s~<client_private>~$(cat /etc/wireguard/client_private.key)~g" /etc/wireguard/$date.conf
sed -i "s~<server_address>~$server_address~g" /etc/wireguard/$date.conf
sed -i "s~<dns>~$dns~g" /etc/wireguard/$date.conf
rm /etc/wireguard/client_private.key
rm /etc/wireguard/client_public.key
qrencode -t ansiutf8 -r /etc/wireguard/$date.conf
wg set wg0 peer "$PublicKey" allowed-ips 10.10.10.$NextIP/32
ip -4 route add 10.10.10.$NextIP/32 dev wg0
#iptables -I FORWARD -i wg0 -o wg0 -j ACCEPT
#wg-quick up /etc/wireguard/wg0.conf
#sleep infinity