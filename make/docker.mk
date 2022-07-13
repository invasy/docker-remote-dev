SHELL := /bin/bash

NAMESPACE := invasy
image = $(NAMESPACE)/remote-dev-$(name)
container = remote_dev_$(name)

invalid_targets = $(eval $1:;@$$(error invalid target '$$@' for image '$${name}')false)

.PHONY: all build run deploy push pull shell bash root list clean info
all: build

build: Dockerfile
	@docker build --progress plain $(if $(no_cache),--no-cache )\
		$(addprefix --build-arg=,$(build_args)) \
		$(addprefix --tag=,$(tags) $(latest)) .

run: build
	@docker run --detach --cap-add=sys_admin --name='$(container)' \
		--publish='127.0.0.1:$(port):22' --restart=unless-stopped '$(firstword $(tags))'

deploy push: build
	@$(foreach t,$(tags),docker image push '$t' &&) $(if $(latest),docker image push '$(latest)',:)

pull:
	@docker image pull '$(if $(tag),$(tag),$(firstword $(tags)))'

shell bash:
	@docker exec --interactive --tty --user builder --workdir /home/builder '$(container)' /bin/bash

root:
	@docker exec --interactive --tty --workdir /root '$(container)' /bin/bash

list:
	@-docker container ls -f 'name=$(container)'
	@-docker image ls '$(image)'

clean:
	@-docker container rm $$(docker container ls -q -f 'name=$(container)')
	@-docker image rm -f $$(docker image ls -q '$(image)')

info:
	@echo 'name=$(name)'
