ARCH:=arm64
DISTFILES_URL:=https://distfiles.gentoo.org/releases/$(ARCH)/autobuilds

CATALYST_HOME:=/var/tmp/catalyst

HOME:=$(shell pwd)

build: check_dependencies stage1-build stage2-build
.PHONY: build

check_dependencies:
	@ \
	DEP_LIST="catalyst"; \
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

clean: check_permissions
	@rm -fr releng
	@rm -fr $(CATALYST_HOME)
	@rm -f stage1.spec
	@rm -f stage2.spec
	@rm -f prepare_seed
.PHONY: clean

prepare_seed: check_permissions
	@ \
	if [ ! -f prepare_seed ]; then \
		LATEST=$$(curl -s $(DISTFILES_URL)/latest-stage3-$(ARCH)-openrc.txt | awk '/stage3/{print $$1}'); \
		mkdir -p $(CATALYST_HOME)/builds/23.0-default; \
		cd $(CATALYST_HOME)/builds/23.0-default; \
		curl -Os $(DISTFILES_URL)/"$$LATEST"; \
		cd $(CATALYST_HOME); \
		catalyst -s stable; \
		touch $(HOME)/prepare_seed; \
	fi
.PHONY: prepare_seed

releng: check_permissions
	@ \
	if [ ! -d releng ]; then \
		git clone https://github.com/gentoo/releng.git; \
		rm -r $(HOME)/releng/releases/portage/isos-qemu/patches; \
	fi
.PHONY: releng

stage1-build: check_permissions stage1.spec
	catalyst -f stage1.spec

stage1.spec: prepare_seed releng
ifeq ($(wildcard $(HOME)/stage1.spec),)
	TIMESTAMP=$(shell find /var/tmp/catalyst/builds/23.0-default/ -name 'stage3-$(ARCH)-openrc-*.tar.xz' | awk -F[.-] '{print $$6}')
	TREEISH=$(shell find /var/tmp/catalyst/snapshots/ -name 'gentoo-*.sqfs' | awk -F[.-] '{print $$2}')
	cp releng/releases/specs/arm64/installcd-stage1.spec $(HOME)/stage1.spec
	sed -i "s/@TIMESTAMP@/$$TIMESTAMP/g" stage1.spec
	sed -i "s/@TREEISH@/$$TREEISH/g" stage1.spec
	sed -i "s#@REPO_DIR@#$(HOME)/releng#g" stage1.spec
	sed -i "s#isos#isos-qemu#g" stage1.spec
	echo  >> stage1.spec
	echo 'interpreter: /usr/bin/qemu-aarch64' >> stage1.spec
endif
	exit 0

stage2-build: check_permissions stage2.spec
	catalyst -f stage2.spec

stage2.spec: prepare_seed releng
ifeq ($(wildcard $(HOME)/stage2.spec),)
	TIMESTAMP=$(shell find /var/tmp/catalyst/builds/23.0-default/ -name 'stage3-$(ARCH)-openrc-*.tar.xz' | awk -F[.-] '{print $$6}')
	TREEISH=$(shell find /var/tmp/catalyst/snapshots/ -name 'gentoo-*.sqfs' | awk -F[.-] '{print $$2}')
	REPO_DIR=$(shell pwd)
	cp releng/releases/specs/arm64/installcd-stage2-minimal.spec $(HOME)/stage2.spec
	sed -i "s/@TIMESTAMP@/$$TIMESTAMP/g" stage2.spec
	sed -i "s/@TREEISH@/$$TREEISH/g" stage2.spec
	sed -i "s#@REPO_DIR@#$$REPO_DIR/releng#g" stage2.spec
	sed -i "s#isos#isos-qemu#g" stage2.spec
	echo  >> stage2.spec
	echo 'interpreter: /usr/bin/qemu-aarch64' >> stage2.spec
endif
	exit 0
