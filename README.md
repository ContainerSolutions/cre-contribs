# cre-contribs
Repository for gathering various contributions/docs/snippets used by CRE

### Exporters

The exporter directory includes the necesary tooling to generate a basic kustomize template and vanilla kubernetes manifests for exporters. The exporters suported at the moment are:

- promehteus-node-exporter
- kube-state-metrics

To build both exporters with the last helm charts version

```bash
make
```

For a fixed helm chart version set enviroment variables

```bash
export NODE_EXPORTER_VERSION=<version>
export KUBE_STATE_METRICS=<version>
```
