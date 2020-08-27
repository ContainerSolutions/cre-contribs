FROM alpine/helm:3.3.0-rc.1 AS builder
FROM alpine:3.12.0 AS runtime

ENV HELM_CHART=https://kubernetes-charts.storage.googleapis.com
ENV XDG_CACHE_HOME=/etc
ENV XDG_CONFIG_HOME=/etc
ENV XDG_DATA_HOME=/etc

COPY --from=builder /usr/bin/helm /usr/local/bin
RUN helm repo add stable ${HELM_CHART} && helm repo update && apk add --update bash make && chmod a+rw -R /etc/helm

WORKDIR /workdir
