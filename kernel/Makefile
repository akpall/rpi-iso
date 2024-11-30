ARCH := arm64
CROSS_COMPILE := aarch64-akpall-linux-musl-


kernel: linux-stable_20241008/ linux-stable_20241008/.config .linux-make firmware/linux-akpall.img
.PHONY: kernel


clean:
	-rm -rf firmware/
	-rm -rf linux-stable_20241008/
	-rm .linux-make
	-rm stable_20241008.tar.gz
.PHONY: clean


.linux-make: linux-stable_20241008/.config
	cd linux && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -j$$(nproc) Image.gz modules dtbs
	touch .linux-make


firmware/linux-akpall.img: .linux-make
	if [ -d firmware ]; then \
	rm -r firmware; \
	fi
	mkdir firmware firmware/overlays
	cp linux/arch/arm64/boot/Image.gz firmware/linux-akpall.img
	cp linux/arch/arm64/boot/dts/broadcom/*.dtb firmware/
	cp linux/arch/arm64/boot/dts/overlays/*.dtb* firmware/overlays/
	cp linux/arch/arm64/boot/dts/overlays/README firmware/overlays/


linux-make-nconfig:
	cd linux && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) nconfig && \
	cp .config ..
.PHONY: linux-make-nconfig


linux-stable_20241008/.config: linux-stable_20241008/
	cp .config linux-stable_20241008/
	cd linux-stable_20241008/ && \
	KERNEL=kernel_2712 && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) bcm2712_defconfig


linux-stable_20241008/: stable_20241008.tar.gz
	tar xf stable_20241008.tar.gz


stable_20241008.tar.gz:
	curl -L -O https://github.com/raspberrypi/linux/archive/refs/tags/stable_20241008.tar.gz
