FROM rpi5-kernel AS rpi5-kernel
FROM rpi5-crossdev AS rpi5-crossdev

WORKDIR /root/

ARG EMERGE_OPTIONS

COPY package.use /usr/aarch64-linux-gnu/etc/portage/

# FEATURES env variable is broken with emerge crosscompiler. Need to file a bug
RUN sed -i \
    's/FEATURES="-collision-protect sandbox buildpkg noman noinfo nodoc"/FEATURES="-collision-protect -ipc-sandbox -network-sandbox -pid-sandbox buildpkg nodoc noinfo noman sandbox"/' \
    /usr/aarch64-linux-gnu/etc/portage/make.conf

RUN mkdir -p \
    initramfs/bin \
    initramfs/dev \
    initramfs/etc \
    initramfs/lib \
    initramfs/lib64\
    initramfs/mnt/root \
    initramfs/proc \
    initramfs/root \
    initramfs/sbin \
    initramfs/sys

RUN emerge-aarch64-linux-gnu ${EMERGE_OPTIONS} sys-apps/busybox
RUN emerge-aarch64-linux-gnu ${EMERGE_OPTIONS} net-misc/curl

COPY init initramfs
RUN chmod +x initramfs/init

COPY --from=rpi5-kernel /root/kernel/lib initramfs/lib

RUN (cd root; \
    find . -print0 | \
    cpio --null --create --verbose --format=newc | \
    gzip --best) \
    > initramfs.cpio.gz
