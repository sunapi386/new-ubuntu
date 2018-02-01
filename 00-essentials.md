# Home sweet home tools
``` 
sudo apt install -y fish tmux git vim
chsh -s `which fish`
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
