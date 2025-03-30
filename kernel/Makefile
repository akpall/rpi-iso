ARCH := arm64
VERSION := 20250127

rpi5-kernel:
	case $$(uname -m) in \
		x86_64) \
			PLATFORM=amd64 \
			;; \
		aarch64) \
			PLATFORM=arm64 \
			;; \
	esac; \
	docker build \
		--build-arg ARCH=$${PLATFORM} \
		--build-arg VERSION=${VERSION} \
		--tag rpi5-kernel \
		--platform linux/$$PLATFORM \
		.
	docker create --name rpi5-kernel rpi5-kernel .
	docker cp rpi5-kernel:boot .
	docker cp rpi5-kernel:root .
	docker rm rpi5-kernel
.PHONY: rpi5-kernel

clean:
	@ ( \
	rm -r boot; \
	rm -r root; \
	) 2>/dev/null || true
.PHONY: clean
