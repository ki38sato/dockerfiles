FROM node:6.9.1

ENV ENTRYKIT_VERSION 0.4.0

RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends python sudo \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python \
	&& find /usr/local -depth \
		\( \
		    \( -type d -a -name test -o -name tests \) \
		    -o \
		    \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		\) -exec rm -rf '{}' + \
  && pip install supervisor \
  && mkdir -p /etc/supervisord.d \
  && mkdir -p /hubot/work \
  && mkdir -p /hubot/logs \
	&& groupadd -g 3001 hubot \
	&& useradd -M -c "hubot user" -g hubot -d /hubot -s /bin/bash -u 3001 hubot \
	&& wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
	&& tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
	&& rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
	&& mv entrykit /bin/entrykit \
	&& chmod +x /bin/entrykit \
	&& entrykit --symlink


ADD supervisord/supervisord.conf /etc/supervisord.conf
ADD supervisord/hubot.conf /etc/supervisord.d/hubot.conf
ADD supervisord/sysconfig_supervisord /etc/sysconfig/supervisord
ADD hubot /hubot

RUN cd /hubot \
	&& npm cache clean \
	&& npm install \
	&& chown -R hubot:hubot /hubot \
	&& chmod +x bin/hubot

EXPOSE 3456

WORKDIR /hubot

CMD ["--nodaemon","-c","/etc/supervisord.conf"]

ENTRYPOINT [ \
    "render", "/hubot/run.sh", "--", \
    "prehook", "chmod +x /hubot/run.sh", "--", \
    "/usr/local/bin/supervisord" \
]
