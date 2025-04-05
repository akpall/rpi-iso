FROM rpi5-crossdev AS rpi5-crossdev

WORKDIR /root/

ARG ARCH
ARG VERSION

RUN curl -L -O https://github.com/raspberrypi/linux/archive/refs/tags/stable_${VERSION}.tar.gz

RUN tar xf stable_${VERSION}.tar.gz

RUN mkdir -p kernel/boot/overlays

COPY [.config] linux-stable_${VERSION}

RUN cd linux-stable_${VERSION}; \
    if [[ $ARCH == "arm64" ]]; then \
      if [[ ! -e ".config" ]]; then \
        make -j$(nproc) bcm2712_defconfig; \
      fi; \
    make -j$(nproc) Image.gz modules dtbs; \
    make -j$(nproc) INSTALL_MOD_PATH=../kernel modules_install; \
    else \
      if [[ ! -e ".config" ]]; then \
        make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2712_defconfig; \
      fi; \
    make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs; \
    make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=../kernel modules_install; \
    fi

RUN cd linux-stable_${VERSION}; \
    KERNEL=kernel_2712; \
    cp arch/arm64/boot/Image ../kernel/boot/$KERNEL.img; \
    cp arch/arm64/boot/dts/broadcom/*.dtb ../kernel/boot/; \
    cp arch/arm64/boot/dts/overlays/*.dtb* ../kernel/boot/overlays/; \
    cp arch/arm64/boot/dts/overlays/README ../kernel/boot/overlays/;

FROM scratch

ARG VERSION

COPY --from=rpi5-crossdev /root/kernel/ /root/kernel
COPY --from=rpi5-crossdev /root/linux-stable_${VERSION}/.config /root/.config
