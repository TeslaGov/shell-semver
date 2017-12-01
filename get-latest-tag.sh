#!/usr/bin/env bash

LATEST_TAG=$(git tag --sort=v:refname | tail -n 1)

if [ -z "$LATEST_TAG" ]
then
      echo "No tag found..."
      echo "Tagging v0.0.1..."
fi