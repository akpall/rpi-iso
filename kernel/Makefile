ARCH := $(shell uname -m)

VERSION := 20250127

ifeq ($(ARCH),x86_64)
	IF_CROSS_COMPILATION_FLAGS := ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
	PLATFORM := amd64
else
	PLATFORM := arm64
endif


rpi5-kernel: config
	docker build \
		--build-arg IF_CROSS_COMPILATION_FLAGS="${IF_CROSS_COMPILATION_FLAGS}" \
		--build-arg VERSION=${VERSION} \
		--tag rpi5-kernel \
		--platform linux/${PLATFORM} \
		.
	docker rm rpi5-kernel >/dev/null 2>&1 || true
	docker create --name rpi5-kernel rpi5-kernel /dev/null
	docker cp rpi5-kernel:/root/kernel/ .
	docker cp rpi5-kernel:/root/linux-stable_${VERSION}/.config config
	docker rm rpi5-kernel
	docker image prune -f
.PHONY: rpi5-kernel

rpi5-kernel-nconfig:
	docker run \
		--interactive \
		--mount type=bind,src=./config,dst=/root/linux-stable_${VERSION}/config \
		--name rpi5-kernel-nconfig \
		--rm \
		--tty \
		--workdir /root/linux-stable_${VERSION} \
		rpi5-kernel \
		sh -c "if [[ -e config ]]; then \
			  cat config > .config; \
			fi; \
			make ${IF_CROSS_COMPILATION_FLAGS} nconfig && \
			cat .config > config"

clean:
	docker image rm rpi5-kernel
	docker image prune -f
.PHONY: clean

config:
	[[ ! -e config ]] && touch config
