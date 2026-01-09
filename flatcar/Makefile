flatcar: flatcar-scripts flatcar-update

flatcar-scripts:
	if [ ! -d scripts ]; then \
	  git clone https://github.com/flatcar/scripts.git; \
	fi

flatcar-run:
	cd scripts && \
	./run_sdk_container -t

flatcar-update: flatcar-scripts
	cd scripts && \
	git pull . && \
	branch="$$(git tag | grep '^stable-[0-9.]*$$' | sort | tail -n1)"; \
	git checkout "$$branch"

flatcar-custom: flatcar-update
	cp \
	  -R \
	  repository/sys-kernel/coreos-raspberrypi-sources \
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

clean:
	rm -rf scripts
