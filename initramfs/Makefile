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
	sudo emerge-aarch64-akpall-linux-musl --oneshot --root=root busybox


root/init: init
	cp init root
	chmod +x root/init


root:
	mkdir root
	mkdir root/bin
	mkdir root/dev
	mkdir root/etc
	mkdir root/lib
	mkdir root/lib64
	mkdir root/mnt/root
	mkdir root/proc
	mkdir root/root
	mkdir root/sbin
	mkdir root/sys
