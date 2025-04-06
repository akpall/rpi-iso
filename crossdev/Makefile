ARCH := $(shell uname -m)

ifeq ($(ARCH),x86_64)
	PLATFORM=amd64
else
	PLATFORM=arm64
endif

EMERGE_FEATURES := "-ipc-sandbox -network-sandbox -pid-sandbox"
EMERGE_OPTIONS := "--getbinpkg --jobs=$$(nproc) --load-average=$$((1+$$(nproc)))"

rpi5-crossdev:
	docker build \
		--build-arg EMERGE_FEATURES=${EMERGE_FEATURES} \
		--build-arg EMERGE_OPTIONS=${EMERGE_OPTIONS} \
		--tag rpi5-crossdev \
		--platform linux/${PLATFORM} \
		.
	docker image prune -f
.PHONY: rpi5-crossdev

clean:
	docker image rm rpi5-crossdev >/dev/null 2>&1 || true
	docker image prune -f
.PHONY: clean
