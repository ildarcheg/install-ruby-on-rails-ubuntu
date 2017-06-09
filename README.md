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
On the local machine install the `rsub` package in Sublime.

Then add host entries in `~/.ssh/config` for each server you'll be using `rsub` on.

```
Host your_remote_server.com
  RemoteForward 52698 127.0.0.1:52698
```

On the server:

```
sudo wget -O /usr/local/bin/rsub https://raw.github.com/aurora/rmate/master/rmate
sudo chmod +x /usr/local/bin/rsub
```

Now you can run `rsub text_file.txt` to edit in Sublime.
