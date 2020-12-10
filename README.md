# daemonless-build
This is simple example shows how to build and push docker images daemonless
We will be using [kaniko](https://github.com/GoogleContainerTools/kaniko) to build it and [crane](https://github.com/google/go-containerregistry/tree/master/cmd/crane) to push to the registry

Seems like `kaniko` is not yet production ready product as it suffers from different bugs
1. Authentication with docker registry v2 seems to be [broken](https://github.com/GoogleContainerTools/kaniko/issues/740#issuecomment-531798845). Because of this, we need to create a tarball from that image and use crane to actually ship it. 
2. When using `--no-push` flag and `--tarPath` to store it, the `manifest.json` is null, so using `--destination image:lastest` is used to avoid that [bug](https://github.com/GoogleContainerTools/kaniko/issues/1209).

This example assumes that the pipeline also configured with the following environment variables to authenticated with Dockerhub
1. `DOCKER_HUB_REPOSITORY_USERNAME`
2. `DOCKER_HUB_REPOSITORY_PASSWORD`
3. `DOCKER_REPOSITRY` - name of the repository to push `IMAGE:TAG`

* In `daemonless/Dockerfile` there is the Dockerfile that the steps in `codefresh.yaml` used, it has both `kaniko` and `crane` binaries