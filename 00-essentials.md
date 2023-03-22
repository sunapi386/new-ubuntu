# Home sweet home tools
```
sudo apt update
sudo apt install -y tmux git vim tree nmap ffmpeg curl landscape-common htop nginx tmux screen wireguard wireguard-tools resolvconf vokoscreen
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
On Raspberry Pi OS, make and install. https://gist.github.com/AFRUITPIE/1d26d3d15dc43f821a36d7ccc1260a7f

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
git clone git@gitlab.com:sunapi386/dotfiles.git
cd dotfiles
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
Tweaks -> Typing -> Caps Lock key behavior -> Additional Ctrl key

This only works in Gnome, not Xmonad. With xmonad, use Xmodmap. Setup available in the config

```
bash ~/workspace/dotfiles/setup.sh
```

# Terminals
```
sudo apt install -y terminator
```
Change color to black text on white background.

## Disable the lid from triggering system sleep
If using a laptop for a server, closing the lid on the laptop normally suspends OS. To prevent this:

`sudo vi /etc/systemd/logind.conf`

Then modify the

```
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore
```

And then `sudo systemctl restart systemd-logind`

# XMonad
```bash
sudo apt-get install xmonad suckless-tools xscreensaver
sudo apt-get install xmobar
~/.xmobarrc
```
