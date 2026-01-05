flatcar:
	if [ ! -d scripts ]; then \
	  git clone https://github.com/flatcar/scripts.git; \
	fi
	cd scripts; \
	branch="$$(git tag | grep '^stable-[0-9.]*$$' | sort | tail -n1)"; \
	git checkout "$$branch"

flatcar-run:
	cd scripts && \
	./run_sdk_container -t

flatcar-update:
	cd scripts && \
	git pull . && \
	branch="$$(git tag | grep '^stable-[0-9.]*$$' | sort | tail -n1)"; \
	git checkout "$$branch"

clean:
	rm -rf scripts
