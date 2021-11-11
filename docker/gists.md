### vault

sudo docker run -d -v /volumes/vault/logs:/vault/logs -v /volumes/vault/file:/vault/file -v /volumes/vault/config:/vault/config --cap-add=IPC_LOCK -e 'VAULT_LOCAL_CONFIG={"backend": {"file": {"path": "/vault/file"}}, "default_lease_ttl": "168h", "max_lease_ttl": "720h"}' vault server

### openvpn

sudo docker run -v /volumes/openvpn:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
sudo docker run -v /volumes/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full ovpn-client-labpgx nopass
sudo docker run -v /volumes/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient ovpn-client-labpgx > ovpn-client-labpgx.ovpn
