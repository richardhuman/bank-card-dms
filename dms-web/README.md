# Distribution Management System Webapp

## Overview

This is a Rails webapp that is being used in phase 1 of the prototype.

Once the webapp has been installed and initialised you can access the 2 components as follows: 

* Back office
    * http://localhost:3000/back_office
    * username: maria@company.com
    * password: password

* Agent portal
    * http://localhost:3000/agents
    * username: helen@sales.com
    * password: password
  
## Installation

The following instructions are for a local Mac install. The development stack is composed of:

* rbenv 
* Ruby 3.0.1
* Node 16 / Yarn
* Rails 6.1
* Mysql (Maria DB)
* Redis

### Install Ruby, Maria DB and Redis

````
$ cd dms-web
$ brew install mariadb rbenv redis
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

### Install node and yarn

````
$ brew install node@16 
$ brew link node@16 # this may not be necessary
$ brew install yarn
````

Check versions:

````
$ node -v
v16.3.0
$ yarn -v
1.22.10
````

### Install application library dependencies

````
$ bin/bundle install
$ bin/yarn
````

### Credentials

Note that the database credentials are encrypted in the standard credentials file mechanism. However,
the database.yml config is configured to fall back to trying the credentials "root:password" in order
to access the local db instance. Alternatively you can:
* either pass in the relevant environment variables: `BC_DMS_RAILS_DB_USERNAME`, `BC_DMS_RAILS_DB_PASSWORD`
* or create your own config/development.yml.enc with your own key by using the 
  template in `config/credentials/environment_template.yml`.
  
Note that no production environments have been configured yet.

### Initialisation and start 

DB initialisation - including seed data.

```
$ ./bin/rails db:setup
```

Standard server startup
```
$ ./bin/rails s
```
