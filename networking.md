# networking



# ddclient (optional)
If you want to setup this machine as a server.
```bash
sudo apt install ddclient
sudo su
# as root
cat << EOF >> /etc/ddclient.conf
daemon=5m
use=web, web=dynamicdns.park-your-domain.com/getip
ssl=yes

protocol=namecheap
server=dynamicdns.park-your-domain.com
# Set Domain Name, e.g. sunpi.co
login=sunpi.co
# Set Dynamic DNS Password, blank here ''
password=''
# Set desired subdomain, e.g. subdomain.sunpi.co
subdomain
EOF
```

Checking if the config works
`sudo /usr/sbin/ddclient -daemon=0 -debug -verbose -noquiet`
You should see
`SUCCESS:  updating subdomain: good: IP address set to 1.2.3.4`


# Nethogs
```bash
cd  ~/workspace
git clone https://github.com/raboof/nethogs
cd nethogs
make
sudo make install
sudo nethogs
```


# Wireguard VPN

```bash
wget https://git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh
```

# OpenConnect VPN

https://launchpad.net/~dwmw2/+archive/ubuntu/openconnect

```
sudo add-apt-repository ppa:dwmw2/openconnect # optional but gets a more updated ver.
sudo apt-get update
sudo apt-get install network-manager-openconnect
```

and to use
```
sudo openconnect vpn.example.com --user <username>
```
