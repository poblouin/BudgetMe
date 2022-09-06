RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
DC_PREFIX := docker compose exec api

# Setup
bundle-install:
	$(DC_PREFIX) bundle

# DB
db-create:
	$(DC_PREFIX) bundle exec rake db:create

db-migrate-dev:
	$(DC_PREFIX) bundle exec rake db:migrate

db-migrate-test:
	$(DC_PREFIX) bundle exec rake db:migrate RAILS_ENV=test

db-seed:
	$(DC_PREFIX) bundle exec rake db:seed

db-rollback-dev:
	$(DC_PREFIX) bundle exec rake db:rollback

db-rollback-test:
	$(DC_PREFIX) bundle exec rake db:rollback RAILS_ENV=test

# Dev
lint:
	$(DC_PREFIX) bundle exec rubocop -A

# Rails generate
add-migration:
	$(DC_PREFIX) bundle exec rails g migration $(RUN_ARGS)

add-model:
	$(DC_PREFIX) bundle exec rails g model $(RUN_ARGS)

# Runners
run-console:
	$(DC_PREFIX) bundle exec rails console

run-generate:
	$(DC_PREFIX) bundle exec rails generate $(RUN_ARGS)

run-all-test:
	$(DC_PREFIX) bundle exec rspec

run-test-file:
	$(DC_PREFIX) bundle exec rspec -P $(RUN_ARGS)

c: run-console
g: run-generate
t: run-all-test
tf: run-test-file