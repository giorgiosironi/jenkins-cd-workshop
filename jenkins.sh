#!/bin/bash
set -e

sudo docker run \
	-p 8080:8080 \
    -p 16022:16022 \
	-v $(pwd)/jenkins_home:/var/jenkins_home \
	--env JAVA_OPTS=-Djenkins.install.runSetupWizard=false \
	giorgiosironi/jenkins-cd-workshop

