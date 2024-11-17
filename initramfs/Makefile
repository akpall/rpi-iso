.DEFAULT_GOAL := build

build: root _crossdev
.PHONY: build

/usr/aarch64-akpall-linux-musl/etc/portage/package.use: package.use
	sudo cp package.use /usr/aarch64-akpall-linux-musl/etc/portage/

/usr/bin/emerge-aarch64-akpall-linux-musl:
	sudo crossdev -t aarch64-akpall-linux-musl
	sudo PORTAGE_CONFIGROOT=/usr/aarch64-akpall-linux-musl/ eselect profile set default/linux/arm64/23.0/musl

_crossdev: /usr/bin/emerge-aarch64-akpall-linux-musl /usr/aarch64-akpall-linux-musl/etc/portage/package.use
.PHONY: _crossdev

clean:
	rm -r root
.PHONY: clean

root:
	mkdir --parents root/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
	sudo cp --archive /dev/{null,console,tty} root/dev/
