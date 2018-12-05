.PHONY: build build-docker-image publish-docker-image

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CONTAINER_BASE_DIR := /tmp/layer

build:
ifndef CONTAINER_TAG
	@echo '[ERROR] $$CONTAINER_TAG must be specified'
	@echo 'usage: make build CONTAINER_TAG=x.x'
	exit 255
endif
	docker run --rm \
		-v $(ROOT_DIR):$(CONTAINER_BASE_DIR) \
		-e TAG=$(CONTAINER_TAG) \
		-e BASE_DIR=$(CONTAINER_BASE_DIR) \
		$(DOCKER_HUB_ACCOUNT)lambda-perl-layer-foundation:$(CONTAINER_TAG) \
		$(CONTAINER_BASE_DIR)/scripts/build.sh

build-docker-image:
ifndef PERL_VERSION
	@echo '[ERROR] $$PERL_VERSION must be specified'
	@echo 'usage: make build-docker-image PERL_VERSION=x.x.x CONTAINER_TAG=x.x'
	exit 255
endif
ifndef CONTAINER_TAG
	@echo '[ERROR] $$CONTAINER_TAG must be specified'
	@echo 'usage: make build-docker-image PERL_VERSION=x.x.x CONTAINER_TAG=x.x'
	exit 255
endif
	docker build $(OPT) --rm --build-arg PERL_VERSION=$(PERL_VERSION) -t lambda-perl-layer-foundation:$(CONTAINER_TAG) .

publish-docker-image:
ifndef CONTAINER_TAG
	@echo '[ERROR] $$CONTAINER_TAG must be specified'
	@echo 'usage: make publish-docker-image CONTAINER_TAG=x.x DOCKER_ID_USER=xxx'
	exit 255
endif
ifndef DOCKER_ID_USER
	@echo '[ERROR] $$CONTAINER_TAG must be specified'
	@echo 'usage: make publish-docker-image CONTAINER_TAG=x.x DOCKER_ID_USER=xxx'
	exit 255
endif
	docker login --username $(DOCKER_ID_USER)
	docker tag lambda-perl-layer-foundation:$(CONTAINER_TAG) $(DOCKER_ID_USER)/lambda-perl-layer-foundation:$(CONTAINER_TAG)
	docker push $(DOCKER_ID_USER)/lambda-perl-layer-foundation:$(CONTAINER_TAG)

