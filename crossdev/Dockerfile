FROM gentoo/portage:latest AS portage
FROM gentoo/stage3 AS stage3

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN getuto
RUN FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox" emerge --jobs=$(nproc) --load-average=$((1+$(nproc))) --getbinpkg app-eselect/eselect-repository sys-devel/crossdev

RUN eselect repository enable crossdev

RUN crossdev -t aarch64-linux-gnu
