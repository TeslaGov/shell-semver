#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/get-environment.sh

api_project_name=${root_project_name}-api
api_docker_context=$repo_dir/api

printf "$yellow" "❤ Rebuilding fat jar..."
$repo_dir/gradlew -p $repo_dir clean build

printf "$yellow" "❤ Building Docker image for $api_project_name..."

source $SCRIPT_DIR/rebuild.sh

rebuildDockerImage $api_docker_context $api_project_name $version "true"
