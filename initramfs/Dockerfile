FROM rpi5-kernel AS rpi5-kernel

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
    initramfs/lib64\
    initramfs/mnt/root \
    initramfs/proc \
    initramfs/root \
    initramfs/sbin \
    initramfs/sys

RUN cp -r /root/kernel/lib/ initramfs/

RUN emerge-aarch64-linux-gnu ${EMERGE_OPTIONS} \
    net-misc/curl \
    sys-apps/busybox \
    sys-apps/kexec-tools \
    sys-libs/glibc

COPY init initramfs
RUN chmod +x initramfs/init

RUN (cd initramfs; \
    find . -print0 | \
    cpio --null --create --verbose --format=newc | \
    gzip --best) \
    > initramfs.cpio.gz
