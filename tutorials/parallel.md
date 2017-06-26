# Parallelism

Pipelines are a serial execution at their outermost scope: a series of stages. However, some of the steps inside a stage can be executed in parallel to save time and better utilize the multiple cores that your machines have. Unlike other tools like Go CD that constrain you to their model of serial and parallel execution - was a job inside a task or the other way around - Jenkins pipelines just default their steps to serial and give you a construct for executing closures in parallel. This is like a Lisp of build systems: given these primitives you can do anything that a real programming language can do.

Run
```
./jenkins-cli.sh create-job parallel < jobs/parallel.xml
```

If you take a look at the [pipeline definition](https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.parallel), you'll see that the stage `Parallel heavy work` defines three actions, taking 10, 20 or 30 seconds.

The parallel step runs these three closures in parallel threads, giving a name to each. 

At http://localhost:8080/job/parallel/ you can start a new build. Looking at the output at http://localhost:8080/job/parallel/1/consoleFull you should see:

```
17:03:44 [a] [parallel] Running shell script
[Pipeline] [b] sh
17:03:44 [b] [parallel] Running shell script
[Pipeline] [c] sh
17:03:44 [a] + ./heavy-work.sh 10
17:03:44 [a] Heavy work will take 10 seconds...
17:03:44 [b] + ./heavy-work.sh 20
17:03:44 [b] Heavy work will take 20 seconds...
17:03:44 [c] [parallel] Running shell script
17:03:44 [c] + ./heavy-work.sh 30
17:03:44 [c] Heavy work will take 30 seconds...

17:03:54 [a] Finished!
[Pipeline] [a] }

17:04:06 [b] Finished!
[Pipeline] [b] }

17:04:16 [c] Finished!
```

Each of the actions passed to `parallel` has its output tagged with its name. The stage took 32 seconds in this example, slightly longer than the longest of the actions due to the parallelism overhead. However, running the same actions serially would result in a stage at least 60 seconds long, which means this software would generate feedback later and arrive in production in twice the amount of time.
