# Hello world, repository version

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

The XML file we use is saved in its jenkins_home folder. It contains the only reference that is stored inside Jenkins:
```
    ...
          <url>https://github.com/jenkins-cd-workshop/hello-world</url>
          ...
    <scriptPath>Jenkinsfile</scriptPath>
    ...
```

You can see the Groovy build definition in what is called the [https://github.com/jenkins-cd-workshop/hello-world/blob/master/Jenkinsfile](Jenkinsfile). It is equivalent to the [hello-world](previous build we created), but being stored in the project itself it's much easier to maintain and to atomically update when the code changes.
