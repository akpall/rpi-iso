UID=$(shell id -u)

ARCH:=arm64
DISTFILES_URL:=https://distfiles.gentoo.org/releases/$(ARCH)/autobuilds

CATALYST_HOME:=/var/tmp/catalyst

.ONESHELL: prepare_seed stage1

all: check_dependencies releng prepare_seed stage1

check_dependencies:
ifeq ($(wildcard /usr/bin/catalyst),)
	@echo "error: install catalyst"
	@exit 1
else ifneq ($(UID), 0)
	@echo "error: root permissions needed"
	@exit 1
endif
	@exit

clean:
	@rm -rf releng
	@rm -rf $(CATALYST_HOME)
	@rm installcd-stage1.spec

releng:
	@git clone https://github.com/gentoo/releng.git

prepare_seed:
	@mkdir -p $(CATALYST_HOME)/builds/23.0-default

	LATEST=$(shell curl -s $(DISTFILES_URL)/latest-stage3-$(ARCH)-openrc.txt | awk '/stage3/{print $$1}')
	@cd $(CATALYST_HOME)/builds/23.0-default && curl -Os $(DISTFILES_URL)/$$LATEST

	@cd $(CATALYST_HOME) && catalyst -s stable

stage1:
	@curl -Os https://raw.githubusercontent.com/gentoo/releng/master/releases/specs/$(ARCH)/installcd-stage1.spec

	TIMESTAMP=$(shell find /var/tmp/catalyst/builds/23.0-default/ -name 'stage3-$(ARCH)-openrc-*.tar.xz' | awk -F[.-] '{print $$6}')
	TREEISH=$(shell find /var/tmp/catalyst/snapshots/ -name 'gentoo-*.sqfs' | awk -F[.-] '{print $$2}')
	REPO_DIR=$(shell pwd)
	sed -i "s/@TIMESTAMP@/$$TIMESTAMP/g" installcd-stage1.spec
	sed -i "s/@TREEISH@/$$TREEISH/g" installcd-stage1.spec
	sed -i "s#@REPO_DIR@#$$REPO_DIR/releng#g" installcd-stage1.spec
	sed -i "s#isos#isos-qemu#g" installcd-stage1.spec
	echo  >> installcd-stage1.spec
	echo 'interpreter: /usr/bin/qemu-aarch64' >> installcd-stage1.spec

stage2:
	@curl -Os https://raw.githubusercontent.com/gentoo/releng/master/releases/specs/arm64/installcd-stage2-minimal.spec

	TIMESTAMP=$(shell find /var/tmp/catalyst/builds/23.0-default/ -name 'stage3-$(ARCH)-openrc-*.tar.xz' | awk -F[.-] '{print $$6}')
	TREEISH=$(shell find /var/tmp/catalyst/snapshots/ -name 'gentoo-*.sqfs' | awk -F[.-] '{print $$2}')
	REPO_DIR=$(shell pwd)
	sed -i "s/@TIMESTAMP@/$$TIMESTAMP/g" installcd-stage2-minimal.spec
	sed -i "s/@TREEISH@/$$TREEISH/g" installcd-stage2-minimal.spec
	sed -i "s#@REPO_DIR@#$$REPO_DIR/releng#g" installcd-stage2-minimal.spec
	sed -i "s#isos#isos-qemu#g" installcd-stage2-minimal.spec
	echo  >> installcd-stage1.spec
	echo 'interpreter: /usr/bin/qemu-aarch64' >> installcd-stage2-minimal.spec
