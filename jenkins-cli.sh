#!/bin/bash
set -e

if [ ! -e jenkins-cli.jar ]; then
    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
fi

java -jar jenkins-cli.jar -s http://localhost:8080 $@

