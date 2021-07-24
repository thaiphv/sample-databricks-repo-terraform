#!/usr/bin/env bash

set -euo pipefail

eval "$(jq --raw-output '@sh "GIT_REPO_URL=\(.git_repo_url) GIT_REPO_NAME=\(.git_repo_name)"')"

mkdir -p .notebooks

GIT_REPO_TEMP_DIR=$(pwd)/.notebooks

cd $GIT_REPO_TEMP_DIR
rm -rf $GIT_REPO_NAME
git clone $GIT_REPO_URL $GIT_REPO_NAME

jq --null-input \
  --arg git_repo_name "$GIT_REPO_NAME" \
  --arg git_repo_dir "$GIT_REPO_TEMP_DIR/$GIT_REPO_NAME" \
  '{"git_repo_name": $git_repo_name, "git_repo_dir": $git_repo_dir}'
