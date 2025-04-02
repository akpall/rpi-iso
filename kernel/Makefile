ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
	PLATFORM=amd64
else
	PLATFORM=arm64
endif

VERSION := 20250127

rpi5-kernel:
	docker build \
		--build-arg ARCH=${PLATFORM} \
		--build-arg VERSION=${VERSION} \
		--tag rpi5-kernel \
		--platform linux/${PLATFORM} \
		.
	docker create --name rpi5-kernel rpi5-kernel .
	docker cp rpi5-kernel:root/boot .
	docker cp rpi5-kernel:root/root .
	docker rm rpi5-kernel
.PHONY: rpi5-kernel

clean:
	@ ( \
	rm -r boot; \
	rm -r root; \
	) 2>/dev/null || true
	docker image rm rpi5-kernel
.PHONY: clean
