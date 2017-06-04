FROM jenkins:2.46.3
# small set of standard plugins for pipeline support
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
# disable security for demo purposes
COPY config/*.xml /usr/share/jenkins/ref/
# custom initialization code, if needed
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
# git configuration to be able to create new commits in builds
COPY .gitconfig /usr/share/jenkins/ref/
# avoid "Host Key Verification Failed" when using git+ssh
COPY known_hosts /usr/share/jenkins/ref/.ssh/known_hosts
# installing hub to create pull requests from builds
USER root
RUN cd /tmp && \
    wget https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz && \
    cd /usr/local && \
    tar xvzf /tmp/hub-linux-amd64-2.2.9.tgz && \
    ln -s /usr/local/hub-linux-amd64-2.2.9/bin/hub /usr/local/bin/hub
USER jenkins
