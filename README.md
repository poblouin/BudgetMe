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

## Development

### Graphiql

This project uses graphiql. The UI is accessible at http://0.0.0.0:3000/graphiql.

### Commands

See the `Makefile` for a list of helpful commands for development.

* Database creation

```shell
# Create the docker volume first
make docker-volume-init
```

* Database initialization

```shell
# Start the containers then run
make db-create
```

* How to run the test suite

```shell
# Run all the tests
make t

# Run tests from a single file
make tf path/to/file
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
