#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "tfswitch-installed" command -v tfswitch
check "tflint-installed" command -v tflint
check "zsh-installed" command -v zsh
check "oh-my-zsh-installed" [ -d "$HOME/.oh-my-zsh" ]
check "azure-cli-installed" command -v az
check "pre-commit-installed" command -v pre-commit
check "terraform-docs-installed" command -v terraform-docs

# Report result
reportResults
