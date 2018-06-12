#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/get-environment.sh

ui_project_name=${root_project_name}-ui
ui_docker_context=$repo_dir/ui

printf "$yellow" "❤ Building Docker image for $ui_project_name..."
rm -rf $ui_docker_context/dist-development-container
npm --prefix $ui_docker_context install
npm --prefix $ui_docker_context run build-development-container

source $SCRIPT_DIR/rebuild.sh

rebuild_docker_image $ui_docker_context $ui_project_name $version
