# Search Deals

This is a project developed in Ruby and Rails to search for deals in any e-commerce, using a configuration that be added on the application, which will contain all the information so that the crawler can search the products in a list on any e-commerce.

The application uses the PostgreSQL database to store the configuration of crawler and the deals found.

This application does not need to install Ruby or PostgreSQL, as this application runs inside Docker.

# System dependencies

Docker and Docker Compose.

# How to run

```
make run
```

Or:

```
docker compose -f docker-compose.yml up
```

# Makefile

There are some commands inside the Makefile to facilitate the development and execution of this project.

Run the DEV MODE (run only PostgreSQL and Redis):

```
make dev
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

View logs for Docker containers:

```
make logs
```
