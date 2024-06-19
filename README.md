# Search Deals

This project, developed in Ruby on Rails, enables users to search for deals across various e-commerce platforms. Through a customizable configuration added to the application, it gathers all the necessary information for the crawler to search for products listed on any e-commerce site.

The application leverages a PostgreSQL database to store both the crawler configurations and the deals it discovers.

Additionally, there is no need to install Ruby or PostgreSQL separately, as the entire application operates seamlessly within Docker, ensuring a streamlined and hassle-free setup.

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
