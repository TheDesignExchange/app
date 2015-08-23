# This Makefile allows the app to be started and stopped easily.
#
# You need to follow these steps in README.md before starting the app for the first time.
#
# Usage:
#   make [rails-]fg       # start rails in the foreground normally
#   make halt             # shut down rails and its dependencies
#   make [up]             # start rails (in the background)
#   make [rails-]restart  # restart rails (in the background)
#   make [rails-]attach   # start rails in the foreground in a screen(1) session

# Settings:
# PROJ_ROOT := $(shell git rev-parse --show-toplevel)
PROJ_ROOT := .
PG_DATADIR := $(PROJ_ROOT)/db/development.pg
PG_GITIGNORE := '/db/*.pg'
PG_LOGFILE := $(PROJ_ROOT)/db/development.pg/postgres.log
PG_PIDFILE := $(PROJ_ROOT)/db/development.pg/postmaster.pid
PG_PORT := 5432
SOLR_PIDFILE := $(PROJ_ROOT)/solr/pids/development/sunspot-solr-development.pid
SOLR_PORT := 8982
RAILS_PIDFILE := $(PROJ_ROOT)/tmp/pids/server.pid
RAILS_PORT := 3000
SCREEN_NAME = dx-rails

# usage: start_check pidfile port name
define start_check_function
start_check() { \
	test -e "$$1" && cat "$$1" | head -1 | xargs kill -0 2>/dev/null && return 0; \
	nc -z localhost $$2 >/dev/null || return 0; \
	echo "ERROR: Something is using port $$2 -- is it another $$3? Please stop it first."; \
	return 1; \
}
endef

up:
	@$(MAKE) rails


# pg

pg: pg-init
	@$(start_check_function); start_check $(PG_PIDFILE) $(PG_PORT) postgres
	@nc -z localhost $(PG_PORT) >/dev/null || $(MAKE) pg-force-start

pg-force-start:
	@echo; echo 'POSTGRES starting'
	pg_ctl -D $(PG_DATADIR) -l $(PG_LOGFILE) start
	@while ! nc -z localhost $(PG_PORT) >/dev/null; do sleep 0.1; done  # ensure the server has started

nopg: norails
	@nc -z localhost $(PG_PORT) >/dev/null && $(MAKE) pg-force-stop || true

pg-force-stop:
	@echo; echo 'POSTGRES stopping'
	pg_ctl -D $(PG_DATADIR) -l $(PG_LOGFILE) stop

pg-init:
	@test -e $(PG_DATADIR) || $(MAKE) pg-force-init || true

pg-force-init:
	@echo; echo 'POSTGRES initing'
	grep -Fq $(PG_GITIGNORE) .git/info/exclude || echo $(PG_GITIGNORE) >> .git/info/exclude
	pg_ctl init -D $(PG_DATADIR)

pg-seed: pg solr
	@true | psql thedesignexchange_development 2>&1 | grep -q 'database "thedesignexchange_development" does not exist' && $(MAKE) pg-force-seed || true

pg-force-seed:
	@echo; echo 'POSTGRES seeding'
	bundle exec rake db:reset
	@# bundle exec rake db:seed


# solr

solr:
	@$(start_check_function); start_check $(SOLR_PIDFILE) $(SOLR_PORT) solr
	@nc -z localhost $(SOLR_PORT) >/dev/null || $(MAKE) solr-force-start
	@while ! nc -z localhost $(SOLR_PORT) >/dev/null; do sleep 0.1; done  # ensure the server has started

nosolr: norails
	@nc -z localhost $(SOLR_PORT) >/dev/null && $(MAKE) solr-force-stop || true

solr-force-start:
	@echo; echo 'SOLR starting'
	bundle exec rake sunspot:solr:start

solr-force-stop:
	@echo; echo 'SOLR stopping'
	bundle exec rake sunspot:solr:stop


# rails

rails-starting: pg-seed solr
	@$(start_check_function); start_check $(RAILS_PIDFILE) $(RAILS_PORT) rails
	@screen -S $(SCREEN_NAME) -X select . >/dev/null || $(MAKE) rails-force-start

rails-force-start:
	@echo; echo 'RAILS starting'
	screen -S $(SCREEN_NAME) -d -m -- bundle exec rails server

rails: rails-starting
	@while ! nc -z localhost 3000 >/dev/null && screen -S $(SCREEN_NAME) -X select . >/dev/null; do sleep 0.1; done  # ensure the server has started

rails-stopping:
	@nc -z localhost $(RAILS_PORT) >/dev/null && $(MAKE) rails-force-stop || true

norails: rails-stopping
	@while test -e $(RAILS_PIDFILE); do sleep 0.1; done  # ensure the server has exited
	@while screen -S $(SCREEN_NAME) -X select . >/dev/null; do sleep 0.1; done  # ensure the screen has exited

rails-force-stop:
	@echo; echo 'RAILS stopping'
	@$(start_check_function); start_check $(RAILS_PIDFILE) $(RAILS_PORT) rails
	test -e $(RAILS_PIDFILE) && cat $(RAILS_PIDFILE) | xargs kill -INT

rails-restart:
	@$(MAKE) norails
	@$(MAKE) rails

rails-attach: rails-starting
	screen -R $(SCREEN_NAME)

rails-fg: pg-seed solr norails
	exec bundle exec rails server


# rails aliases

restart:
	@$(MAKE) rails-restart

attach:
	@$(MAKE) rails-attach

fg:
	@$(MAKE) rails-fg

halt: norails nopg nosolr

.PHONY: default pg pg-force-start nopg pg-force-stop pg-init pg-force-init pg-seed pg-force-seed solr nosolr solr-force-start solr-force-stop rails-starting rails rails-stopping norails rails-restart rails-attach rails-fg rails-force-start rails-force-stop up restart attach fg halt
