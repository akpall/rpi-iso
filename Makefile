all: crossdev
.PHONY: all


clean:
	$(MAKE) -C crossdev clean
.PHONY: clean


crossdev:
	$(MAKE) -C crossdev
.PHONY: crossdev
