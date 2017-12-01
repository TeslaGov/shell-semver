shell-semver
===========

Utilities to increment Git tags and push them to the remote.

Increment semantic versioning strings in shell scripts.

```shell
$ ./increment_version.sh
usage: increment_version.sh [-Mmp] major.minor.patch

$ ./increment_version.sh -p 0.0.0
0.0.1

$ ./increment_version.sh -m 0.0.3
0.1.0

$ ./increment_version.sh -M 1.1.15
2.0.0

$ ./increment_version.sh -Mmp 2.3.4
3.1.1

$ ./increment_version.sh -p v0.0.0
v0.0.1

$ ./increment_version.sh -m v0.0.3
v0.1.0

$ ./increment_version.sh -M v1.1.15
v2.0.0
```
