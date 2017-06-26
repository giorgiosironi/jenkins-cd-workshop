# Locks

Despite what cloud fanatics would say, there are always going to be bottlenecked external resources used to run your builds. Jenkins provides [nodes and node labels](https://github.com/jenkinsci/pipeline-plugin/blob/master/TUTORIAL.md#using-agents) if what you want is just to distribute parts of builds on special machines (e.g. a Linux and a Windows system to test compatibility issues).

Sometimes the dynamic is more complex, for example you have resources A, B and C that are all needed by different builds, sometimes together, sometimes one at a time. You can be more granular using `locks`, that reserve a `resource` until you unlock it. For example, I use this to lock a shared end2end testing environment where about 10 projects are deployed together: you don't want someone else to deploy project Y while you are still testing the integration of project X.

Run
```
./jenkins-cli.sh create-job locks < jobs/locks.xml
```

You can start more than one build hitting `Build Now` at http://localhost:8080/job/locks/1/console repeatedly.

What you should observe at http://localhost:8080/job/locks/1/console and http://localhost:8080/job/locks/2/console is that the builds won't overlap:
```
21:01:30 Trying to acquire lock on [my-environment]
21:01:30 Resource [my-environment] did not exist. Created.
21:01:30 Lock acquired on [my-environment]
[Pipeline] {
[Pipeline] sh
21:01:30 [locks] Running shell script
21:01:30 + ./heavy-work.sh 20
21:01:30 Heavy work will take 20 seconds...
21:01:52 Finished!
[Pipeline] }
21:01:52 Lock released on resource [my-environment]
```
```
[Pipeline] lock
21:01:52 Trying to acquire lock on [my-environment]
21:01:52 Found 0 available resource(s). Waiting for correct amount: 1.
21:01:52 [my-environment] is locked, waiting...
21:01:52 Lock acquired on [my-environment]
[Pipeline] {
[Pipeline] sh
21:01:52 [locks@2] Running shell script
21:01:53 + ./heavy-work.sh 20
21:01:53 Heavy work will take 20 seconds...
21:02:14 Finished!
[Pipeline] }
21:02:14 Lock released on resource [my-environment]
```

Locks give you the capability to do mutual exclusions from any set of builds, even if they are from different projects, or some are pull requests. For example, I share the same virtual machine to test a project's mainline and pull requests; builds get queued rather than clashing with each other.

You can view the list of locks and which build is holding each of them at http://localhost:8080/lockable-resources/
