# Git

```
cd ~
mkdir workspace
cd workspace
git clone https://gitlab.com/sunapi386/dotfiles.git
```

# Editors

Sublime
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text
```

Sublime Merge
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install sublime-merge
```


# C++

## [Clion](https://www.jetbrains.com/clion/download/)
### External tools

| program | arguments | working directory |
|---------|----------------------------------------------------|-------------------|
| astyle | --options=astylerc $FilePathRelativeToProjectRoot$ | $ProjectFileDir$ |
|  |  |  |

## CMake
```
sudo apt install cmake
```


## Formatter
```
sudo apt install astyle
astyle --options=astylerc src/main.cpp
```


# Python
```
sudo apt-get install python3-pip
pip3 install --upgrade pip
pip3 install virtualenv
```
