FROM rpi5-crossdev

WORKDIR /root/

RUN \
    mkdir root; \
    mkdir root/bin; \
    mkdir root/dev; \
    mkdir root/etc; \
    mkdir root/lib; \
    mkdir root/lib64;\
    mkdir root/mnt; \
    mkdir root/mnt/root; \
    mkdir root/proc; \
    mkdir root/root; \
    mkdir root/sbin; \
    mkdir root/sys

RUN FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox" emerge-aarch64-linux-gnu --oneshot --root=root busybox
