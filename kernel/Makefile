ARCH := arm64
CROSS_COMPILE := aarch64-akpall-linux-musl-


kernel: linux linux/.config .linux-make firmware/linux-akpall.img
.PHONY: kernel


clean:
	rm -rf .linux-make firmware linux
.PHONY: clean


linux/.config:
	cp .config linux
	cd linux && \
	KERNEL=kernel_2712 && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) bcm2712_defconfig


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


.linux-make: linux/.config
	cd linux && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -j$$(nproc) Image.gz modules dtbs
	touch .linux-make
.PHONY: linux-make-nconfig

linux:
	-git clone --depth 1 https://github.com/raspberrypi/linux.git
.PHONY: linux
