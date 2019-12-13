#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

docker_bin := $(shell command -v docker 2> /dev/null)

SHELL = /bin/bash
NODE_IMAGE = tarampampam/node:12-alpine
FRONTEND_PORT = 8081
PREVIEW_PORT = 8082
RUN_ARGS = --rm -v "$(shell pwd):/src:cached" \
           --workdir "/src" -u "$(shell id -u):$(shell id -g)"
RUN_INTERACTIVE ?= --tty --interactive

.PHONY : help install shell watch push pull
.SILENT : help install shell watch push build
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

build: install## Build application bundle (and docker image)
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) -e "NODE_ENV=production" "$(NODE_IMAGE)" yarn run build

pull: ## Pulling newer versions of used docker images
	$(docker_bin) pull "$(NODE_IMAGE)"

