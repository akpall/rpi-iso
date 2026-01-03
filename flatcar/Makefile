flatcar:
	if [ ! -d scripts ]; then \
	  git clone https://github.com/flatcar/scripts.git; \
	fi
	cd scripts; \
	branch="$$(git branch -r -l | awk -F'/' '/origin\/flatcar-[0-9]+$$/ {print $$2}' | sort | tail -n1)"; \
	git checkout "$$branch"

flatcar-run:
	cd scripts && \
	./run_sdk_container -t
