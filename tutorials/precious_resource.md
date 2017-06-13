# Precious resources

I routinely use a `c4.4xlarge` AWS EC2 instance (16 virtual CPU cores) to run a build using a large amount of parallelism for resizing images. This machine costs $0.8 per hour, and just for this single project this would add up to $20 per day. By stopping it periodically (essentially `shutdown -h now`) and restarting it when needed I lose ~30 seconds per build (which takes 10 minutes in total) but I save easily 75% of the costs. That money can then be used to give hardware resources to other builds that need them. However, we have to be careful not to stop it while a build is running.

Run
```
./jenkins-cli.sh create-job precious-resource-use < jobs/precious-resource-use.xml
./jenkins-cli.sh create-job precious-resource-stop < jobs/precious-resource-stop.xml
```

The [https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.precious-resource-use](use pipeline) simulates a very powerful virtual machine that is [locks.md](locked) and started to be used inside a build. After the stage using it has finished, the corresponding resource is unlocked.

The [https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.precious-resource-stop](stop pipeline) is supposed to run periodically. It tries to lock the resource and stops it. Because of the lock, this action will never interrupt a build.

However, the more frequently you run the `stop` build, the sooner it will stop the virtual machine from spending your money. I usually retain only a limited subset (the last 100) builds from the `stop` pipeline to let it run every few minutes.

Run these pipelines simultaneously at http://localhost:8080 clicking the and take a look at their output. The `stop` pipeline will wait for the other `use` pipeline to finish thanks to the lock.

N.B. if you are using EC2 instances, stopping them immediately when available is not efficient as you pay for 1 hour every time they are started: you have to be more careful and stop them when they approach the end of a full hour. That's why we need a separate `stop` build: many different builds of the `use` pipeline may run in a single hour, each finding the resource left up by a previous `use` build; hence `use` build should never stop resources.
