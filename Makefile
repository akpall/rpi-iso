all: crossdev initramfs
.PHONY: all


clean:
	$(MAKE) -C crossdev clean
	$(MAKE) -C initramfs clean
.PHONY: clean


crossdev:
	$(MAKE) -C crossdev
.PHONY: crossdev


initramfs:
	$(MAKE) -C initramfs
.PHONY: initramfs
