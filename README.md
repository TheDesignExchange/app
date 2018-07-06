TheDesignExchange/app
=====================

[TheDesignExchange:master][] build status:
![build status][]

 [TheDesignExchange:master]: https://github.com/TheDesignExchange/thedesignexchange/tree/master
 [build status]: https://travis-ci.org/TheDesignExchange/thedesignexchange.svg
 
 [See our wiki]https://github.com/TheDesignExchange/app/wiki to learn about our workflow

### Installing

A few manual steps are required:

1. Install **postgres**.
   Mac: `brew install postgresql`
   Ubuntu: `sudo apt-get install postgresql`

2. [Install **rvm**], then follow instructions to install correct **Ruby** version.
   As of Aug 2015, this would be: `rvm install ruby-2.1.3`
   (If you have a nonstandard security setup, install rvm without autolibs.)

3. **Bundler**. `gem install bundler`, then `bundle install`
   Ubuntu: You might have to `sudo apt-get install openjdk-6-jdk` for Sunspot.

4. That's it! Read the next section to see how to start up the server.
5. After starting your server, run `bundle exec rake db:seed` to seed your database with starter data.

 [install **rvm**]: https://rvm.io/rvm/install

### Usage

The `Makefile` helps simplify starting and stopping the dev server.

```
make [rails-]fg       # start rails in the foreground normally
make halt             # shut down rails and its dependencies
```

Rails can also be run in the background using `screen(1)` as follows:
```
make [up]             # start rails (in the background) and its dependencies
make [rails-]restart  # restart rails (in the background)
make [rails-]attach   # start rails in the foreground in a screen(1) session
```

### Debugging

#### Ruby

We use [pry](https://github.com/pry/pry) and
[pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) for debugging ruby
code. See their respective github repositories for further documentation. In
short, you need to have a visible rails server (run `make attach` in a console)
and add a line that reads `binding.pry` in the file you want to debug, at the
line where you want the debugger to begin.
