FROM ubuntu:latest

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.local/bin:/usr/local/bin"

RUN apt update \
  && apt-get install -y curl unzip git python3 python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN python3 -m pip install --user ansible

RUN curl -L https://releases.hashicorp.com/terraform/1.5.1/terraform_1.5.1_linux_arm64.zip -o /tmp/terraform.zip \
  && unzip /tmp/terraform.zip \
  && mv terraform /usr/local/bin/

RUN git clone https://github.com/otokki2100/cloud-aws.git /cloud-aws

WORKDIR /cloud-aws/terraform
