# Sharing code between pipelines

A common problem with infrastructure is that code gets copied and pasted in many places. You want to maintain consistency between your projects, so that when you fix a bug or change a deployment process you have to make a single change and not intervene on each project. Like for application code, you have to remove duplication by extracting new abstractions.

Run
```
git clone https://github.com/jenkins-cd-workshop/steps jenkins-cd-workshop-steps
cd jenkins-cd-workshop-steps
./push-into-jenkins.sh
```

to checkout a sample library of steps and push it into an internal Git repository of your Jenkins instance. You can see with

```
git remote -v
```

that the standard Git over SSH is a simple way of interfacing with Jenkins to load shared libraries:

```
local-jenkins   ssh://localhost:16022/workflowLibs.git (fetch)
local-jenkins   ssh://localhost:16022/workflowLibs.git (push)
origin  git@github.com:jenkins-cd-workshop/steps.git (fetch)
origin  git@github.com:jenkins-cd-workshop/steps.git (push)
```

Now go back to `jenkins-cd-workshop` and run:

```
./jenkins-cli.sh create-job with-common-steps < jobs/with-common-steps.xml
```

Run the new pipeline at http://localhost:8080/job/with-common-steps/.

[The pipeline calls a step](https://github.com/jenkins-cd-workshop/with-common-steps/blob/master/Jenkinsfile) that is [defined into the library](https://github.com/jenkins-cd-workshop/steps/blob/master/vars/gitDifferences.groovy).

Every step is a different `stepName.groovy` file defining a `call()` function. It is this function that can be called with `stepName()` from the pipeline, passing arguments and assigning its return value.
