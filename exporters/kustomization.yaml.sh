#!/bin/bash

cat <<HERE
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
HERE

for file in "$@"; do
	echo "- ${file}"
done
