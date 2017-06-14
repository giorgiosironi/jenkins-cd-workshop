# Triggering downstream pipelines

Pipelines can have as many stages as you need, but in some cases it is useful to build multiple, smaller pipelines rather than trying to do everything into a single one. We gain the capability of reexecuting only part of the process by triggering a single pipeline - or to pause the execution, for example separating the testing pipeline from the production deployment one.

In order to effectively link separate pipelines, we can resort to manual intervention, or use pipeline `upstream` to commit to a new branch in the Git repository of the project that will trigger the pipeline `downstream` using a different Jenkinsfile. For example, my testing pipeline commit to an `approved` branch that is what triggers the production deployment pipelines. The production deployment pipelines can than be disabled to pause deployments in a difficult moment, they can be triggered by humans or they can be set to build at every new commit, or periodically, and so on.

What we are going to see here is *not* that, but instead a method for linking to pipelines explciitly with Groovy code: triggering a `downstream` pipeline from the `upstream` pipeline. Since this is just a pipeline step, you can have any condition around it to decide whether to execute it or prepare its input.

Run
```
./jenkins-cli.sh create-job downstream < jobs/downstream.xml
./jenkins-cli.sh create-job upstream < jobs/upstream.xml
```

Now go to localhost:8080/job/upstream and trigger the pipeline. After a simulated stage lasting 10 seconds, it will trigger `downstream`.

At https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.upstream#L9 you can see that:

- the job being built is `downstream`.
- we don't `wait` for the downstream build we have triggered to finish: we have configured this as an asynchronous step (this is usually what we want).
- we pass a `string` parameter named `importantData`, with a unique value

At http://localhost:8080/job/downstream/1/console we can see the execution we have triggered. At https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.downstream we can see that:
- the parameter is read from the `params` object
- we have a default so that this job can be triggered manually, not just from `upstream`

N.B. you can define a job as `parameterized` from the UI or the XML definition, this will let you pass in parameters when you build it manually. I didn't do that in this example, but the way to read the parameters from the pipeline doesn't change.
