FROM jenkins:2.46.3
# small set of standard plugins for pipeline support
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
# disable security for demo purposes
COPY config/*.xml /usr/share/jenkins/ref/
# custom initialization code, if needed
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
# install this:
# https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz
RUN git config --global user.email "jenkins-cd-workshop@giorgiosironi.com"
RUN git config --global user.name "Jenkins C. D. Workshop"
