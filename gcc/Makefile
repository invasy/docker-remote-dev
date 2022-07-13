include docker.mk

GCC_VERSION    := 12.1.0
CMAKE_VERSION  := 3.22.5
NINJA_VERSION  := 1.10.2
DEBIAN_VERSION := bullseye

name := gcc
port := 22002

define tags :=
$(image):$(GCC_VERSION)-$(CMAKE_VERSION)-$(DEBIAN_VERSION)
$(image):$(GCC_VERSION)-$(DEBIAN_VERSION)
$(image):$(GCC_VERSION)-$(CMAKE_VERSION)
$(image):$(GCC_VERSION)
endef
latest := $(image):latest

define build_args :=
GCC_VERSION=$(GCC_VERSION)
CMAKE_VERSION=$(CMAKE_VERSION)
NINJA_VERSION=$(NINJA_VERSION)
DEBIAN_VERSION=$(DEBIAN_VERSION)
endef
