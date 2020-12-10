# This image will be used to run steps in Codefresh
# It includes kaniko to build and crane to push the image

FROM gcr.io/kaniko-project/executor:v1.3.0

FROM alpine:3.12 as crane
RUN apk add --update curl
RUN curl -L https://github.com/google/go-containerregistry/releases/download/v0.2.1/go-containerregistry_Linux_x86_64.tar.gz -o go.tar
RUN tar -xvf go.tar
RUN mv ./crane /crane

FROM alpine:3.12
COPY --from=0 /kaniko/executor /usr/local/bin/kaniko
COPY --from=0 /kaniko/docker-credential-gcr /kaniko/docker-credential-gcr
COPY --from=0 /kaniko/docker-credential-ecr-login /kaniko/docker-credential-ecr-login
COPY --from=0 /kaniko/docker-credential-acr /kaniko/docker-credential-acr
COPY --from=0 /kaniko/docker-credential-acr-env /kaniko/docker-credential-acr-env
COPY --from=0 /kaniko/.docker /kaniko/.docker

COPY --from=crane /crane /usr/local/bin/crane

ENTRYPOINT [ "/kaniko" ]