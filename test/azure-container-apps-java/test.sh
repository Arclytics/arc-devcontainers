#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "java-installed" command -v java
check "javac-installed" command -v javac
check "maven-installed" command -v mvn
check "zsh-installed" command -v zsh
check "oh-my-zsh-installed" [ -d "$HOME/.oh-my-zsh" ]
check "azure-cli-installed" command -v az
check "docker-installed" command -v docker
check "kubectl-installed" command -v kubectl
check "helm-installed" command -v helm
check "azd-installed" command -v azd
check "containerapp-extension-installed" az extension list --query "[?name=='containerapp']" -o tsv | grep -q .

# Report result
reportResults
