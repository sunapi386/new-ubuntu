# Web stack

## nvm

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

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
