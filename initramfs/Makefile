.DEFAULT_GOAL := build

_initramfs: _packages root/init initramfs.cpio.gz
.PHONY: _initramfs

_packages:
	sudo emerge-aarch64-akpall-linux-musl --root=root busybox
	touch _packages

build: root _initramfs
.PHONY: build

clean:
	-sudo rm -r root initramfs.cpio.gz _packages
.PHONY: clean

initramfs.cpio.gz: root/init
	(cd root && \
		find . -print0 | \
		cpio --null --create --verbose --format=newc | \
		gzip --best) > initramfs.cpio.gz

root/init: init
	cp init root
	chmod +x root/init

root:
	mkdir --parents root/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
	sudo cp --archive /dev/{null,console,tty} root/dev/
