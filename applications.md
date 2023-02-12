# applications


# Chrome
```bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable
```

# Slack
https://slack.com/downloads

# Amazon Chime
```
sudo apt-get install amazonchime
```

# RealVNCVNC Connect (server)

```bash
wget https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-7.0.0-Linux-x64.deb
sudo dpkg -i VNC-Server-7.0.0-Linux-x64.deb
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced.service
```

# Installing LaTeX
# Installing Lyx

https://wiki.lyx.org/LyX/LyXOnUbuntu#toc3

Installing
If you already have a repository version of LyX installed, you will have to remove it:
```
sudo apt-get remove lyx # (remove your repository version)
sudo apt-get autoremove # (remove repository dependencies)
```
If you don't do this, the fourth step that follows may fail.

Do the following:
```
sudo add-apt-repository ppa:lyx-devel/release # (add the PPA for the 'release', i.e. stable, compilation)
sudo apt-get update # (update so that apt is aware of the new PPA)
sudo apt-get install lyx # (install from the PPA)
lyx # (run LyX)
```

