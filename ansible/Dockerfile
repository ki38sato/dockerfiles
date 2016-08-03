FROM python:2.7.11-slim

ENV ANSIBLE_VERSION 1.9.6
ENV DIRENV_VERSION 2.8.1
ENV PECO_VERSION 0.3.6
ENV GHQ_VERSION 0.7.4

ADD ansible_vault_pass /etc/ansible/ansible_vault_pass
ADD requirements.txt requirements.txt

RUN set -ex \
	&& buildDeps=' \
		gcc \
		python-dev \
		libffi-dev \
		libssl-dev \
	' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& apt-get install -y openssh-server sshpass \
	&& rm -rf /var/lib/apt/lists/* \
	&& pip install boto boto3 \
	&& pip install ansible==$ANSIBLE_VERSION \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& mkdir -p /etc/ansible \
	&& mkdir -p /data/stanby-ansible-repo \
	&& pip install --no-cache-dir -r requirements.txt \
	&& chmod 0600 /etc/ansible/ansible_vault_pass \
	&& mkdir -p /direnv/bin \
  && apt-get update \
  && apt-get install -y unzip curl git \
  && rm -rf /var/lib/apt/lists/* \
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

ENV PATH /direnv/bin:/peco/bin:/ghq/bin:$PATH

WORKDIR /data

CMD ["/bin/bash"]
