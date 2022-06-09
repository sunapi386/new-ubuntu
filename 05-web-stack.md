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

On macOS 
```brew install https://raw.githubusercontent.com/EricChiang/pup/master/pup.rb```

Then

```go get github.com/ericchiang/pup```


## jq
jq is like sed for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text.

https://stedolan.github.io/jq/
```
sudo apt-get update
sudo apt-get install jq
```

## gron

https://github.com/tomnomnom/gron

gron transforms JSON into discrete assignments to make it easier to grep for what you want and see the absolute 'path' to it. It eases the exploration of APIs that return large blobs of JSON but have terrible documentation.

```gron "https://api.github.com/repos/tomnomnom/gron/commits?per_page=1" | fgrep "commit.author"
json[0].commit.author = {};
json[0].commit.author.date = "2016-07-02T10:51:21Z";
json[0].commit.author.email = "mail@tomnomnom.com";
json[0].commit.author.name = "Tom Hudson";
gron can work backwards too, enabling you to turn your filtered data back into JSON:
```
```gron "https://api.github.com/repos/tomnomnom/gron/commits?per_page=1" | fgrep "commit.author" | gron --ungron
[
  {
    "commit": {
      "author": {
        "date": "2016-07-02T10:51:21Z",
        "email": "mail@tomnomnom.com",
        "name": "Tom Hudson"
      }
    }
  }
]
```
```
https://github.com/tomnomnom/gron/releases/download/v0.6.0/gron-linux-amd64-0.6.0.tgz
tar xzf gron-linux-amd64-0.6.0.tgz
sudo mv gron /usr/local/bin/
```


## nvm

```
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

function nvm
   bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
```

`source ~/.nvm-fish/nvm.fish`

Using the latest node

`nvm install --lts --latest-npm`

## nginx

```
sudo apt install -y nginx 
```
Remember: 
- `sudo service nginx restart`
- `sudo vim /etc/nginx/`
- Copying things over `scp -rpi ~/.ssh/key.pem /file/* user@domain:/var/www/html/rpi`
