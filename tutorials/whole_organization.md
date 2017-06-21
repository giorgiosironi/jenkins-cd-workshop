# Building all the pull requests of a Github organization

Or at least the ones containing a Jenkinsfile. Remember when we [loaded credentials](setup) into Jenkins? Now they will become necessary.

Run
```
./jenkins-cli.sh create-job whole-organization < jobs/whole-organization.xml
```

and run `Scan Organization Now` at http://localhost:8080/job/whole-organization/

This job is not a pipeline, but a special kind of `folder` that will contain other jobs for a hierarchical organization.

This standard plugin periodically scans the Github API for an organization or a user profile, and creates a list of generated jobs organized first in projects and then in pull requests. The plugin itself can also be configured to build branches, including master.

Scans and builds are usually triggered by a [Github organization hook](https://github.com/jenkinsci/github-organization-folder-plugin#hook-configuration), but as in [the first repository example](hello_world_repository.md), here we will trigger them manually to have complete control.

At http://localhost:8080/job/whole-organization/ you should at least see the `hello-world` project appear (it's the only one with an open pull request).

At http://localhost:8080/job/whole-organization/job/hello-world/view/change-requests/ you can see the list of jobs that have been created.

At http://localhost:8080/job/whole-organization/job/hello-world/view/change-requests/job/PR-1/ you can see all the builds of the `PR-1` job. Trigger a new one with `Build Now`.
