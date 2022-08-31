# BudgetMe

WIP

Budget me is a Mint-like budgeting software to define monthly / yearly budget and track your expenses.

MVP will contain:
- No support for user, single user only
- No login, the goal of this project is to be self-hosted / not public
- It will be able to parse a Tangerine expenses CSV file and import it in the database
- Create monthly and yearly budget
- Create transaction category
- Create transaction

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

```shell
docker compose exec api rspec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
