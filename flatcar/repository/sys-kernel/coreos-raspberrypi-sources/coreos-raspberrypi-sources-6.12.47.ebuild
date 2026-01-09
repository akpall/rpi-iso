# Copyright 2014 CoreOS, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

ETYPE="sources"
EXTRAVERSION="raspberrypi"
K_GENPATCHES_VER="0"
K_SECURITY_UNSUPPORTED="1"

inherit kernel-2

RASPBERRYPI_KERNEL_TAG="stable_20250916"

DESCRIPTION="Raspberry Pi kernel sources"
HOMEPAGE="https://github.com/raspberrypi/linux"
SRC_URI="https://github.com/raspberrypi/linux/archive/refs/tags/${RASPBERRYPI_KERNEL_TAG}.tar.gz"
S="${WORKDIR}/linux-${PVR}-raspberrypi"
KEYWORDS="amd64 arm64"
PATCH_DIR="${FILESDIR}/${KV_MAJOR}.${KV_PATCH}"

# make modules_prepare depends on pahole
RDEPEND="dev-util/pahole"

# XXX: Note we must prefix the patch filenames with "z" to ensure they are
# applied _after_ a potential patch-${KV}.patch file, present when building a
# patchlevel revision.  We mustn't apply our patches first, it fails when the
# local patches overlap with the upstream patch.
UNIPATCH_LIST="
	${PATCH_DIR}/z0001-kbuild-derive-relative-path-for-srctree-from-CURDIR.patch \
	${PATCH_DIR}/z0002-pahole-support-reproducible-builds.patch \
	${PATCH_DIR}/z0003-Revert-x86-boot-Remove-the-bugger-off-message.patch \
	${PATCH_DIR}/z0004-efi-add-an-efi_secure_boot-flag-to-indicate-secure-b.patch \
	${PATCH_DIR}/z0005-efi-lock-down-the-kernel-if-booted-in-secure-boot-mo.patch \
	${PATCH_DIR}/z0006-mtd-disable-slram-and-phram-when-locked-down.patch \
	${PATCH_DIR}/z0007-arm64-add-kernel-config-option-to-lock-down-when.patch \
	${PATCH_DIR}/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch \
"

universal_unpack() {
	unpack ${RASPBERRYPI_KERNEL_TAG}.tar.gz

	# We want to rename the unpacked directory to a nice normalised string
	# bug #762766
	mv "${WORKDIR}/linux-${RASPBERRYPI_KERNEL_TAG}" "${WORKDIR}/linux-${PVR}-raspberrypi" || die

	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2>/dev/null
}
