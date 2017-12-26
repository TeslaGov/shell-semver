#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $SCRIPT_DIR/colors.sh

usage() {
    echo ""
    echo "usage: ./bump-version-push-tag.sh [major|minor|patch] [pathToGitRepo]"
    echo ""
    echo "For instance,"
    echo ""
    echo "./bump-version-push-tag.sh major"
    echo ""
    echo "(Case matters. 'major' is a valid argument. 'MAJOR' is not.)"
}

ensure_repo_not_dirty() {
    local repo_path
    repo_path=$1
    git_description="$(git -C $repo_path describe --always --tags --dirty)"
    if [[ $git_description =~ ^.*-dirty$ ]] ;
    then
        echo Repo is dirty. Please commit first.
        exit 1
    fi
}

fetch_tags() {
    local repo_path
    repo_path=$1
    git -C $repo_path fetch --tags
}

get_latest_tag() {
    local repo_path default_tag git_tag

    repo_path=$1
    default_tag=$2
    git_tag=$(git -C ${repo_path} tag --sort=v:refname | tail -n 1)

    if [ -z "$default_tag" ]; then
        default_tag=v0.0.1
    fi

    if [ -z "$git_tag" ]; then
        git_tag=$default_tag
    fi

    echo -n $git_tag
}

#get_incremented_tag() {
#}

if [[ $# -lt 1 ]] || [[ $# -gt 2 ]]; then
    usage
    exit 1
fi

case "$1" in
    major) semver_flag=-M
           ;;
    minor) semver_flag=-m
           ;;
    patch) semver_flag=-p
           ;;
    *) usage; exit 1;;
esac

if [ -z "$2" ]; then
    repo_path=$(realpath .)
else
    repo_path=$(realpath "$2")
fi

ensureRepoNotDirty "$repo_path"
fetch_tags "$repo_path"

current_tag=$(get_latest_tag "$repo_path" "v0.0.1")
echo "Latest tag is $current_tag"

new_tag=$($SCRIPT_DIR/semver/increment_version.sh $semver_flag $current_tag)
echo "New tag is $new_tag"

git -C $repo_path tag -a $new_tag -m "$new_tag"
git -C $repo_path push origin $new_tag

echo "Done"
