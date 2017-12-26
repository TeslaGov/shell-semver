#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $SCRIPT_DIR/colors.sh

function usage() {
    echo ""
    echo "usage: ./bump-version-push-tag.sh [major|minor|patch]"
    echo ""
    echo "For instance,"
    echo ""
    echo "./bump-version-push-tag.sh major"
    echo ""
    echo "(Case matters. 'major' is a valid argument. 'MAJOR' is not.)"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

# Ensure the selected environment is valid.
case "$1" in
    major) semver_flag=-M
           ;;
    minor) semver_flag=-m
           ;;
    patch) semver_flag=-p
           ;;
    *) usage; exit 1;;
esac

GIT_DESC="$(git describe --always --tags --dirty)"
echo "Git describe returns $GIT_DESC"
if [[ $GIT_DESC =~ ^.*-dirty$ ]] ;
then
	echo Repo is dirty. Please commit first.
	exit 1
fi

git fetch --tags

LATEST_TAG=$(git tag --sort=v:refname | tail -n 1)

if [ -z "$LATEST_TAG" ]
then
    echo "No tag found... Setting default tag of v0.0.1"
    NEW_TAG=v0.0.1
else
    echo "Old tag was $LATEST_TAG"
    NEW_TAG=$($SCRIPT_DIR/semver/increment_version.sh $semver_flag $LATEST_TAG)
fi

echo "New tag is $NEW_TAG"

#git tag -a $NEW_TAG -m "$NEW_TAG"
#git push origin $NEW_TAG

echo "Done"
