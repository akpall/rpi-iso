FROM rpi5-crossdev AS rpi5-crossdev

WORKDIR /root/

ARG IF_CROSS_COMPILATION_FLAGS
ARG VERSION

RUN curl -L -O https://github.com/raspberrypi/linux/archive/refs/tags/stable_${VERSION}.tar.gz

RUN tar xf stable_${VERSION}.tar.gz

RUN mkdir -p kernel/boot/overlays

COPY config linux-stable_${VERSION}/.config

RUN cd linux-stable_${VERSION} && \
    if [[ ! -s .config ]]; then \
      rm .config && \
      make -j$(nproc) ${IF_CROSS_COMPILATION_FLAGS} bcm2712_defconfig; \
    fi; \
    make -j$(nproc) ${IF_CROSS_COMPILATION_FLAGS} Image modules dtbs && \
    make -j$(nproc) ${IF_CROSS_COMPILATION_FLAGS} INSTALL_MOD_PATH=../kernel modules_install

RUN cd linux-stable_${VERSION}; \
    KERNEL=kernel_2712; \
    cp arch/arm64/boot/Image ../kernel/boot/$KERNEL.img; \
    cp arch/arm64/boot/dts/broadcom/*.dtb ../kernel/boot/; \
    cp arch/arm64/boot/dts/overlays/*.dtb* ../kernel/boot/overlays/; \
    cp arch/arm64/boot/dts/overlays/README ../kernel/boot/overlays/;
