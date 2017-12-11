#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/get-environment.sh

source $SCRIPT_DIR/rebuild-api.sh
source $SCRIPT_DIR/rebuild-ui.sh

printf "$green" "❤ Build complete..."
