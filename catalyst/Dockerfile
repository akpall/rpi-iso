# syntax=docker/dockerfile:1

FROM gentoo/portage:latest AS portage
FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

ADD files/package.accept_keywords/catalyst-akpall /etc/portage/package.accept_keywords/
ADD files/package.use/catalyst-akpall /etc/portage/package.use/
ADD files/stage1-openrc-23.spec /
ADD files/stage3-openrc-23.spec /
ADD files/releng /var/tmp/catalyst/releng

RUN mkdir -p /var/tmp/catalyst/builds/23.0-default
RUN mkdir -p /var/tmp/catalyst/snapshots

RUN getuto

RUN emerge --getbinpkg --jobs=$(nproc) --load-average=$((1+$(nproc))) dev-util/catalyst

RUN wget https://distfiles.gentoo.org/releases/arm64/autobuilds/current-stage3-arm64-openrc/latest-stage3-arm64-openrc.txt

RUN STAGE3_DATE=$(awk /stage3/'{print $1}' latest-stage3-arm64-openrc.txt)
RUN wget "https://distfiles.gentoo.org/releases/arm64/autobuilds/current-stage3-arm64-openrc/${STAGE3_DATE}" -O /var/tmp/catalyst/builds/default/stage3-arm64-openrc-latest.tar.xz

RUN wget https://distfiles.gentoo.org/snapshots/squashfs/gentoo-current.xz.sqfs -O /var/tmp/catalyst/snapshots/gentoo-current.xz.sqfs

