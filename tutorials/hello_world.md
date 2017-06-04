# Hello world

Run
```
./jenkins-cli.sh create-job hello-world < jobs/hello-world.xml
```

This will create a new `hello-world` pipeline, visible at http://localhost:8080

The contents of this pipeline are specified in the XML file, but what we care about is just the Groovy part:
```
node {
    echo "Hello, world! This is an hardcoded pipeline configured into Jenkins"
}
```

In this case, the pipeline is hardcoded in the initial definition, the equivalent of creating and maintaining it through the graphical UI. The XML wrapping be used as a fine-grained backup and restore mechanism, but this isn't the subject of this workshop; I just used this method to skip the manual creation, but it's a couple of clicks and as long as you don't have to create many dozens of builds for microservices it's the easiest method.

Executors pick up pipelines to perform all their steps; in this case with `node {` we aren't selecting any particular executor, any node will do.

The only step in this pipeline is an `echo` step outputting a constant string.

For practical reasons we aren't setting up Github hooks, so you will have to run these builds manually. Go at http://localhost:8080/job/hello-world/ and click `Build Now`.

By clicking on the small bulbs in `Build History` you can go directly to the build's output. You should see

```
Started by user anonymous
[Pipeline] node
Running on master in /var/jenkins_home/workspace/hello-world
[Pipeline] {
[Pipeline] echo
Hello, world! This is an hardcoded pipeline configured into Jenkins
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
