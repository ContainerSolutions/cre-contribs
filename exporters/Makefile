PWD                           = $(shell pwd)
NODE_EXPORTER_VERSION         = 1.11.1
KUBE_STATE_METRICS_VERSION    = 2.8.11
MONGODB_EXPORTER_VERSION      = 2.7.0
MONGODB_EXPORTER_VALUES       = "--set mongodb.uri=example"
RELEASE_CHANNEL               = "stable"

.PHONY: build
build: kube-state-metrics-docker prometheus-node-exporter-docker prometheus-mongodb-exporter-docker

.PHONY: template
template:
	helm template ${VALUES} ${CHART} ${RELEASE_CHANNEL}/${CHART} --version=${VERSION} --output-dir .
	helm template ${VALUES} ${CHART} ${RELEASE_CHANNEL}/${CHART} --version=${VERSION} > ${CHART}/vanilla-${VERSION}.yaml

kube-state-metrics/vanilla-%.yaml:
	make template CHART=kube-state-metrics VERSION=${KUBE_STATE_METRICS_VERSION}

prometheus-node-exporter/vanilla-%.yaml:
	make template CHART=prometheus-node-exporter VERSION=${NODE_EXPORTER_VERSION}

prometheus-mongodb-exporter/vanilla-%.yaml:
	make template VALUES=${MONGODB_EXPORTER_VALUES} CHART=prometheus-mongodb-exporter VERSION=${MONGODB_EXPORTER_VERSION}

.PHONY: kube-state-metrics-docker
kube-state-metrics-docker: docker-kube-state-metrics

.PHONY: kube-state-metrics
kube-state-metrics: kube-state-metrics/vanilla-${KUBE_STATE_METRICS_VERSION}.yaml kube-state-metrics/kustomization.yaml

.PHONY: prometheus-node-exporter-docker
prometheus-node-exporter-docker: docker-prometheus-node-exporter

.PHONY: prometheus-node-exporter
prometheus-node-exporter: prometheus-node-exporter/vanilla-${NODE_EXPORTER_VERSION}.yaml prometheus-node-exporter/kustomization.yaml

.PHONY: prometheus-node-exporter-docker
prometheus-mongodb-exporter-docker: docker-prometheus-mongodb-exporter

.PHONY: prometheus-mongodb-exporter
prometheus-mongodb-exporter: prometheus-mongodb-exporter/vanilla-${MONGODB_EXPORTER_VERSION}.yaml prometheus-mongodb-exporter/kustomization.yaml

.SECONDEXPANSION:
%/kustomization.yaml: $$(wildcard $$*/templates/*.yaml)
	./kustomization.yaml.sh $(shell cd $* && ls templates/*.yaml) > $@

.dockerimage: Dockerfile
	docker build -t manifests-builder .
	touch .dockerimage

USER := $(shell id -u)
GROUP := $(shell id -g)
.PHONY: docker-%
docker-%: .dockerimage
	docker \
	  run \
	  --user $(USER):$(GROUP) \
	  --rm \
	  -it \
	  -v ${PWD}/:/workdir:rw \
	  manifests-builder \
	  make $*
