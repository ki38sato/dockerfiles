FROM debian:jessie

ENV TERRAFORM_VERSION 0.7.4
ENV DIRENV_VERSION 2.9.0
ENV PECO_VERSION 0.3.6
ENV GHQ_VERSION 0.7.4

RUN set -x \
	&& apt-get update \
	&& apt-get install -y unzip curl git \
	&& curl -fSL -o terraform.zip  https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& mkdir -p /terraform/bin \
	&& unzip terraform.zip -d /terraform/bin \
	&& rm terraform.zip \
	&& mkdir -p /direnv/bin \
	&& curl -fSL -o /direnv/bin/direnv https://github.com/zimbatm/direnv/releases/download/v${DIRENV_VERSION}/direnv.linux-amd64 \
	&& chmod +x /direnv/bin/direnv \
	&& mkdir -p /peco/bin \
	&& curl -fSL -o peco_linux_amd64.tar.gz https://github.com/peco/peco/releases/download/v${PECO_VERSION}/peco_linux_amd64.tar.gz \
	&& tar xzf peco_linux_amd64.tar.gz \
	&& mv peco_linux_amd64/peco /peco/bin/peco \
	&& rm -rf peco_linux_amd64* \
	&& mkdir -p /ghq/bin \
	&& curl -fSL -o /tmp/ghq_linux_amd64.zip https://github.com/motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_amd64.zip \
	&& cd /tmp \
	&& unzip /tmp/ghq_linux_amd64.zip \
	&& mv /tmp/ghq /ghq/bin/ghq \
	&& rm -rf /tmp/* \
	&& apt-get -y --purge remove unzip

ENV PATH /terraform/bin:/direnv/bin:/peco/bin:/ghq/bin:$PATH

WORKDIR /data

CMD ["/bin/bash"]
