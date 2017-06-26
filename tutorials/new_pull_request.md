# Opening pull requests from builds

Since pipelines can execute any headless Unix process through the `sh` step, we can integrate any external system through its API. `sh` doesn't have to execute bash scripts, since it works with any executable: PHP or Python scripts, JARs with parameters and so on.

In this tutorial we are going to use the `hub` command line tool to interact with the Github API and open a pull request on the current project. I use this to periodically (or on-demand) run update tasks for libraries such as `composer update`. The changes made automatically by a command can then be reviewed and amended on the PR by a human, fixing backward incompatible changes or failing tests.

Run
```
./jenkins-cli.sh create-job new-pull-request < jobs/new-pull-request.xml
```

[The pipeline definition has 4 phases](https://github.com/jenkins-cd-workshop/advanced-pipelines/blob/master/Jenkinsfile.new-pull-request):

1. Checkout the original repository 
1. Run a process that will generate a difference in the version-controlled files
1. Generate a commit as descriptive as possible (not really)
1. Push and open a pull request

We don't need to test our changes, because we can use the [organization folder](whole_organization.md) to build all pull requests anyway. The success of this build is whether the process succeeds and the changes can be pushed; we may want to do additional work on the pull request before merging, each time re-running only the build of the pull request and not this one, which generated its first commit.

Trigger a new build at http://localhost:8080/job/new-pull-request/ and you should see (if the output is green) a new PR at https://github.com/jenkins-cd-workshop/advanced-pipelines/pulls

In the output at http://localhost:8080/job/new-pull-request/2/console you will see a link like https://github.com/jenkins-cd-workshop/advanced-pipelines/pull/6 that will send you directly to the PR being opened. I find it useful to include a backlink in the PR description to the original build (you will see it, but it won't work here since each Jenkins is deployed on `localhost`.)
