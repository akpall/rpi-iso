BOARD := arm64-usr

all: scripts .build_packages .build_image .image_to_vm flatcar_production_pxe_image.cpio.gz flatcar_production_pxe.vmlinuz

.build_image: .build_packages
	@ \
	cd scripts; \
	./run_sdk_container ./build_image --board=${BOARD}
.PHONY: .build_image

.build_packages: scripts
	@ \
	cd scripts; \
	./run_sdk_container ./build_packages --board=${BOARD}
.PHONY: .build_packages

.image_to_vm: .build_image
	@ \
	cd scripts; \
	./run_sdk_container ./image_to_vm.sh --from=../build/images/${BOARD}/latest/ --format=pxe --board=${BOARD}
.PHONY: .image_to_vm

clean:
	( \
	rm -rf scripts; \
	rm .scripts; \
	rm .build_packages; \
	rm .build_image; \
	rm .image_to_vm; \
	rm flatcar_production_pxe_image.cpio.gz; \
	) >/dev/null 2>&1 || true
.PHONY: clean

flatcar_production_pxe_image.cpio.gz: .image_to_vm
	cp scripts/__build__/images/images/${BOARD}/latest/flatcar_production_pxe_image.cpio.gz .

flatcar_production_pxe.vmlinuz: .image_to_vm
	cp scripts/__build__/images/images/${BOARD}/latest/flatcar_production_pxe.vmlinuz .

scripts:
	@ \
	[[ ! -d scripts ]] && git clone https://github.com/flatcar/scripts.git; \
	cd scripts; \
	git fetch; \
	branch="$$(git branch -r -l | awk -F'/' '/origin\/flatcar-[0-9]+$$/ {print $$2}' | sort | tail -n1)"; \
	git checkout "$$branch"; \
	git merge --ff-only
.PHONY: scripts
