FROM java:8-jre

ENV EMBULK_VERSION 0.8.12
ENV DIRENV_VERSION 2.9.0
ENV PECO_VERSION 0.3.6
ENV GHQ_VERSION 0.7.4

ENV PATH /embulk:/terraform/bin:/direnv/bin:/peco/bin:/ghq/bin:$PATH

RUN set -x \
  && apt-get update \
  && apt-get install -y unzip curl git \
  && mkdir /embulk \
  && curl -L https://bintray.com/artifact/download/embulk/maven/embulk-${EMBULK_VERSION}.jar -o /embulk/embulk \
  && chmod +x /embulk/embulk \
  && embulk gem install embulk-input-s3 \
  && embulk gem install embulk-output-elasticsearch \
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

WORKDIR /data

CMD ["/bin/bash"]
