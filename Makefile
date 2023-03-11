RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
DC_API_PREFIX := docker compose exec api
DC_UI_PREFIX := docker compose exec ui

# Setup
bundle-install:
	$(DC_API_PREFIX) bundle

docker-volume-init:
	docker volume create --name=pg_data

npm-install:
	$(DC_UI_PREFIX) npm ci

# DB
db-create:
	$(DC_API_PREFIX) bundle exec rake db:create

db-migrate-dev:
	$(DC_API_PREFIX) bundle exec rake db:migrate

db-migrate-test:
	$(DC_API_PREFIX) bundle exec rake db:migrate RAILS_ENV=test

db-seed:
	$(DC_API_PREFIX) bundle exec rake db:seed

db-rollback-dev:
	$(DC_API_PREFIX) bundle exec rake db:rollback

db-rollback-test:
	$(DC_API_PREFIX) bundle exec rake db:rollback RAILS_ENV=test

# Dev backend
brakeman:
	$(DC_API_PREFIX) bundle exec brakeman --no-pager

bundle-audit:
	$(DC_API_PREFIX) bundle exec bundler-audit --update

lint:
	$(DC_API_PREFIX) bundle exec rubocop -A

lint-staged:
	$(DC_API_PREFIX) bundle exec rubocop -A `git diff --name-only --cached | grep '\.rb'`

pre-commit:
	$(DC_API_PREFIX) lefthook run pre-commit

# Graphql
schema-compare:
	$(DC_API_PREFIX) rake graphql:schema:idl_new && schema_comparator compare schema.graphql.new schema.graphql

schema-dump:
	$(DC_API_PREFIX) rake graphql:schema:dump

# Rails generate
add-migration:
	$(DC_API_PREFIX) bundle exec rails g migration $(RUN_ARGS)

add-model:
	$(DC_API_PREFIX) bundle exec rails g model $(RUN_ARGS)

# Runners backend
run-be:
	$(DC_API_PREFIX) bundle exec $(RUN_ARGS)

run-console:
	$(DC_API_PREFIX) bundle exec rails console

run-generate:
	$(DC_API_PREFIX) bundle exec rails generate $(RUN_ARGS)

run-all-test:
	$(DC_API_PREFIX) bundle exec rspec

run-test-file:
	$(DC_API_PREFIX) bundle exec rspec -P $(RUN_ARGS)

be: run-be
c: run-console
g: run-generate
t: run-all-test
tf: run-test-file