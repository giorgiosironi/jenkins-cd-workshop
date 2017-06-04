## Tutorials

- [Setup](tutorials/setup.md)
- [Hello world](tutorials/hello_world.md)
- [Hello world, repository version](tutorials/hello_world_repository.md)
- [Multiple stages](tutorials/multiple_stages.md)
- [Extracting common steps](tutorials/with_common_steps.md)
- [Building a whole Github organization](tutorials/whole_organization.md)
- [Build wrappers](tutorials/build_wrappers.md)
- [Locks](tutorials/locks.md)
- [Parallelism](tutorials/parallel.md)
- [Starting and stopping an external resource](tutorials/precious_resource.md)
- [Creating pull requests](tutorials/new_pull_request.md)

## Commands

`jenkins.sh` will start a preconfigured container with a LTS Jenkins version.

`build.sh` will rebuild the local `giorgiosironi/jenkins-cd-workshop` image from the Dockerfile.

`jenkins-cli.sh` is the jenkins-cli, which in this context is primarily used to create prebuilt jobs:
```
./jenkins-cli.sh create-job hello-world < jobs/hello-world.xml
```

`clear.sh` clears `jenkins_home/`, a mounted volume where the container stores all state relative to the Jenkins instance (such as additional plugins that have been installed, or simply the build results).

`load-credentials.sh` loads a SSH key and a Github token into Jenkins. Both should be configured for the `jenkins-cd-workshop` Github user; they should be provided by the speaker.

## Github references

- User: https://github.com/jenkins-cd-workshop
- Repository of common steps: https://github.com/jenkins-cd-workshop-steps

