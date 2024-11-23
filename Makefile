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
