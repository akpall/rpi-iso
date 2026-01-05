EMERGE_OPTIONS := "--jobs=$$(nproc) --load-average=$$((1+$$(nproc)))"
EMERGE_FEATURES := "-ipc-sandbox -network-sandbox -pid-sandbox"

build:
	docker build \
	  --build-arg EMERGE_FEATURES=${EMERGE_FEATURES} \
	  --build-arg EMERGE_OPTIONS=${EMERGE_OPTIONS} \
	  --platform linux/arm64 \
	  --tag kernel-test \
	  .
