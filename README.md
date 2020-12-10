# Flarum with Docker

## Install
 - Step 1: Make sure you have Docker + Docker compose installed. (Optional) Install Make.
 - Step 2: Copy the file `.env.example` and name it `.env`, put it in the project root directory. Fill it with configuration of your choice.
 - Step 3: Run `docker-compose build` (or `make build`).
 - Step 4: Run `docker-compose up -d` (or `make up`) to start the container.
 - Step 5: Run `docker-compose exec app bash` (or `make bash`) to get into container bash shell.
 - Step 6: Run `composer install` for installing composer packages.

## NOTE:
 - When first start using the website, it will ask you to input database's information. Use information the same as in the `.env` file. The database host must be `db` (the name of docker service, located inside `docker-compose.yml` file), **NOT** `localhost`.
 - Remember to disable or remove any webserver engine (like nginx, apache) that's running on port 80, or the nginx container won't work.
