#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

dc_bin := $(shell command -v docker-compose 2> /dev/null)
docker_bin := $(shell command -v docker 2> /dev/null)
project_id := $(shell basename $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
docker_containers_unique_label := $(project_id)-unique-label

SHELL = /bin/bash
NODE_IMAGE = tarampampam/node:12-alpine
FRONTEND_PORT = 8081
PREVIEW_PORT = 8082
RUN_ARGS = --label "$(docker_containers_unique_label)" --rm -v "$(shell pwd):/src:cached" \
           --workdir "/src" -u "$(shell id -u):$(shell id -g)"
RUN_INTERACTIVE ?= --tty --interactive

.PHONY : help install test fix build shell watch push git-hooks destroy pull init
.SILENT : help install test fix build shell watch push destroy
.DEFAULT_GOAL : help

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) "$(NODE_IMAGE)" yarn install

shell: ## Start shell into container with node
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) \
	  -e "PS1=\[\033[1;32m\]🐳 \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]" \
	  "$(NODE_IMAGE)" bash

watch: install ## Start watching assets for changes
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) "$(NODE_IMAGE)" yarn run start

destroy: ## Kill all spawned (and probably disowned) docker-containers
	$(docker_bin) kill `$(docker_bin) ps --filter "label=$(docker_containers_unique_label)" --format '{{.ID}}'`

build: install## Build application bundle (and docker image)
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) -e "NODE_ENV=production" "$(NODE_IMAGE)" yarn run build

pull: ## Pulling newer versions of used docker images
	$(docker_bin) pull "$(NODE_IMAGE)"

preview: build ## Start container with application in local mode
	$(docker_bin) build -f ./docker/preview/Dockerfile --tag $(docker_containers_unique_label) .
	$(docker_bin) run -p $(PREVIEW_PORT):80 $(docker_containers_unique_label)

.ONESHELL:
release: ## Make release
	if [[ ! `git rev-parse --abbrev-ref HEAD` == "master" ]]; then \
		printf "\n   \e[1;41m %s \033[0m\n\n" 'Checkout to the "master" branch!'; exit 1; \
	fi
	if [[ `git status --porcelain` ]]; then \
		printf "\n   \e[1;41m %s \033[0m\n\n" 'Commit changes before!'; exit 1; \
	fi
	git fetch --tags --force
	printf "\033[32m%s\033[0m %s\n" 'Latest tags:' "`git tag --list | tail -n 3 | tr [:space:] ' '`"
	read -p "Enter release version (like '1.2.3', without any prefix): " RELEASE_VERSION
	if [[ ! $$RELEASE_VERSION =~ ^[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}$$ ]]; then \
		printf "\n   \e[1;41m %s \033[0m\n\n" "'$$RELEASE_VERSION' has invalid format!"; exit 1; \
	fi
	git tag "v$$RELEASE_VERSION"
	git push origin "v$$RELEASE_VERSION"
