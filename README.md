# bash-utils

## SemVer
`./bump-version-push-tag.sh major|minor|patch` will tag and push to a remote.

Currently, you can't give it a path to the Git repo you want to tag.
So you run the script from inside that repo.
```shell
$ usage: ./bump-version-push-tag.sh [major|minor|patch]
```
