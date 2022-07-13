SHELL := /bin/bash

D := $(patsubst %/,%,$(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

IMAGES          := $(subst /Makefile,,$(wildcard */Makefile))
TARGETS         := build run deploy push pull list clean info
IMAGE_TARGETS   := $(TARGETS) shell bash root
INVALID_TARGETS := $(foreach i,base cpp,$(foreach t,run shell bash root,$i-$t))
ALL_TARGETS     := $(foreach i,$(IMAGES),$(foreach t,$(IMAGE_TARGETS),$i-$t))
VALID_TARGETS   := $(filter-out $(INVALID_TARGETS),$(ALL_TARGETS))

image = $(firstword $(subst -, ,$1))
target = $(lastword $(subst -, ,$1))

export no_cache tag

.PHONY: all help versions login down $(IMAGES) $(IMAGE_TARGETS) $(ALL_TARGETS)
.PHONY: $(addsuffix -up,$(IMAGES)) $(addsuffix -down,$(IMAGES))

all: build

help:
	@:$(info TODO)

versions:
	@find . -type f -regex '.*/\(Make\|Docker\)file' -exec \
	grep --color=auto --with-filename --line-number --initial-tab \
	--perl-regexp '^\s*(?:ARG\s+)?[A-Z]+_VERSION(?:\s*:=\s*|=)(['\''"]?)(?:[a-z]+|\d+(?:\.\d+)*)\1$$' '{}' +

login:
	@echo "$${DOCKER_PASSWORD:?}" | docker login --username="$${DOCKER_USERNAME:?}" --password-stdin "$${DOCKER_REGISTRY}"

$(foreach t,$(TARGETS),$(eval $t: $(filter-out $(INVALID_TARGETS),$(addsuffix -$t,$(IMAGES)))))
$(foreach t,$(VALID_TARGETS),$(eval $t:;@$$(MAKE) -I '$$D/make' -C '$$D/$(call image,$t)' '$(call target,$t)'))
$(foreach t,$(INVALID_TARGETS),$(eval $t:;@$$(error invalid target '$(call target,$t)' for image '$(call image,$t)')false))

$(IMAGES):
	@$(MAKE) --include-dir='$D/make' --directory='$D/$@'

$(addsuffix -up,$(IMAGES)): docker-compose.yml
	@docker-compose up -d '$(call image,$@)'

down $(addsuffix -down,$(IMAGES)): docker-compose.yml
	@docker-compose down

$(filter-out base,$(IMAGES)): base
$(addsuffix -build,$(filter-out base,$(IMAGES))): base-build

clang gcc: cpp
$(addsuffix -build,clang gcc): cpp-build

$(addsuffix -push,$(IMAGES)): login
