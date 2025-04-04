all: flatcar initramfs kernel

flatcar:
	$(MAKE) -C flatcar
.PHONY: flatcar

initramfs: kernel
	$(MAKE) -C initramfs
.PHONY: initramfs

kernel: crossdev
	$(MAKE) -C kernel
.PHONY: kernel

crossdev:
	$(MAKE) -C crossdev
.PHONY: crossdev

clean: crossdev-clean initramfs-clean kernel-clean
.PHONY: clean

crossdev-clean:
	$(MAKE) -C crossdev clean
.PHONY: crossdev-clean

initramfs-clean:
	$(MAKE) -C initramfs clean
.PHONY: initramfs-clean

kernel-clean:
	$(MAKE) -C kernel clean
.PHONY: kernel-clean
