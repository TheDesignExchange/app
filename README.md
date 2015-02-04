## Installation ##



## Starting Application ##

To Load the Design Exchnage Project, navigate to rails project

```bash
bundle install

rake db:migrate
rake sunspot:solr:start

rake db:seed

rails server
```

## DEPRACTED ##
### RDFRaptor ###
Macs: run `brew install raptor`

Ubuntu: run `sudo apt-get install libraptor-dev libraptor2-0 libraptor2-dev`

### Java RE ###

Should auto install when running sunspot

### GSL ###

Macs: run `brew install gsl`

Linux: install GSL 1.14 from ftp://ftp.unicamp.br/pub/gnu/gsl/gsl-1.14.tar.gz

Navigate to installed folder and run

```bash
./configure
make clean
make
sudo make install
sudo gem install gsl
```
