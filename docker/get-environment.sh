#!/usr/bin/env bash

# This bash script sets some useful variables:

# 1) environment: whether we are pushing to our 'local' registry, or to another kube context.

# 2) repo_dir:              the path of the Git repo for which we are building Docker images.
#                           e.g., /Users/kevinchen/dev/teslagov/clarakm/clarakm-chat

# 3) root_project_name:     the basename of repo_dir
#                           e.g., clarakm-chat

# 4) version:               the version of the service, pulled from the latest Git tag

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/../colors.sh

function echoUsage() {
    echo ""
    echo "usage: ./rebuild-image.sh <repo_dir> [local|minikube]"
    echo ""
    echo "For instance,"
    echo ""
    echo "./rebuild-image.sh ~/dev/teslagov/clarakm/clarakm-chat minikube"
    echo ""
    echo "(Case matters. 'minikube' is a valid argument. 'MINIKUBE' is not.)"
}

function assertIsGitRepo() {
    if [ ! -d "$1" ];
    then
        printf "$red" "✗ $1 is not a directory"
        exit 1
    fi

    if [ ! -d "$1/.git" ];
    then
        printf "$red" "✗ $1 is not a Git repo"
        exit 1
    fi
}

function setKubeContext() {
    # Sets the kube context if minikube is specified as the environment
    if [ "$environment" = "minikube" ]; then
        kube_context=minikube
        printf "$yellow" "❤ Setting kube context to $kube_context..."
        kubectl config use-context ${kube_context}

        printf "$yellow" "❤ Setting the following environment variables..."
        printf "$blue" "$(minikube docker-env)"
        eval $(minikube docker-env)
    else
        printf "$yellow" "✓ Publishing Docker image to localhost..."
    fi
}

function fetchTags() {
    printf "$yellow" "❤ Fetching latest tags for $1..."
    git -C "$1" fetch --tags
}

function getLatestTag() {
    echo -n $(git -C "$1" tag --sort=v:refname | tail -n 1)
}

environment=local

if [ $# -gt 3 ] || [ $# -lt 1 ] ; then
    echoUsage
    exit 1
fi

repo_dir=$(realpath "$1")
assertIsGitRepo "$repo_dir"

if [ $# == 2 ]; then
    # Ensure the selected environment is valid.
    case "$2" in
        minikube|local) environment=$2;;
        *) echoUsage; exit 1;;
    esac
fi

fetchTags "$repo_dir"
setKubeContext

root_project_name=$(basename $repo_dir)
version=$(getLatestTag "$repo_dir")

if [ -z "$version" ]
then
    printf "$yellow" "❤ No tag found... Setting default tag of v0.0.1"
    version=v0.0.1
fi

#printf "$magenta" "$repo_dir"
#printf "$magenta" "$root_project_name"
#printf "$magenta" "$version"
