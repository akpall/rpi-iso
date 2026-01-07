RASPBERRYPI_KERNEL_TAG := stable_20250916

raspberrypi-kernel:
	if [ ! -d linux ]; then \
	  git clone \
	    --depth 1 \
	    --branch ${RASPBERRYPI_KERNEL_TAG} \
	    https://github.com/raspberrypi/linux.git; \
	else \
	  cd linux; \
	  git fetch --depth 1 origin tag ${RASPBERRYPI_KERNEL_TAG}; \
	  git checkout ${RASPBERRYPI_KERNEL_TAG}; \
	fi
