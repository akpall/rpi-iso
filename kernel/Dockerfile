FROM rpi5-crossdev

WORKDIR /root/

ARG VERSION

RUN curl -L -O https://github.com/raspberrypi/linux/archive/refs/tags/stable_${VERSION}.tar.gz
RUN tar xf stable_${VERSION}.tar.gz

RUN mkdir -p boot/overlays; \
    mkdir root;

RUN cd linux-stable_${VERSION}; \
    if [[ $ARCH == "arm64" ]]; then \
    make -j$(nproc) bcm2712_defconfig; \
    make -j$(nproc) Image.gz modules dtbs; \
    make -j$(nproc) INSTALL_MOD_PATH=../root modules_install; \
    else \
    make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2712_defconfig; \
    make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs; \
    make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=../root modules_install; \
    fi

RUN cd linux-stable_${VERSION}; \
    KERNEL=kernel_2712; \
    cp arch/arm64/boot/Image ../boot/$KERNEL.img; \
    cp arch/arm64/boot/dts/broadcom/*.dtb ../boot/; \
    cp arch/arm64/boot/dts/overlays/*.dtb* ../boot/overlays/; \
    cp arch/arm64/boot/dts/overlays/README ../boot/overlays/;
