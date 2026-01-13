RASPBERRYPI_KERNEL_TAG := stable_20250916

raspberrypi-kernel: crossdev-setup
	@ \
	if [ ! -d linux ]; then \
	  git clone \
	    --depth 1 \
	    --branch ${RASPBERRYPI_KERNEL_TAG} \
	    https://github.com/raspberrypi/linux.git; \
	else \
	  cd linux && \
	  git fetch --depth 1 origin tag ${RASPBERRYPI_KERNEL_TAG} && \
	  git checkout ${RASPBERRYPI_KERNEL_TAG}; \
	fi

crossdev-setup:
	@ \
	if ! qlist -I | grep -q sys-devel/crossdev; then \
	  echo "ERROR: no crossdev, run:" && \
	  echo "# emerge sys-devel/crossdev" && \
	  exit 1; \
	fi

	@ \
	if ! command -v emerge-aarch64-linux-gnu >/dev/null; then \
	  echo "ERROR: no aarch64 cross-compiler, run:" && \
	  echo "# crossdev -t aarch64-linux-gnu" && \
	  exit 1; \
	fi
