ARCH:=arm64
DISTFILES_URL:=https://distfiles.gentoo.org/releases/$(ARCH)/autobuilds

HOME:=$(shell pwd)

build: prepare_stage3
.PHONY: build

check_dependencies:
	@ \
	DEP_LIST="arch-chroot qemu-aarch64"; \
	for DEP in $${DEP_LIST}; do \
		if ! command -v "$$DEP" >/dev/null; then \
			echo "error: missing dependency $$DEP"; \
			exit 1; \
		fi \
	done
.PHONY: check_dependencies

check_permissions:
	@ \
	if [ "$$(id -u)" != 0 ]; then \
		echo "error: root permissions needed"; \
		exit 1; \
	fi
.PHONY: check_permissions

chroot: check_permissions check_dependencies
	@arch-chroot stage3
.PHONY: chroot

clean: check_permissions
	@rm -rf stage3
.PHONY: clean

prepare_stage3: check_permissions
	@ \
	if [ ! -d stage3 ]; then \
		LATEST=$$(curl -s $(DISTFILES_URL)/latest-stage3-$(ARCH)-openrc.txt | awk '/stage3/{print $$1}'); \
		TAR_NAME=$$(sed 's#^.*/##' <<< $${LATEST}); \
		mkdir stage3; \
		cd stage3; \
		curl -Os $(DISTFILES_URL)/$$LATEST; \
		tar xf $$TAR_NAME; \
		cp /usr/bin/qemu-aarch64 usr/bin; \
	fi
.PHONY: prepare_stage3
