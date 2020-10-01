#!/usr/bin/env bash

repo_name=aws-secrets-manager-git-credential-helper
executable_path=$(realpath aws-secrets-manager-git-credential-helper/$repo_name)

[[ -d $repo_name ]] || git clone https://github.com/zuoralabs/$repo_name

git config --global credential.https://git.service.helper "! $executable_path https://git.service"

# custom config vars
git config --global aws-secrets-manager.https://git.service.region-name "us-east-2"  # customize; default to sagemaker favored region
git config --global aws-secrets-manager.https://git.service.secret-id "path/to/secret"  # customize
