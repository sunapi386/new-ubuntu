# To clean up apt sources 
E.g. when you see a lot of warnings like this during `sudo apt update`
```
W: Target Packages (main/binary-amd64/Packages) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target Packages (main/binary-all/Packages) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target Translations (main/i18n/Translation-en_US) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target Translations (main/i18n/Translation-en) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target Translations (main/i18n/Translation-en_CA) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target DEP-11 (main/dep11/Components-amd64.yml) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target DEP-11 (main/dep11/Components-all.yml) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target DEP-11-icons-small (main/dep11/icons-48x48.tar) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target DEP-11-icons (main/dep11/icons-64x64.tar) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target CNF (main/cnf/Commands-amd64) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
W: Target CNF (main/cnf/Commands-all) is configured multiple times in /etc/apt/sources.list.d/signal-xenial.list:1 and /etc/apt/sources.list.d/signal-xenial.list:2
```

Look at https://github.com/davidfoerster/aptsources-cleanup

# VPN

https://launchpad.net/~dwmw2/+archive/ubuntu/openconnect

```
sudo add-apt-repository ppa:dwmw2/openconnect # optional but gets a more updated ver.
sudo apt-get update
sudo apt-get install network-manager-openconnect
```

