#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function echoUsage() {
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
    echoUsage
    exit 1
fi

# Ensure the selected environment is valid.
case "$1" in
            major|minor|patch) version_bump_type=$1;;
            *) echoUsage; exit 1;;
esac

source $SCRIPT_DIR/verify-repo-not-dirty.sh

# Will tag v0.0.1 if no tags are found
source $SCRIPT_DIR/get-latest-tag.sh

source $SCRIPT_DIR/create-new-tag-for-$version_bump_type-update.sh

echo "Old tag was $LATEST_TAG"

echo "New tag is $NEW_TAG"

#git tag -a $NEW_TAG -m "$NEW_TAG"
#git push origin $NEW_TAG

echo "Done"
