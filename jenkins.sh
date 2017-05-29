#!/bin/bash
set -e

sudo docker run -p 8080:8080 -v $(pwd)/jenkins_home:/var/jenkins_home jenkins:2.46.3

