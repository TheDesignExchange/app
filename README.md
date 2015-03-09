## Installation ##



## Starting Application ##

To Load the Design Exchnage Project, navigate to rails project

```bash
bundle install

rake db:migrate
rake sunspot:solr:start

rails server
```

### Java RE ###

Should auto install when running sunspot; if not, look for the `openjdk-6-jdk` package in your package manager.
