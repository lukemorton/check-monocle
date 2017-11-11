all: once

once:
	docker-compose run --rm spec make __docker_once

__docker_once:
	bundle check || bundle install
	bundle exec rspec

ssh:
	docker-compose run --rm spec ash
