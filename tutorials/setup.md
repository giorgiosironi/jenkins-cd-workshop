# Setup

## Prerequisites

You should have Docker installed, either on a physical Linux machine or in a virtual Linux machine if you are on Mac or Windows. The version this workshop has been tested with is Docker 17.04.0-ce.

There is nothing stopping you from just running a Jenkins .jar file instead, but you would have to replicate the configuration being performed in the Dockerfile.

## Start

Run `./jenkins.sh`. This should pull down a docker image, and start it with the necessary. You can stop the container with Ctrl+C, but it should be left running. It will persist its state so don't be afraid to stop and restart.

Check that Jenkins is running by loading (http://localhost:8080) in your browser.

Check that the jenkins-cli is correctly set up so that you will be able to interact with Jenkins from the terminal. Run `./jenkins-cli.sh`, you should see an output similar to:

```
$ ./jenkins-cli.sh who-am-i
Authenticated as: anonymous
Authorities:
  anonymous
```

## Credentials

`./load-credentials.sh` needs to be run to provide Jenkins with credentials to access Github, mostly in a read only way but also for writing commit statuses or open pull requests in advanced scenarios. An SSH private key and a Github token for `jenkins-cd-workshop` should be provided by the workshop's speaker.

Run `./load-credentials.sh <ID_RSA_FILE> <TOKEN>`.
