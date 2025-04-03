ARCH := $(shell uname -m)

VERSION := 20250127

ifeq ($(ARCH),x86_64)
	PLATFORM=amd64
else
	PLATFORM=arm64
endif


rpi5-kernel:
	docker build \
		--build-arg ARCH=${PLATFORM} \
		--build-arg VERSION=${VERSION} \
		--tag rpi5-kernel \
		--platform linux/${PLATFORM} \
		.
.PHONY: rpi5-kernel

clean:
	docker image rm rpi5-kernel
	docker image prune -f
.PHONY: clean
