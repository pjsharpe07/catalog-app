.PHONY: all build clean copy-src local requirements setup test up update-dependencies create-admin

CKAN_HOME := /usr/lib/ckan

all: build

build:
	docker-compose build

clean:
	docker-compose down -v --remove-orphans

copy-src:
	docker cp catalog-app_app_1:$(CKAN_HOME)/src .

local:
	docker-compose -f docker-compose.yml -f docker-compose.local.yml up

requirements:
	docker-compose run --rm -T app pip --quiet freeze > requirements-freeze.txt

test:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml build
	docker-compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit test

update-dependencies:
	docker-compose run --rm -T app pip install -r requirements.txt

up:
	docker-compose up -d

create-admin:
	docker-compose run --rm app ckan sysadmin add admin

hop-in:
	docker-compose exec app /bin/bash

prune:
	docker system prune -a

# harvester-steps
harvest-run:
	docker-compose run --rm app ckan --plugin=ckanext-harvest harvester run

harvest-gather:
	docker-compose run --rm app ckan --plugin=ckanext-harvest harvester gather_consumer

harvest-fetch:
	docker-compose run --rm app ckan --plugin=ckanext-harvest harvester fetch_consumer