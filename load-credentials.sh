#!/bin/bash
set -e

./jenkins-cli.sh create-credentials-by-xml  system::system::jenkins _ < $1

