EMERGE_OPTIONS := --jobs=$$(nproc) --load-average=$$((1+$$(nproc))) --getbinpkg=y
EMERGE_FEATURES := -ipc-sandbox -network-sandbox -pid-sandbox
export EMERGE_OPTIONS
export EMERGE_FEATURES

ARCH := $(shell uname -m)
export ARCH
# x86_64
# aarch64

default: raspberrypi-kernel-$(ARCH)
.PHONY: default

build-$(ARCH): Dockerfile-$(ARCH)
	docker build \
	  --build-arg FEATURES="$(EMERGE_FEATURES)" \
	  --build-arg EMERGE_OPTIONS="$(EMERGE_OPTIONS)" \
	  --file Dockerfile-$(ARCH) \
	  --tag kernel-test-$(ARCH) \
	  .
.PHONY: build-$(ARCH)

raspberrypi-kernel-$(ARCH): build-$(ARCH)
	docker run \
	  -it \
	  --rm \
	  -e ROOT=/mnt \
	  -v ./output:/mnt \
	  kernel-test-x86_64 \
	  emerge-aarch64-linux-gnu ${EMERGE_OPTIONS} raspberrypi-kernel
.PHONY: raspberrypi-kernel-$(ARCH)
