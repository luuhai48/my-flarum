D := $(shell pwd)
default:
	make up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

stop:
	docker-compose stop

reset:
	docker-compose restart

bash:
	docker-compose exec app bash
