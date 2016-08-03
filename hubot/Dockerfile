FROM node:0.10.45-slim

ENV DIRENV_VERSION 2.8.1

RUN set -x \
  && mkdir -p /hubot/work

ADD hubot /hubot

RUN cd /hubot && npm cache clean && npm install

RUN set -x \
	&& mkdir -p /direnv/bin \
	&& apt-get update \
	&& apt-get install -y curl \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -fSL -o /direnv/bin/direnv https://github.com/zimbatm/direnv/releases/download/v${DIRENV_VERSION}/direnv.linux-amd64 \
	&& chmod +x /direnv/bin/direnv

ENV PATH /direnv/bin:$PATH

RUN echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc

WORKDIR /hubot

CMD ["/bin/sh","run.sh"]
