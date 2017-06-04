## Requirements

Docker needs to be installed upon a Linux machine (virtual or physical), to be able to run the image `giorgiosironi/jenkins-cd-workshop`.

`./load-credentials.sh` needs to be run to provide Jenkins with credentials to access Github, mostly in a read only way but also for writing commit statuses or open pull requests in advanced scenarios. An SSH private key and a Github token for `jenkins-cd-workshop` should be provided by the workshop's speaker.

## Commands

`jenkins.sh` will start a preconfigured container with a LTS Jenkins version.

`jenkins-cli.sh` is the jenkins-cli:
```
./jenkins-cli.sh create-job hello-world < jobs/hello-world.xml
```

## Github references

User: https://github.com/jenkins-cd-workshop



