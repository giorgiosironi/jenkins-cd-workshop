# Hello world, repository version

The more metadata you store into Jenkins (or any other CI system), the more difficult will it be to evolve. Therefore once we are able to run a Hello World pipeline we should immediately strive to store its definition inside the source code repository of our project, which will make it versionable and capable of being branched, analyzed, reviewed...

Run
```
./jenkins-cli.sh create-job hello-world-repository < jobs/hello-world-repository.xml
```

Run the new pipeline at http://localhost:8080/job/hello-world-repository/. You should see:

```
Started by user anonymous
Obtained Jenkinsfile from git https://github.com/jenkins-cd-workshop/hello-world
[Pipeline] node
Running on master in /var/jenkins_home/workspace/hello-world-repository
[Pipeline] {
[Pipeline] echo
Hello, world! This is a pipeline stored inside a SCM repository.
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```

The XML file we use is saved in its `jenkins_home` folder. It contains the only reference that is stored inside Jenkins:
```
    ...
          <url>https://github.com/jenkins-cd-workshop/hello-world</url>
          ...
    <scriptPath>Jenkinsfile</scriptPath>
    ...
```

You can see the Groovy build definition in what is called the [Jenkinsfile](https://github.com/jenkins-cd-workshop/hello-world/blob/master/Jenkinsfile). It is equivalent to the [previous job we created](hello_world.md), but being stored in the project itself it's much easier to maintain and to atomically update when the code changes.

N.B. Normally the pipeline is configured to trigger a new build at every new commit on the branch the Jenkinsfile comes from. The commit is delivered through a Github hook, which we can't deliver to your localhost, so we will trigger builds manually for maximum control.
