FROM gentoo/portage:latest AS portage
FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

COPY files/etc/portage/package.use /etc/portage/package.use

RUN getuto

ARG EMERGE_FEATURES
ARG EMERGE_OPTIONS

RUN FEATURES="${EMERGE_FEATURES}" \
    emerge \
      ${EMERGE_OPTIONS} \
      app-eselect/eselect-repository

RUN eselect repository add akpall git https://github.com/akpall/gentoo-akpall

CMD ["bash", "-c", "emaint sync --repo akpall && bash"]
