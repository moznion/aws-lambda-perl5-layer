.PHONY: build

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build:
ifndef PERL_VERSION
	@echo '[ERROR] $$PERL_VERSION must be specified'
	@echo 'make build PERL_VERSION=x.x.x'
	exit 255
endif
	docker run -e PERL_VERSION=$(PERL_VERSION) --rm -v $(ROOT_DIR):/tmp/layer lambci/lambda:build-nodejs8.10 /tmp/layer/scripts/build.sh

