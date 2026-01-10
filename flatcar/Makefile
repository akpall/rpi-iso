PI_VERSION := 6.12.47

flatcar: flatcar-latest-stable

flatcar-latest-stable:
	LATEST_STABLE=$$( \
	  git ls-remote --tags "https://github.com/flatcar/scripts.git" | \
	    sed -n 's/.*\(stable-[0-9\.]\+$$\)/\1/p' | \
	      tail -n1 \
	) && \
	  if [ ! -d scripts ]; then \
	    git clone --depth 1 --branch $${LATEST_STABLE} https://github.com/flatcar/scripts.git; \
	  else \
	    cd scripts; \
	    git pull . $${LATEST_STABLE}; \
	  fi

flatcar-run:
	cd scripts && \
	./run_sdk_container -t -a arm64

flatcar-remove-container:
	cd scripts && \
	./run_sdk_container -a arm64 --rm -- exit

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

clean:
	rm -rf scripts
