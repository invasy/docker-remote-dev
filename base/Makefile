include docker.mk

DEBIAN_VERSION := bullseye

name := base

define tags :=
$(image):$(DEBIAN_VERSION)
endef
latest := $(image):latest

define build_args :=
DEBIAN_VERSION=$(DEBIAN_VERSION)
endef

$(call invalid_targets,run shell bash root)
