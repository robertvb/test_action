# Container image that runs your code
FROM alpine:3.1

# Environment variables
ENV SSH_PRIVATE_KEY=${SSH_PRIVATE_KEY}
ENV DROPLET_IP=${DROPLET_IP}

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY do_droplet_deployment.sh /do_droplet_deployment.sh

RUN chmod +x /do_droplet_deployment.sh
RUN apk update \
  && apk add \
  openssh-client \
  ca-certificates \
  bash

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/do_droplet_deployment.sh"]