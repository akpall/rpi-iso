.DEFAULT_GOAL := build

/usr/aarch64-akpall-linux-musl/etc/portage/package.use: package.use
	sudo cp package.use /usr/aarch64-akpall-linux-musl/etc/portage/

/usr/bin/emerge-aarch64-akpall-linux-musl:
	sudo crossdev -t aarch64-akpall-linux-musl
	sudo PORTAGE_CONFIGROOT=/usr/aarch64-akpall-linux-musl/ eselect profile set default/linux/arm64/23.0/musl

_crossdev: /usr/bin/emerge-aarch64-akpall-linux-musl /usr/aarch64-akpall-linux-musl/etc/portage/package.use
.PHONY: _crossdev

_initramfs: _packages root/init initramfs.cpio.gz

_packages:
	sudo emerge-aarch64-akpall-linux-musl --root=root busybox
	touch _packages

build: root _crossdev _initramfs
.PHONY: build

clean:
	-sudo rm -r root initramfs.cpio.gz _packages
	-sudo crossdev --clean -t aarch64-akpall-linux-musl
.PHONY: clean

initramfs.cpio.gz:
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
