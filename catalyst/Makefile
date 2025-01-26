catalyst:
	docker build --pull --tag catalyst-akpall .

spec-files:
	wget https://gitweb.gentoo.org/proj/releng.git/plain/releases/specs/arm64/stage1-openrc-23.spec -O files/stage1-openrc-23.spec
	wget https://gitweb.gentoo.org/proj/releng.git/plain/releases/specs/arm64/stage3-openrc-23.spec -O files/stage3-openrc-23.spec
.PHONY: spec-files

releng:
	git clone https://anongit.gentoo.org/git/proj/releng.git files/releng
.PHONY: releng
