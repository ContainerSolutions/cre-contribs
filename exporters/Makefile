PWD = $(shell pwd)

.PHONY: kube-state-metrics
kube-state-metrics: docker-gen-kube-state-metrics docker-gen-vanilla-kube-state-metrics

.PHONY: gen-kube-state-metrics
gen-kube-state-metrics: kube-state-metrics-template kube-state-metrics-kustomization.yaml

.PHONY: kube-state-metrics-template
kube-state-metrics-template:
	helm template kube-state-metrics stable/kube-state-metrics --output-dir .

.PHONY: gen-vanilla-kube-state-metrics
gen-vanilla-kube-state-metrics:
	@mkdir -p vanillas
	helm template kube-state-metrics stable/kube-state-metrics > vanillas/vanilla-kube-state-metrics.yaml

.PHONY: prometheus-node-exporter
prometheus-node-exporter: docker-gen-prometheus-node-exporter docker-gen-vanilla-prometheus-node-exporter

.PHONY: gen-prometheus-node-exporter
gen-prometheus-node-exporter: prometheus-node-exporter-template prometheus-node-exporter-kustomization.yaml

.PHONY: prometheus-node-exporter-template
prometheus-node-exporter-template:
	helm template prometheus-node-exporter stable/prometheus-node-exporter --output-dir .

.PHONY: gen-vanilla-prometheus-node-exporter
gen-vanilla-prometheus-node-exporter:
	@mkdir -p vanillas
	helm template prometheus-node-exporter stable/prometheus-node-exporter > vanillas/vanilla-prometheus-node-exporter.yaml

.SECONDEXPANSION:
%-kustomization.yaml: $$(wildcard $$*/templates/*.yaml)
	@echo "kustomization $^"
	cd $* && ../kustomization.yaml.sh $$(ls templates/*) > kustomization.yaml

.PHONY: build
build: .dockerimage

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
