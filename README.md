As the title suggests, feel free to use. Based on nix.

Using git-annex latest from https://github.com/NixOS/nixpkgs/tree/05405724efa137a0b899cce5ab4dde463b4fd30b

Make sure the wrapper script (git-annex.sh) is executable if you want to use it, it acts as a portal to the docker container and therefore git-annex. Forward commands by appending them after the script


## Usage

```bash
$ nix build
$ docker load < result
$ ./git-annex.sh [CMD]
```
