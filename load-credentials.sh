#!/bin/bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: ./load-credentials.sh SSH_KEY GITHUB_TOKEN [GITHUB_USERNAME]"
    echo "Example: ./load-credentials.sh ./id_rsa 54385437f... jenkins-cd-workshop"
    exit 1;
fi

key="${1}"
token="${2}"
username="${3:-jenkins-cd-workshop}"

sudo cp $key jenkins_home/.ssh/id_rsa && chown jenkins:jenkins jenkins_home/.ssh/id_rsa
cat secrets/github-token-template.xml | sed -e "s/GITHUB_USERNAME/$username/g" | sed -e "s/GITHUB_TOKEN/$token/g" > secrets/github-token.xml
./jenkins-cli.sh create-credentials-by-xml  system::system::jenkins _ < secrets/github-token.xml
cat secrets/config-hub-template.xml | sed -e "s/GITHUB_USERNAME/$username/g" | sed -e "s/GITHUB_TOKEN/$token/g" > secrets/config-hub
sudo mkdir jenkins_home/.config && sudo chown jenkins:jenkins jenkins_home/.config
sudo cp secrets/config-hub jenkins_home/.config/hub && sudo chown jenkins:jenkins jenkins_home/.config/hub

