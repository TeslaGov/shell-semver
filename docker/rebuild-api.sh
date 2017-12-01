#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/get-environment.sh

printf "$yellow" "❤ Rebuilding fat jar..."
$repo_dir/gradlew -p $repo_dir clean build

printf "$yellow" "❤ Building Docker image for $api_project_name..."
docker build --build-arg API_VERSION=$version -t teslagov/$api_project_name:$version $api_docker_context --no-cache