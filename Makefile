.PHONY: build
build:
	make -C ./exporters

DIRS := $(shell find exporters/  -maxdepth 1 -mindepth 1 -type d)

.PHONY: clean
clean:
	for dir in $(DIRS); do \
		rm -rf $$dir/*; \
	done
	rm -f exporters/.dockerimage

