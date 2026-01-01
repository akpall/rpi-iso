FROM gentoo/portage:latest AS portage
FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

ENV FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox"

RUN getuto

RUN emerge \
      --jobs=$(nproc) \
      --load-average=$((1+$(nproc))) \
      --getbinpkg=y \
      app-eselect/eselect-repository

RUN eselect repository add akpall git https://github.com/akpall/gentoo-akpall

# raspberrypi-sources::akpall dependencies
RUN emerge \
      --jobs=$(nproc) \
      --load-average=$((1+$(nproc))) \
      --getbinpkg=y \
      dev-libs/elfutils \
      virtual/libelf \
      app-arch/cpio \
      app-alternatives/cpio

CMD ["bash", "-c", "emaint sync --repo akpall && bash"]
