RAILS = docker-compose run --rm app rails
BASH = docker exec -it docker-fwp-app
# RAILS = docker exec -it docker-fwp-app bundle exec rails
# CURRENT_DIRECTORY := $(shell pwd)
## docker up -d web
## docker-compose ps

# include .env

### Rails related
about:
	@$(RAILS) about
# create:
# 	@$(RAILS) db:create
# drop:
# 	@$(RAILS) db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
migrate:
	@$(RAILS) db:migrate
create:
	@$(RAILS) db:create
console:
	@$(RAILS) console
### Docker related
in:
	@${BASH} /bin/sh
up:
	@docker-compose up -d app
down:
	@docker-compose stop app
stop:
	@docker-compose stop
build:
	@make pull
	@echo build docker-fwp:v1.0.0 ...
	@docker build -t docker-fwp:v1.0.0 --build-arg GIT_COMMIT=$(shell git rev-parse --short HEAD) --no-cache . -f Dockerfile
	@echo 'prune old images'
	@docker image prune -f
ps:
	@docker ps
logs:
	@${BASH} tail -f log/production.log
killall:
	@docker kill $(docker ps -q)
restart:
	@make down
	@make up
start:
	@make up
status:
	@make ps
pruneimage:
	@echo 'prune old images'
	@docker image prune -f
prune:
	@docker system prune
df:
	@docker system df
containers:
	@docker container ls -a
images:
	@docker images -a
# @echo "Migrate..."
# @make migrate
update:
	@make build
	@echo "Restart..."
	@make restart
	@make ps
	@make clean
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi
### Other
pull:
	@git checkout feature/dev
	@git pull --rebase
	@PAGER=cat git log --graph --abbrev-commit --decorate --date=relative --format=format:'%Cblue%G?%Creset %C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(magenta)%s%C(reset)%C(dim green)- %an%C(reset)%C(bold yellow)%d%C(reset)' -10
	@echo
