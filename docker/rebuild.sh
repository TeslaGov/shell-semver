#!/usr/bin/env bash

function rebuildDockerImage() {
    # Should be a full path to a dir with a Dockerfile
    context=$1

    # Just the name of the aforementioned directory
    project_name=$2

    # e.g., v0.0.1
    version=$3

    docker build --build-arg API_VERSION=$version -t teslagov/$project_name:$version $context --no-cache
}
