flatcar: flatcar-scripts flatcar-update

flatcar-scripts:
	if [ ! -d scripts ]; then \
	  git clone https://github.com/flatcar/scripts.git; \
	fi

flatcar-run:
	cd scripts && \
	./run_sdk_container -t -a arm64

flatcar-remove-container:
	cd scripts && \
	./run_sdk_container -a arm64 --rm -- exit

flatcar-update: flatcar-scripts
	cd scripts && \
	git pull . && \
	branch="$$(git tag | grep '^stable-[0-9.]*$$' | sort | tail -n1)"; \
	git checkout "$$branch"

flatcar-custom: flatcar-update
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

clean:
	rm -rf scripts
