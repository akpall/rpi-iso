ARCH := arm64
CROSS_COMPILE := aarch64-akpall-linux-musl-


kernel: linux linux-config linux-make linux-firmware
.PHONY: kernel


linux:
	git clone --depth 1 https://github.com/raspberrypi/linux.git || true
	cp .config linux
.PHONY: linux


linux-config:
	cd linux && \
	KERNEL=kernel_2712 && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) bcm2712_defconfig
.PHONY: linux-config


linux-make-nconfig:
	cd linux && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) nconfig && \
	cp .config ..
.PHONY: linux-make-nconfig


clean:
	rm -rf linux
.PHONY: clean


linux-make:
	cd linux && \
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -j$$(nproc) Image.gz modules dtbs
.PHONY: linux-make-nconfig

linux-firmware:
	cd linux && \
	mkdir ../firmware && \
	cp arch/arm64/boot/Image.gz ../firmware/linux-akpall.img && \
	cp arch/arm64/boot/dts/broadcom/*.dtb ../firmware/ && \
	mkdir ../firmware/overlays && \
	cp arch/arm64/boot/dts/overlays/*.dtb* ../firmware/overlays/ && \
	cp arch/arm64/boot/dts/overlays/README ../firmware/overlays/
.PHONY: linux-firmware
