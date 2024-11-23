crossdev: /usr/aarch64-akpall-linux-musl/ /usr/aarch64-akpall-linux-musl/etc/portage/package.use
.PHONY: crossdev


/usr/aarch64-akpall-linux-musl/:
	sudo sh -c '\
	crossdev -t aarch64-akpall-linux-musl --init-target && \
	PORTAGE_CONFIGROOT=/usr/aarch64-akpall-linux-musl/ eselect profile set default/linux/arm64/23.0/musl'


/usr/aarch64-akpall-linux-musl/etc/portage/package.use: package.use
	sudo sh -c '\
	cp package.use /usr/aarch64-akpall-linux-musl/etc/portage/ && \
	crossdev -t aarch64-akpall-linux-musl -s4'


clean:
	-sudo crossdev --clean -t aarch64-akpall-linux-musl
.PHONY: clean
