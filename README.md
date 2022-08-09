# Search Deals

This is a project developed in [Ruby]() and [Rails]() to search for deals in any e-commerce, using a configuration that be added on the application, which will contain all the information so that the crawler can search the products in a list on any e-commerce.

The application uses the [PostgreSQL](https://www.postgresql.org/) database to store the configuration of crawler and the deals found.

This application does not need to install Ruby or PostgreSQL, as this application runs inside [Docker](https://www.docker.com/).

# System dependencies

Docker and Docker Compose.

# How to run

The first time you must run the following command:

```
make build
```

Then and the next times, just run the following command:

```
make run
```

# Makefile

There are some commands inside the Makefile to facilitate the development and execution of this project.

Build the application:

```
make build
```

Run the application:

```
make run
```

Start the Docker Compose:

```
make start
```

Stop the Docker Compose:

```
make stop
```

Access the bash inside Docker container:

```
make bash
```

View logs for Docker containers:

```
make logs
```

Access the Rails console:

```
make console
```

Run the Rails migrations:

```
make migrate
```

Reset the entire database and run the Rails migrations again:

```
make reset-database
```
