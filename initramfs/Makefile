initramfs: root root/bin/busybox root/init ../initramfs.cpio.gz
.PHONY: initramfs


../initramfs.cpio.gz: root/init
	(cd root && \
		find . -print0 | \
		cpio --null --create --verbose --format=newc | \
		gzip --best) > ../initramfs.cpio.gz


clean:
	-sudo rm -r root ../initramfs.cpio.gz
.PHONY: clean


root/bin/busybox:
	sudo emerge-aarch64-akpall-linux-musl --root=root busybox


root/init: init
	cp init root
	chmod +x root/init


root:
	mkdir --parents root/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
	sudo cp --archive /dev/{null,console,tty} root/dev/
