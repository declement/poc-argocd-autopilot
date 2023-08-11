#! /usr/bin/env bash

set -e

# fine grained access token (for more security) scoped only to the $GIT_REPO
# rights given:
#   Contents: read and write
export GIT_TOKEN="<redacted>"

# name of the repository to create or push to
export GIT_REPO=https://github.com/declement/poc-argocd-autopilot.git

# boostraping repositoy
# steps:
#   1. install ArgoCD in the CURRENT k8s context
#   2. push installation manifests to the repo
#   3. create the autopilot-bootstrap argo app that terminates the boostrap
argocd-autopilot repo bootstrap

# create system project as in the current GKE starter
argocd-autopilot project create system

# create an app in the system project
argocd-autopilot application create hello-world \
    --app github.com/argoproj-labs/argocd-autopilot/examples/demo-app/ \
    --project system

# argocd-autopilot directly push stuff to the remote
# pull to retrieve what has been added
git pull
