#!/usr/bin/env bash

function rebuildDockerImage() {
    # Should be a full path to a dir with a Dockerfile
    context=$1

    # Just the name of the aforementioned directory
    project_name=$2

    # e.g., v0.0.1
    version=$3

    if [ -z "$4" ]
    then
        docker build -t teslagov/$project_name:$version $context --no-cache 
    else
        docker build --build-arg API_VERSION=$version -t teslagov/$project_name:$version $context --no-cache
    fi
}

