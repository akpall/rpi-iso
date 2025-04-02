ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
	PLATFORM=amd64
else
	PLATFORM=arm64
endif


initramfs: root packages root/init initramfs.cpio.gz
.PHONY: initramfs


initramfs.cpio.gz: root/init
	sudo sh -c '\
	(cd root && \
	find . -print0 | \
	cpio --null --create --verbose --format=newc | \
	gzip --best) > initramfs.cpio.gz'


clean:
	-sudo rm -r root
	-rm initramfs.cpio.gz
.PHONY: clean


packages: root
	sudo ${EMERGE} busybox musl curl
.PHONY: packages


root/init: init root
	sudo sh -c '\
	cp init root && \
	chmod +x root/init'


rpi5-initramfs:
	docker build \
		--build-arg ARCH=${PLATFORM} \
		--build-arg VERSION=${VERSION} \
		--tag rpi5-initramfs \
		--platform linux/${PLATFORM} \
		.
.PHONY: rpi5-initramfs
