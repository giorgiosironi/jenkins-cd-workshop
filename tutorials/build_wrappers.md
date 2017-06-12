# Build wrappers

Build wrappers are special steps that wrap your own pipeline sections (a whole pipeline, a single stage or just a few lines) as closures, providing additional behavior. We'll see two in action.

Run
```
 ./jenkins-cli.sh create-job build-wrappers < jobs/build-wrappers.xml
```

and run the resulting job at http://localhost:8080/job/build-wrappers/

Inside the output at http://localhost:8080/job/build-wrappers/1/console you will see two interesting things.

First, every output line has gained a bold timestamp registering when it was produced:
```
20:50:11 Cloning the remote Git repository
20:50:11 Cloning repository https://github.com/jenkins-cd-workshop/advanced-pipelines
20:50:11  > git init /var/jenkins_home/workspace/build-wrappers # timeout=10
...
20:50:13 Hello, world! This should be shown with a timestamp
```
This is very useful to pinpoint slow parts of a build, or when a test failed to correlate it with your logs.

The second interesting thing is that some output is colored:
```
20:50:13 Hello # <- this should be red
```

Looking at [https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.build-wrappers](the pipeline definition), we see these build wrappers:
```
timestamps {
}
```
```
wrap([$class: "AnsiColorBuildWrapper"]) {
}
```
Each wraps a section of Groovy code. Lines included between `{}` are really a closure in Groovy, which is passed to the build wrapper to be executed.
