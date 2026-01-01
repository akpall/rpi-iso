FROM gentoo/portage:latest AS portage
FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN gemato update

RUN FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox" \
      emerge \
        --jobs=$(nproc) \
        --load-average=$((1+$(nproc))) \
        --getbinpkg=y \
        app-eselect/eselect-repository
