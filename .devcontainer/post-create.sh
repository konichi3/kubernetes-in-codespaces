#!/bin/bash

# this runs at Codespace creation - not part of pre-build

echo "post-create start"
echo "$(date)    post-create start" >> "$HOME/status"

# update the repos
git -C /workspaces/imdb-app pull
git -C /workspaces/webvalidate pull

echo "post-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    post-create complete" >> "$HOME/status"

# install E4K componentns as part of Codespace creation
helm install e4k oci://edgecharts.azurecr.io/helm/az-e4k -n e4k --create-namespace
kubectl apply -f /workspaces/kubernetes-in-codespaces/.devcontainer/mqttclient.yaml

# install E4K CLI
OS='linux'; ARCH='amd64'; curl -sSL -o kubectl-aziot_e4k-linux-amd64.tar.gz https://github.com/Azure/e4k-cli/releases/tag/v0.0.1/kubectl-aziot_e4k-$OS-$ARCH.tar.gz
tar -xzf kubectl-aziot_e4k-linux-amd64.tar.gz
cp kubectl-aziot_e4k /usr/local/bin
