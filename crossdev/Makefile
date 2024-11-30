crossdev: /usr/aarch64-akpall-linux-musl/ /usr/aarch64-akpall-linux-musl/etc/portage/package.use
.PHONY: crossdev


/usr/aarch64-akpall-linux-musl/:
	sudo sh -c '\
	${CROSSDEV} --init-target && \
	PORTAGE_CONFIGROOT=/usr/aarch64-akpall-linux-musl/ eselect profile set default/linux/arm64/23.0/split-usr/musl'


/usr/aarch64-akpall-linux-musl/etc/portage/package.use: package.use
	sudo sh -c '\
	cp package.use /usr/aarch64-akpall-linux-musl/etc/portage/ && \
	${CROSSDEV} -s4'


clean:
	-sudo crossdev --clean -t ${TUPLE}
.PHONY: clean
