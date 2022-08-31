# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

```shell
# Create the docker volume first
docker volume create --name=pg_data
```

* Database initialization

```shell
# Start the containers then run
docker compose run api rake db:create
```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
