# Install Ruby on Rails Ubuntu
How to install the Ruby on Rails development environment for your Ubuntu

## Install
To install the Ruby on Rails development environment you just need to copy the line below for your Ubuntu, paste it in the Terminal and press Enter. 

```
sudo apt-get install curl
source <(curl -sL https://raw.githubusercontent.com/ildarcheg/ruby-on-rails/master/install-ubuntu/ruby-on-rails-install-ubuntu.sh)
```

## Check
Open Firefox and run. 

```
http://localhost:3000
```

## Sublime and SSH

Install the rsub plugin for ST, which is available through Package Control too.
Add a remote forwarding line under the right host in your ~/.ssh/config file to enable connection:
```
Host myserver
  Hostname 123.45.67.89
  RemoteForward 52698 127.0.0.1:52698
```
SSH in to your remote: 
```
ssh username@myserver
```
Download rmate in rsub folder: 
```
curl https://raw.githubusercontent.com/aurora/rmate/master/rmate > rsub
```
Move it in place: 
```
sudo mv rsub /usr/local/bin 
```
Make it executable: 
```
sudo chmod +x /usr/local/bin/rsub
```
Try: 
```
rsub .profile 
```

Run ssh:
```
ssh -R 52698:localhost:52698 remoteHost
```
