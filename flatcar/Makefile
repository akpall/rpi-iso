PI_VERSION := 6.12.47
FLATCAR_SCRIPTS_GIT := https://github.com/flatcar/scripts.git

flatcar: flatcar-scripts

flatcar-scripts:
	@ \
	if [ ! -d flatcar-scripts ]; then \
	  echo "Cloning git@github.com:akpall/flatcar-scripts.git" && \
	  git clone --branch stable-akpall git@github.com:akpall/flatcar-scripts.git; \
	fi

	@ \
	cd flatcar-scripts && \
	if ! git remote | grep -q "^flatcar$$"; then \
	  echo "Adding flatcar remote" && \
	  git remote add flatcar ${FLATCAR_SCRIPTS_GIT}; \
	fi
.PHONY: flatcar-scripts

flatcar-update:
	@ \
	cd flatcar-scripts && \
	if ! git branch --format='%(refname:short)' | grep -q 'stable-akpall'; then \
	  echo "Creating stable-latest branch" ** \
	  git branch stable-latest origin/stable-latest; \
	fi && \
	LATEST_STABLE=$$( \
	  git ls-remote --tags "${FLATCAR_SCRIPTS_GIT}" | \
	    sed -n 's/.*\(stable-[0-9\.]\+$$\)/\1/p' | \
	      tail -n1 \
	) && \
	git fetch flatcar && \
	git branch -f stable-latest "$${LATEST_STABLE}"

.PHONY: flatcar-update

flatcar-run:
	cd scripts && \
	./run_sdk_container -t -a arm64
.PHONY: flatcar-run

flatcar-remove-container:
	cd scripts && \
	./run_sdk_container -a arm64 --rm -- exit
.PHONY: flatcar-remove-container

flatcar-custom: flatcar-latest-stable
	cp \
	  -R \
	  repository/sys-kernel/coreos-raspberrypi-sources \
	  repository/sys-kernel/coreos-raspberrypi-modules \
	  repository/sys-kernel/coreos-raspberrypi-kernel \
	  repository/sys-kernel/coreos-raspberrypi-firmware \
	  scripts/sdk_container/src/third_party/coreos-overlay/sys-kernel

	sed \
	  -i \
	  's/coreos-sources/coreos-raspberrypi-sources/g' \
	  scripts/sdk_container/src/third_party/coreos-overlay/eclass/coreos-kernel.eclass

	sed \
	  -i \
	  's/coreos-sources/coreos-raspberrypi-sources/g' \
	  scripts/sdk_container/src/third_party/coreos-overlay/profiles/coreos/base/package.use

	sed \
	  -i \
	  's/coreos-sources/coreos-raspberrypi-sources/g' \
	  scripts/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-firmware/coreos-firmware-99999999.ebuild

	sed \
	  -i \
	  's#sys-kernel/coreos-kernel#sys-kernel/coreos-raspberrypi-kernel#g' \
	  scripts/sdk_container/src/third_party/coreos-overlay/coreos-base/coreos/coreos-0.0.1.ebuild

	sed \
	  -i \
	  's#sys-kernel/coreos-firmware#sys-kernel/coreos-raspberrypi-firmware#g' \
	  scripts/sdk_container/src/third_party/coreos-overlay/coreos-base/coreos/coreos-0.0.1.ebuild

	cd scripts/sdk_container/src/third_party/coreos-overlay/app-emulation/hv-daemons; \
	  if [ ! -h hv-daemons-${PI_VERSION}.ebuild ]; then \
	    ln -s \
	      hv-daemons-9999.ebuild \
	      hv-daemons-6.12.47.ebuild; \
	  fi

	sed \
	  -i \
	  's#sys-kernel/coreos-kernel#sys-kernel/coreos-raspberrypi-kernel#g' \
	  scripts/sdk_container/src/third_party/coreos-overlay/virtual/linux-sources/linux-sources-2-r2.ebuild
.PHONY: flatcar-custom

clean:
	rm -rf flatcar-scripts
.PHONY: clean
