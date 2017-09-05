# Install Ruby on Rails Ubuntu (RBENV)

# Additional information https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-16-04
# we will mix into the instructions.

echo -e "\n- - - - - -\n"
echo "Set up an evvironment"

echo -e "\n- - - - - -\n"
echo "update installed packages before adding new ones"
cd
sudo apt-get update -y

echo -e "\n- - - - - -\n"
echo "install tree just convenient tool"
sudo apt-get install tree

echo -e "\n- - - - - -\n"
echo "install Sublime Text 3"
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install -y sublime-text-installer

echo -e "\n- - - - - -\n"
echo "install Git required to clone source repositories and work with ourselves"
sudo apt-get install -y git gitk git-gui

# set up git config 
# git config --global user.name "Your Name"
# git config --global user.email "youremail@domain.com"

echo -e "\n- - - - - -\n"
echo "install C-compiler and libraries required by rbenv to build ruby binaries for your platform"
sudo apt-get install -y gcc build-essential libpq-dev libssl-dev libreadline-dev libsqlite3-dev zlib1g-dev

echo -e "\n- - - - - -\n"
echo "Set up RBENV"

# Now follow the rbenv instructtions on the Github site
# https://github.com/rbenv/rbenv
echo -e "\n- - - - - -\n"
echo "clone the rbenv git repo into ~/.rbenv"
cd
git clone git://github.com/rbenv/rbenv.git .rbenv

echo -e "\n- - - - - -\n"
echo "add ~/.rbenv to your PATH for access to rbenv command-line utility"
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
tail ~/.bashrc

echo -e "\n- - - - - -\n"
echo "add "rbenv init" to your shell to enable shims and autocompletion"
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
tail ~/.bashrc

echo -e "\n- - - - - -\n"
echo "add the contents of the modified .bashrc to your current shell"
source ~/.bashrc
which rbenv
rbenv -v
rbenv help

echo -e "\n- - - - - -\n"
echo "add the install command to rbenv"
git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
tail ~/.bashrc

echo -e "\n- - - - - -\n"
echo "source the new path location into the current shell and verify we now have an 'install' command"
source ~/.bashrc
rbenv help | grep install

# Set up Ruby and Rails
# we can not mesh in the instructions from
# https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-16-04

echo -e "\n- - - - - -\n"
echo "install a Ruby version (could be others)"
rbenv install -v 2.3.3
echo -e "\n- - - - - -\n"
echo "set the global version of Ruby to use"
rbenv global 2.3.3
ruby -v

echo -e "\n- - - - - -\n"
echo "set the default to not have gems generate local documentation (and eat space and time)"
echo "gem: --no-document" > ~/.gemrc
gem install bundler

echo -e "\n- - - - - -\n"
echo "this step will take a ~5min to complete (as it warns)"
gem install rails -v 4.2.6
rails -v

echo -e "\n- - - - - -\n"
echo "install shims for newly installed Ruby gems that provide commands"
rbenv rehash

echo -e "\n- - - - - -\n"
echo "install rails-api"
gem install rails-api -v 0.4.0 --no-ri --no-doc
rails-api -v
gem uninstall railties -v 5.0.1

echo -e "\n- - - - - -\n"
echo "install shims for newly installed Ruby gems that provide commands"
rbenv rehash

echo -e "\n- - - - - -\n"
echo "install bundler"
gem install bundler --no-ri --no-doc

# Install additional components

echo -e "\n- - - - - -\n"
echo "install Node.js -- we have to jump over to some github instructions"
sudo apt-get install -y software-properties-common python-software-properties
sudo apt-get install -y nodejs
sudo apt-get install -y libfontconfig1-dev

echo -e "\n- - - - - -\n"
echo "install phantomJS"
sudo apt-get install -y bzip2
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
cd /tmp
curl -L https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 | tar xvjf -
sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
phantomjs --version

echo -e "\n- - - - - -\n"
echo "install postgresql"
sudo apt-get install -y postgresql
sudo service postgresql start
sudo service --status-all

echo -e "\n- - - - - -\n"
echo "install mongodb"
sudo apt-get install -y mongodb
sudo service mongodb start
sudo service --status-all

echo -e "\n- - - - - -\n"
echo "install imagemagick"
sudo apt-get install -y imagemagick
sudo imagemagick --version


# inspect installation
tree ~/ -L 1
tree ~/.rbenv -L 1


#echo -e "\n- - - - - -\n"
#echo "Create and run new Rails app"
#cd /tmp
#rails new test_install
#cd test_install
#rails server

# CHECK

git clone https://github.com/jhu-ep-coursera/capstone_demoapp.git module1
cd module1
git checkout module2.start
git checkout -b module1
bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rake 
