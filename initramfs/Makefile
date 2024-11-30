initramfs: root packages root/init initramfs.cpio.gz
.PHONY: initramfs


initramfs.cpio.gz: root/init
	sudo sh -c '\
	(cd root && \
	find . -print0 | \
	cpio --null --create --verbose --format=newc | \
	gzip --best) > initramfs.cpio.gz'


clean:
	-sudo rm -r root
	-rm initramfs.cpio.gz
.PHONY: clean


packages: root
	sudo ${EMERGE} busybox musl curl
.PHONY: packages


root/init: init root
	sudo sh -c '\
	cp init root && \
	chmod +x root/init'


root:
	sudo sh -c '\
	mkdir root && \
	mkdir root/bin && \
	mkdir root/dev && \
	mkdir root/etc && \
	mkdir root/lib && \
	mkdir root/lib64 &&\
	mkdir root/mnt && \
	mkdir root/mnt/root && \
	mkdir root/proc && \
	mkdir root/root && \
	mkdir root/sbin && \
	mkdir root/sys'
