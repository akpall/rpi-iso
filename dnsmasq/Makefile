INTERFACE ?=
export INTERFACE

default: cleanup

prepare:
	@ \
	if [[ -z $${INTERFACE} ]]; then \
	  echo "Please select an interface by appending INTERFACE={INTERFACE_NAME} to the make command"; \
	  exit 1; \
	fi

	@ \
	ip link show $(INTERFACE) >/dev/null

	if ! ip -brief addr show dev $(INTERFACE) | grep 192.168.0.1/24; then \
	  sudo ip addr add 192.168.0.1/24 dev $(INTERFACE); \
	  sudo ip link set $(INTERFACE) up; \
	fi

	sed 's/$${INTERFACE}/$(INTERFACE)/g' dnsmasq.conf.template > dnsmasq.conf

dnsmasq: prepare
	docker run -it --rm \
	  --name dnsmasq \
	  --network host \
	  -v ./dnsmasq.conf:/etc/dnsmasq.conf \
	  -v ./mnt:/mnt \
	  --cap-add=NET_ADMIN \
	  docker.io/dockurr/dnsmasq

cleanup:
	@ \
	if [[ -z $${INTERFACE} ]]; then \
	  echo "Please select an interface by appending INTERFACE={INTERFACE_NAME} to the make command"; \
	  exit 1; \
	fi

	@ ip link show $(INTERFACE) >/dev/null

	@ sudo ip addr del 192.168.0.1/24 dev $(INTERFACE) 2>/dev/null || true; \

	@ sudo ip link set $(INTERFACE) down
