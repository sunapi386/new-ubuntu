# Home sweet home tools
```
sudo apt install -y tmux git vim tree nmap ffmpeg 
ssh-keygen
cat ~/.ssh/id_rsa.pub
```
Fish shell
```
# sudo apt-add-repository ppa:fish-shell/release-2 # default one is old 
# sudo apt-add-repository --remove ppa:fish-shell/release-2
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
chsh -s `which fish`  
sudo vim /etc/passwd # change user's line to /usr/bin/fish (make sure valid)
```

# Remove password prompt for `sudo`
Warning, if you do this, don't leave your machine logged in when you're AFK!

1. Run command: `sudo visudo`
2. Go down to the bottom of the file, add the following line: `<user> ALL=(ALL) NOPASSWD: ALL` Note: replace <user> with your username
3. Save and exit the file. You're done!
  
To test, run command:  
1. Run command: `sudo -k` This will clear the exiting password cache
2. `sudo ls` You should not be prompted for a password


# For code editing
```
mkdir -p workspace
cd ~/workspace
git clone https://gitlab.com/sunapi386/dotfiles.git 
bash setup.sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

# For GUI machine
```
sudo apt install -y vlc psensor indicator-multiload
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



# RealVNCVNC Connect (server)

```
wget -q -O https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.2.1-Linux-x64-ANY.tar.gz
sudo dpkg -i VNC-Server-6.2.1-Linux-x64-ANY.tar.gz
systemctl enable vncserver-x11-serviced.service
systemctl start vncserver-x11-serviced.service
```

# ddclient (optional)
If you want to setup this machine as a server.
```
sudo apt install ddclient
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
