# n3tuk Terraform Workspace for Cloudflare DNS

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A [Terraform][terraform] repository for the management of [GitHub][github]
repositories for the [`n3tuk`][n3tuk] Organisation.

[terraform]: https://terraform.io/
[github]: https://github.com/
[n3tuk]: https://github.com/n3tuk

## Workspace

The [`terraform/`][workspace] workspace hosts the configuration for GitHub,
including configuration of the Organisation, the repositories, and associated
resources. The [`README.md`][readme] therein for further information on
supported `variables` and `outputs`, as well as the what is managed by the
workspace.

[workspace]: https://github.com/n3tuk/infra-github/tree/main/terraform/
[readme]: https://github.com/n3tuk/infra-github/blob/main/terraform/README.md

## Usage

In the event that the [`terraform/`][workspace] needs to be deployed manually,
ensure that the following is configured in the local environment first:

```console
$ set -x GITHUB_TOKEN xxx
$ gcloud auth login
...
You are now logged in as [jon@than.io].
$ gcloud config set project genuine-caiman
```

### Developing

The [Taskfiles][taskfile] for this repository have a `develop` task which allows
it to continuously run checking and integration tasks during development:

[taskfile]: https://taskfile.dev/

```console
$ task develop
task: Started watching for tasks: develop
...
[lint] Passed
[validate] Passed
...
```

### Running Terraform

To run Terraform, this must only be done inside each individual Terraform
configuration.

```console
$ cd terraform/
$ task plan
...
[plan] Plan: 0 to add, 0 to change, 0 to destroy.
...
$ task apply
...
[apply] Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

## License

Copyright (c) 2024 Jonathan Wright

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Authors

- Jonathan Wright (<jon@than.io>)
