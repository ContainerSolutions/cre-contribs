# cre-contribs
Repository for gathering various contributions/docs/snippets used by CRE

### Exporters

The exporter directory includes the necesary tooling to generate a basic kustomize template and vanilla kubernetes manifests for exporters. The exporters suported at the moment are:

- prometheus-node-exporter
- kube-state-metrics

To build both exporters with the pinned versions run the following command

```bash
make
```
