UID=$(shell id -u)

ARCH:=arm64
DISTFILES_URL:=https://distfiles.gentoo.org/releases/$(ARCH)/autobuilds

CATALYST_HOME:=/var/tmp/catalyst

HOME:=$(shell pwd)

.ONESHELL: prepare_seed stage1 stage2

.PHONY:

build: check_dependencies stage1-build stage2-build

check_dependencies:
ifeq ($(wildcard /usr/bin/catalyst),)
	echo "error: install catalyst"
	exit 1
endif
	exit 0

check_permissions:
ifneq ($(UID), 0)
	echo "error: root permissions needed"
	exit 1
endif
	exit 0

clean: check_permissions
	rm -r releng
	rm -r $(CATALYST_HOME)
	rm installcd-stage1.spec
	rm installcd-stage2-minimal.spec

releng:
	git clone https://github.com/gentoo/releng.git

	rm -r $(HOME)/releng/releases/portage/isos-qemu/patches

prepare_seed: check_permissions
	LATEST=$(shell curl -s $(DISTFILES_URL)/latest-stage3-$(ARCH)-openrc.txt | awk '/stage3/{print $$1}')

	mkdir -p $(CATALYST_HOME)/builds/23.0-default

	cd $(CATALYST_HOME)/builds/23.0-default && curl -Os $(DISTFILES_URL)/$$LATEST

	cd $(CATALYST_HOME) && catalyst -s stable

	touch prepare_seed

stage1:	prepare_seed releng
	TIMESTAMP=$(shell find /var/tmp/catalyst/builds/23.0-default/ -name 'stage3-$(ARCH)-openrc-*.tar.xz' | awk -F[.-] '{print $$6}')
	TREEISH=$(shell find /var/tmp/catalyst/snapshots/ -name 'gentoo-*.sqfs' | awk -F[.-] '{print $$2}')

	cp releng/releases/specs/arm64/installcd-stage1.spec .

	sed -i "s/@TIMESTAMP@/$$TIMESTAMP/g" installcd-stage1.spec
	sed -i "s/@TREEISH@/$$TREEISH/g" installcd-stage1.spec
	sed -i "s#@REPO_DIR@#$(HOME)/releng#g" installcd-stage1.spec
	sed -i "s#isos#isos-qemu#g" installcd-stage1.spec

	echo  >> installcd-stage1.spec
	echo 'interpreter: /usr/bin/qemu-aarch64' >> installcd-stage1.spec

	touch stage1

stage1-build: check_permissions stage1
	catalyst -f installcd-stage1.spec

stage2: stage1
	TIMESTAMP=$(shell find /var/tmp/catalyst/builds/23.0-default/ -name 'stage3-$(ARCH)-openrc-*.tar.xz' | awk -F[.-] '{print $$6}')
	TREEISH=$(shell find /var/tmp/catalyst/snapshots/ -name 'gentoo-*.sqfs' | awk -F[.-] '{print $$2}')
	REPO_DIR=$(shell pwd)

	cp releng/releases/specs/arm64/installcd-stage2-minimal.spec .

	sed -i "s/@TIMESTAMP@/$$TIMESTAMP/g" installcd-stage2-minimal.spec
	sed -i "s/@TREEISH@/$$TREEISH/g" installcd-stage2-minimal.spec
	sed -i "s#@REPO_DIR@#$$REPO_DIR/releng#g" installcd-stage2-minimal.spec
	sed -i "s#isos#isos-qemu#g" installcd-stage2-minimal.spec

	echo  >> installcd-stage1.spec
	echo 'interpreter: /usr/bin/qemu-aarch64' >> installcd-stage2-minimal.spec

	touch stage2

stage2-build: check_permissions stage1-build
	catalyst -f installcd-stage2-minimal.spe c
