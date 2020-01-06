# Web stack
## pup

pup is a command line tool for processing HTML. It reads from stdin, prints to stdout, and allows the user to filter parts of the page using CSS selectors.

Inspired by jq, pup aims to be a fast and flexible way of exploring HTML from the terminal.


First install go. From https://github.com/golang/go/wiki/Ubuntu
```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install golang-go
```

Then

```go get github.com/ericchiang/pup```


## gron
https://github.com/tomnomnom/gron
```
https://github.com/tomnomnom/gron/releases/download/v0.6.0/gron-linux-amd64-0.6.0.tgz
tar xzf gron-linux-amd64-0.6.0.tgz
sudo mv gron /usr/local/bin/
```

## nvm

```
wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

function nvm
   bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
```

source ~/.nvm-fish/nvm.fish

## nginx

```
sudo apt install -y nginx 
```
Remember: 
- `sudo service nginx restart`
- `sudo vim /etc/nginx/`
- Copying things over `scp -rpi ~/.ssh/key.pem /file/* user@domain:/var/www/html/rpi`
