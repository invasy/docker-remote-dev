include docker.mk

CMAKE_VERSION  := 3.22.5
NINJA_VERSION  := 1.11.0
NINJA_CHECKSUM := 9726e730d5b8599f82654dc80265e64a10a8a817552c34153361ed0c017f9f02
DEBIAN_VERSION := bullseye

name := cpp

define tags :=
$(image):$(CMAKE_VERSION)-$(DEBIAN_VERSION)
$(image):$(CMAKE_VERSION)
endef
latest := $(image):latest

define build_args :=
DEBIAN_VERSION=$(DEBIAN_VERSION)
NINJA_VERSION=$(NINJA_VERSION)
NINJA_CHECKSUM=$(NINJA_CHECKSUM)
CMAKE_VERSION=$(CMAKE_VERSION)
endef

$(call invalid_targets,run shell bash root)
