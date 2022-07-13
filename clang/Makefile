include docker.mk

CLANG_VERSION  := 14
CMAKE_VERSION  := 3.22.5
NINJA_VERSION  := 1.11.0
DEBIAN_VERSION := bullseye

name := clang
port := 22001

define tags :=
$(image):$(CLANG_VERSION)-$(CMAKE_VERSION)-$(DEBIAN_VERSION)
$(image):$(CLANG_VERSION)-$(DEBIAN_VERSION)
$(image):$(CLANG_VERSION)-$(CMAKE_VERSION)
$(image):$(CLANG_VERSION)
endef
latest := $(image):latest

define build_args :=
CLANG_VERSION=$(CLANG_VERSION)
CMAKE_VERSION=$(CMAKE_VERSION)
NINJA_VERSION=$(NINJA_VERSION)
DEBIAN_VERSION=$(DEBIAN_VERSION)
endef
