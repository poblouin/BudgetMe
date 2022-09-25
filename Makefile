RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
DC_PREFIX := docker compose exec api

# Setup
bundle-install:
	$(DC_PREFIX) bundle

docker-volume-init:
	docker volume create --name=pg_data

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
brakeman:
	$(DC_PREFIX) bundle exec brakeman --no-pager

bundle-audit:
	$(DC_PREFIX) bundle exec bundler-audit --update

lint:
	$(DC_PREFIX) bundle exec rubocop -A

lint-staged:
	$(DC_PREFIX) bundle exec rubocop -A `git diff --name-only --cached | grep '\.rb'`

pre-commit:
	$(DC_PREFIX) lefthook run pre-commit

# Graphql
schema-compare:
	$(DC_PREFIX) rake graphql:schema:idl_new && schema_comparator compare schema.graphql.new schema.graphql

schema-dump:
	$(DC_PREFIX) rake graphql:schema:dump

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