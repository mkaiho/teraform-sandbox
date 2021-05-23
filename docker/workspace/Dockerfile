FROM debian:buster-slim

ARG awscli_version="2.2.5"

WORKDIR /home/devuser/terraform-cli/terraform

RUN apt-get update && apt-get install -y \
gnupg software-properties-common curl unzip

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${awscli_version}.zip -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install \
&& rm -i awscliv2.zip \
&& aws --version

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
&& apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
&& apt-get update && apt-get install terraform \
&& terraform --version

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
&& chmod +x ./kubectl \
&& mv ./kubectl /usr/local/bin/kubectl \
&& kubectl version --client

RUN groupadd -r terraform && useradd -r -g terraform devuser
USER devuser
