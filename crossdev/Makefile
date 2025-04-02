ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
	PLATFORM=amd64
else
	PLATFORM=arm64
endif

VERSION := 20250127


rpi5-crossdev:
	docker build \
		--tag rpi5-crossdev \
		--platform linux/${PLATFORM} \
		.
.PHONY: rpi5-crossdev

clean:
	docker image rpi5-crossdev
.PHONY: clean
