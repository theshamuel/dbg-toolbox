FROM alpine:3.17

LABEL maintainer="Alex Gladkikh <theshamuel@gmail.com>"

LABEL org.opencontainers.image.source https://github.com/theshamuel/dbg-toolbox

RUN  apk update

# Install Common
RUN  apk add --update --no-cache busybox-extras && \
     apk add --update --no-cache ca-certificates && \
     apk add --update --no-cache curl && \
     apk add --update --no-cache iputils && \
     apk add --update --no-cache libc-dev && \
     apk add --update --no-cache netcat-openbsd && \
     apk add --update --no-cache openssl && \
     apk add --update --no-cache vim

# Install DB tools
RUN  apk add --update --no-cache mongodb-tools && \
     apk add --update --no-cache mysql-client && \
     apk add --update --no-cache postgresql-client

# Install Ansible
RUN  apk add --update --no-cache ansible

# Install Terraform
RUN  apk add --update --no-cache wget && \
     apk add --update --no-cache unzip && \
     release=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest |  grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` && \
     wget https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip && \
     unzip terraform_${release}_linux_amd64.zip && \
     mv terraform /usr/bin/terraform && \
     rm -rf terraform_${release}_linux_amd64.zip

RUN  rm -rf /var/cache/apk/*

CMD ["/bin/sleep", "1d"]