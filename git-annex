#!/bin/bash
# script from https://git-annex.branchable.com/install/Docker/
CONT_NAME=${CONT_NAME:-git-annex:latest}
# if in git repo, mount root as /data, and cd into relative subdir
# if not, mount cwd as /data
abs_dir=$(readlink -e .)
root_dir=$(git rev-parse --show-toplevel 2>/dev/null || true)
root_dir=${root_dir:-$abs_dir}
rel_dir=${abs_dir#$root_dir}
# if run by git, assume command is git-annex
# otherwise, don't assume, to allow other uses
cmd=
! [ "$(basename "$(readlink -e /proc/$PPID/exe)")" = "git" ] || cmd=git-annex
exec docker run -it --rm \
    -u $(id -u):$(id -g) \
    -v /etc/passwd:/etc/passwd:ro \
    -v $HOME/.ssh:$HOME/.ssh \
    -v $HOME/.gnupg:$HOME/.gnupg \
    -v $HOME/.gitconfig:$HOME/.gitconfig \
    -v "$root_dir":/data \
    ${AWS_ACCESS_KEY_ID:+-e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"} \
    ${AWS_SECRET_ACCESS_KEY:+-e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"} \
    ${B2_ACCOUNT_ID:+-e B2_ACCOUNT_ID="$B2_ACCOUNT_ID"} \
    ${B2_APP_KEY:+-e B2_APP_KEY="$B2_APP_KEY"} \
    -w /data"$rel_dir" \
    $CONT_NAME $cmd "$@"
