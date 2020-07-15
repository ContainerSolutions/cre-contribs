PWD = $(shell pwd)

.PHONY: build
build: kube-state-metrics prometheus-node-exporter

.PHONY: kube-state-metrics
kube-state-metrics: docker-kustomize-kube-state-metrics docker-vanilla-kube-state-metrics

.PHONY: kustomize-kube-state-metrics
kustomize-kube-state-metrics: kube-state-metrics-template kube-state-metrics-kustomization.yaml

.PHONY: kube-state-metrics-template
kube-state-metrics-template:
	helm template kube-state-metrics stable/kube-state-metrics --output-dir .

.PHONY: vanilla-kube-state-metrics
vanilla-kube-state-metrics:
	@mkdir -p vanillas
	helm template kube-state-metrics stable/kube-state-metrics > vanillas/vanilla-kube-state-metrics.yaml

.PHONY: prometheus-node-exporter
prometheus-node-exporter: docker-kustomize-prometheus-node-exporter docker-vanilla-prometheus-node-exporter

.PHONY: kustomize-prometheus-node-exporter
kustomize-prometheus-node-exporter: prometheus-node-exporter-template prometheus-node-exporter-kustomization.yaml

.PHONY: prometheus-node-exporter-template
prometheus-node-exporter-template:
	helm template prometheus-node-exporter stable/prometheus-node-exporter --output-dir .

.PHONY: vanilla-prometheus-node-exporter
vanilla-prometheus-node-exporter:
	@mkdir -p vanillas
	helm template prometheus-node-exporter stable/prometheus-node-exporter > vanillas/vanilla-prometheus-node-exporter.yaml

.SECONDEXPANSION:
%-kustomization.yaml: $$(wildcard $$*/templates/*.yaml)
	@echo "kustomization $^"
	cd $* && ../kustomization.yaml.sh $$(ls templates/*) > kustomization.yaml

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
