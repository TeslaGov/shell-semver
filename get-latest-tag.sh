#!/usr/bin/env bash

LATEST_TAG=$(git tag --sort=v:refname | tail -n 1)
