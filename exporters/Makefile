PWD                   = $(shell pwd)
NODE_EXPORTER_VERSION = 1.11.1
KUBE_STATE_METRICS    = 2.8.11
RELEASE_CHANNEL = "stable"



.PHONY: build
build: kube-state-metrics prometheus-node-exporter

.PHONY: template
template:
	@mkdir -p vanillas
	helm template ${CHART} ${RELEASE_CHANNEL}/${CHART} --version=${VERSION} > vanillas/${CHART}.yaml
	helm template ${CHART} ${RELEASE_CHANNEL}/${CHART} --version=${VERSION} --output-dir .

.PHONY: kube-state-metrics
kube-state-metrics: docker-gen-kube-state-metrics

.PHONY: gen-kube-state-metrics
gen-kube-state-metrics: kube-state-metrics-template kube-state-metrics/kustomization.yaml

.PHONY: kube-state-metrics-template
kube-state-metrics-template:
	make template CHART=kube-state-metrics VERSION=${KUBE_STATE_METRICS}

.PHONY: prometheus-node-exporter
prometheus-node-exporter: docker-gen-prometheus-node-exporter

.PHONY: gen-prometheus-node-exporter
gen-prometheus-node-exporter: prometheus-node-exporter-template prometheus-node-exporter/kustomization.yaml

.PHONY: prometheus-node-exporter-template
prometheus-node-exporter-template:
	make template CHART=prometheus-node-exporter VERSION=${NODE_EXPORTER_VERSION}

.SECONDEXPANSION:
%/kustomization.yaml: $$(wildcard $$*/templates/*.yaml)
	@echo $^
	./kustomization.yaml.sh $(shell cd $* && ls templates/*) > $@

.dockerimage: Dockerfile
	docker build -t manifests-builder .
	touch .dockerimage

.PHONY: docker-%
docker-%: .dockerimage
	docker \
      run \
      --rm \
      -it \
      -v ${PWD}/:/workdir \
      manifests-builder \
	  make $*
