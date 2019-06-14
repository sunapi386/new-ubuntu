# Home sweet home tools
```
sudo apt install -y fish tmux git vim tree nmap ffmpeg 
sudo apt install ddclient
ssh-keygen
cat ~/.ssh/id_rsa.pub
```
```
chsh -s `which fish`  
sudo vim /etc/passwd # change user's line to /usr/bin/fish (make sure valid)
# if GUI
sudo apt install -y vlc psensor
```
Install `git` clone `dotfiles` from repo.
```
ln -sfv ~/workspace/dotfiles/fish ~/.config/fish
```

## Hostname
```
sudo vim /etc/hosts /etc/hostname
```

# Map Caps Lock to Control Key
```
sudo apt install -y gnome-tweak-tool
```
Tweak Tool -> Typing -> Caps Lock key behavior -> Additional Ctrl key

# Terminals
```
sudo apt install -y terminator
```
Change color to black text on white background.

# Chrome
```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable
```

# Slack
https://slack.com/downloads/instructions/ubuntu

# Resource Monitor
```
sudo apt install -y indicator-multiload
```

# RealVNCVNC Connect (server)

```
wget -q -O https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.2.1-Linux-x64-ANY.tar.gz
sudo dpkg -i VNC-Server-6.2.1-Linux-x64-ANY.tar.gz
systemctl enable vncserver-x11-serviced.service
systemctl start vncserver-x11-serviced.service
```

# ddclient
```
# as root
cat << EOF >> /etc/ddclient.conf
daemon=5m
use=web, web=dynamicdns.park-your-domain.com/getip
ssl=yes

protocol=namecheap
server=dynamicdns.park-your-domain.com
login=sunapi386.ca
# Set Dynamic DNS Password
password=''
# Set desired subdomain
subdomain
EOF
