# README

## Installation

The following instructions are for a local Mac install. The development stack is composed of:

* rbenv 
* Ruby 3.0.1
* Node 16 / Yarn
* Rails 6.1
* Mysql (Maria DB)

### Install mysql and Ruby

````
$ cd dms-web
$ brew install mariadb rbenv
$ rbenv install # follow instructions to load rbenv into your shell environment
$ rbenv install 3.0.1
$ gem install bundler
$ gem install mysql2 -v 0.5.3 -- --with-mysql-lib=/usr/local/lib --with-mysql-include=/usr/local/include 
````

Check version:

````
$ ruby -v
ruby 3.0.1p64
````

Set the mysql root password.

### Install node and yarn

````
$ brew install node@16 
$ brew link node@16 # this may not be necessary
$ brew install yarn
````

Check version:

````
$ node -v
v16.3.0
➜  dms-web git:(main) ✗ yarn -v
1.22.10
````

$ bin/bundle install

