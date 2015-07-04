thedesignexchange
=================

![build status](https://travis-ci.org/TheDesignExchange/thedesignexchange.svg)  
[[TheDesignExchange/thedesignexchange:master](https://github.com/TheDesignExchange/thedesignexchange/tree/master) status]


Installing
----------

**Java RE** should auto install when running sunspot.
If not, look for the `openjdk-6-jdk` package in your package manager.


Usage
-----

 1. `cd` into the repo
 2. ```bash
    bundle install
    rake db:migrate
    rake sunspot:solr:start
    rails server
    ```
