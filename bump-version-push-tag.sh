#!/usr/bin/env bash

if [ ! -f ~/increment_version.sh ] ;
then
	curl -o ~/increment_version.sh https://raw.githubusercontent.com/TeslaGov/shell-semver/master/increment_version.sh ;
	chmod +x ~/increment_version.sh ;
fi;

LATEST_TAG=$(git tag --sort=v:refname | tail -n 1)
GIT_DESC="$(git describe --always --tags --dirty)"
echo "Git describe returns $GIT_DESC"
if [[ $GIT_DESC =~ ^.*-dirty$ ]] ;
then
	echo Repo is dirty. Please commit first.
	exit 0
fi;

NEW_TAG=$(~/increment_version.sh -p $LATEST_TAG)
echo "Old tag was $LATEST_TAG"
echo "New tag is $NEW_TAG"
git tag -a $NEW_TAG -m "$NEW_TAG"
git push origin $NEW_TAG
echo "done"