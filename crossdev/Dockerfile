FROM gentoo/portage:latest AS portage
FROM gentoo/stage3 AS stage3

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

ARG EMERGE_FEATURES
ARG EMERGE_OPTIONS

RUN getuto

RUN FEATURES="${EMERGE_FEATURES}" emerge ${EMERGE_OPTIONS} \
    app-arch/cpio \
    app-eselect/eselect-repository \
    sys-devel/crossdev

RUN eselect repository enable crossdev

RUN crossdev -t aarch64-linux-gnu
