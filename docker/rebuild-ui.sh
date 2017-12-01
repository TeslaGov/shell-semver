#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/get-environment.sh

printf "$yellow" "❤ Building Docker image for $ui_project_name..."
rm -rf $ui_docker_context/dist-production
npm --prefix $ui_docker_context run build-development-container
docker build -t teslagov/$ui_project_name:$version $ui_docker_context --no-cache