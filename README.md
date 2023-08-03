# Wireguard
A Wireguard container running on Alpine Linux.
* Needs to run with --cap-add=NET_ADMIN
* Needs to run on a kernel >5.6
## Environmental Vars
* server_address = This is used to set the name of your server it defaults to localhost
* dns = This is used to set what DNS is assigned out to clients
## Ports
* 51280/udp
## Persistent Storage 
* /etc/wireguard
## Sample Run Command
* docker run -dit -e server_address=my.company.com --cap-add NET_ADMIN -p 51820:51820/UDP -v wireguard_data:/etc/wireguard --name wire djlactose/wireguard
<!-- * docker service create --cap-add NET_ADMIN -e "server_address=vpn.mycompany.com" -p 51280:51280/UDP --name Wireguard --mount type=bind,source=/mnt/wireguard_data,destination=/etc/wireguard djlactose/wireguard -->
# How to Use this container
To use this container you just need to start it with the environmental varables set.  It will automatically generate certificate for a new server and client automatically on first run.  It will also write a QR Code out to the log when it is first run to allow easier client setup.
# Create User
Console into the container and run the /root/bin/add.sh to generate a new client.  A QR Code will be displayed to add the connection to your device.