# Notes

## Tech stack

This project uses the following technologies to deploy a small web application/API:
* Flask: this was a given, but it's ideal as a small, self-contained Python framework. Alternatives could be Django which is more robust and as this is an API, FastAPI could be used too. 
* Github Actions: I used this option since I'm the most familiar with it, but there is a plethora of options, including: Azure DevOps, Gitlab CI/CD, Jenkins, etc
* Minikube: it's a nice and small K8s implementation, I used it briefly in the past, but k3s would be just as nice. 
* Helm: although not a strict necessity here, I opted to deploy in two environments, so it can be utilised. There are multiple alternatives that serve a similar purpose, for example: jsonnet, ksonnet, kustomize, etc 

## Development workflow

### Docker

The application is deployed in a Docker container, I'm using the `python:3.13-slim` base image as it's small and the current code is incompatible with Python 3.14. Locally, it can be built with:

```bash
docker build -t csizmaziakiki/helloapp:latest .
```

There is a `.gitignore` to make sure nothing irrelevant is copied onto the image, this is validated in the `Build and validate Docker image` Github Actions workflow step. 

### Minikube, Helm and environments

The container is being run on Minikube and is deployed with Helm from a set of charts. There are two "environments" which are Kubernetes namespaces in this case, anything that differs between envs has its own values file with the `values-<environment.yaml>` naming schema, these obviously include the `namespace` and I set up a slightly different `replicaCount` to mimic a larger production environment. 

### Github Actions

The testing, Docker image build and deployment is being done with Github Actions, there are two workflows:
* `test-qa-deploy`: runs the tests, builds the image and deploys into a `qa` environment on PRs to `master`, this is useful to validate changes before merging to `master`
* `prod-deploy`: runs after a merge on `master`, builds the image and deploys to the `prod` environment