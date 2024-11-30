EMERGE_OPTIONS := --oneshot --root=root --buildpkg --usepkg
export TUPLE := aarch64-akpall-linux-musl
export CROSSDEV := crossdev -t ${TUPLE}
export EMERGE := emerge-${TUPLE} ${EMERGE_OPTIONS}


all: crossdev initramfs kernel
.PHONY: all


clean: crossdev-clean initramfs-clean kernel-clean
.PHONY: clean


crossdev-clean:
	$(MAKE) -C crossdev clean
.PHONY: crossdev-clean


crossdev:
	$(MAKE) -C crossdev
.PHONY: crossdev


initramfs-clean:
	$(MAKE) -C initramfs clean
.PHONY: initramfs-clean


initramfs:
	$(MAKE) -C initramfs
.PHONY: initramfs


kernel-clean:
	$(MAKE) -C kernel clean
.PHONY: kernel-clean


kernel:
	$(MAKE) -C kernel
.PHONY: kernel
