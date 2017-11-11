all: build once

build:
	docker-compose build

once:
	docker-compose run --rm spec make __docker_once

__docker_once:
	bundle check || bundle install
	bundle exec rspec

shell:
	docker-compose run --rm spec bash
