clean:
	rm -r root
.PHONY: clean

root:
	mkdir --parents root/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
	sudo cp --archive /dev/{null,console,tty} root/dev/
