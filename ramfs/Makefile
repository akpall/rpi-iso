ARCH:=arm64
DISTFILES_URL:=https://distfiles.gentoo.org/releases/$(ARCH)/autobuilds

HOME:=$(shell pwd)

UID=$(shell id -u)

.ONESHELL: prepare_stage3

build: prepare_stage3

check_permissions:
ifneq ($(UID), 0)
	echo "error: root permissions needed"
	exit 1
endif
	exit 0

chroot: check_permissions
	arch-chroot stage3

clean: check_permissions
	rm -rf stage3

prepare_stage3: check_permissions
	LATEST=$(shell curl -s $(DISTFILES_URL)/latest-stage3-$(ARCH)-openrc.txt | awk '/stage3/{print $$1}')
	TAR_NAME=$$(sed 's#^.*/##' <<< $${LATEST})
	[ -d stage3 ] || mkdir stage3
	cd stage3
	[ -f $$TAR_NAME ] || (curl -Os $(DISTFILES_URL)/$$LATEST && tar xf $$TAR_NAME && cp /usr/bin/qemu-aarch64 usr/bin)
