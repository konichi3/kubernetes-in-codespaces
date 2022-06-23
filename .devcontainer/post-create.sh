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
helm install e4k oci://edgecharts.azurecr.io/helm/az-e4k --set-file e4kspiffe.identitymanager.configToml=’/workspaces/kubernetes-in-codespaces/.devcontainer/override-identities.toml’ --set-string e4kmqtt.authenticator.type=”null”
kubectl apply –f /workspaces/kubernetes-in-codespaces/.devcontainer/mqttclient.yaml
