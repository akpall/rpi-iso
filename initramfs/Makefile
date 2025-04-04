ARCH := $(shell uname -m)

ifeq ($(ARCH),x86_64)
	PLATFORM=amd64
else
	PLATFORM=arm64
endif

EMERGE_OPTIONS := "--jobs=$$(nproc) --load-average=$$((1+$$(nproc))) --oneshot --root=initramfs"

rpi5-initramfs:
	docker build \
		--build-arg EMERGE_OPTIONS=${EMERGE_OPTIONS} \
		--tag rpi5-initramfs \
		--platform linux/${PLATFORM} \
		.
	docker create --name rpi5-initramfs rpi5-initramfs
	docker cp rpi5-initramfs:/root/initramfs.cpio.gz .
	docker rm rpi5-initramfs
.PHONY: rpi5-initramfs

clean:
	docker image rm rpi5-initramfs
	docker image prune -f
.PHONY: clean
