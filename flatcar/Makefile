all: .scripts .build_packages .build_image .image_to_vm flatcar_production_iso_image.iso

.scripts:
	@git clone https://github.com/flatcar/scripts.git

	@ \
	cd scripts; \
	branch="$$(git branch -r -l | awk -F'/' '/origin\/flatcar-[0-9]+$$/ {print $$2}' | sort | tail -n1)"; \
	git checkout "$$branch"

	@touch .scripts

.build_packages: .scripts
	@ \
	cd scripts; \
	./run_sdk_container ./build_packages --board=arm64-usr

	@touch .build_packages

.build_image: .build_packages
	@ \
	cd scripts; \
	./run_sdk_container ./build_image --board=arm64-usr

	@touch .build_image

.image_to_vm: .build_image
	@ \
	cd scripts; \
	./run_sdk_container ./image_to_vm.sh --from=../build/images/arm64-usr/latest/ --format=iso --board=arm64-usr

	@touch .image_to_vm

flatcar_production_iso_image.iso: .image_to_vm
	cp scripts/__build__/images/images/arm64-usr/latest/flatcar_production_iso_image.iso .

clean:
	-@ ( \
	rm -rf scripts; \
	rm .scripts; \
	rm .build_packages; \
	rm .build_image; \
	rm .image_to_vm; \
	rm flatcar_production_iso_image.iso; \
	) 2>/dev/null
.PHONY: clean
