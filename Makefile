TUPLE := aarch64-akpall-linux-musl
EMERGE_OPTIONS := --oneshot --root=root --buildpkg --usepkg
export CROSSDEV := crossdev -t ${TUPLE}
export EMERGE := emerge-${TUPLE} ${EMERGE_OPTIONS}


all: crossdev initramfs kernel
.PHONY: all


clean:
	$(MAKE) -C crossdev clean
	$(MAKE) -C initramfs clean
	$(MAKE) -C kernel clean
.PHONY: clean


crossdev:
	$(MAKE) -C crossdev
.PHONY: crossdev


initramfs:
	$(MAKE) -C initramfs
.PHONY: initramfs


kernel:
	$(MAKE) -C kernel
.PHONY: kernel
