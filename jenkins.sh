#!/bin/bash
set -e

sudo chmod 777 jenkins_home/
sudo docker pull giorgiosironi/jenkins-cd-workshop
sudo docker run \
	-p 8080:8080 \
    -p 16022:16022 \
	-v $(pwd)/jenkins_home:/var/jenkins_home \
	--env JAVA_OPTS=-Djenkins.install.runSetupWizard=false \
	giorgiosironi/jenkins-cd-workshop

