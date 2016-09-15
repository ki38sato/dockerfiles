FROM node:6.4.0

ENV PYTHON_VERSION 2.7.11

RUN set -ex \
	&& apt-get update \
	&& apt-get install python sudo -y --no-install-recommends \
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
	&& useradd -M -c "hubot user" -g hubot -d /hubot -s /bin/bash -u 3001 hubot

ADD supervisord/supervisord.conf /etc/supervisord.conf
ADD supervisord/hubot.conf /etc/supervisord.d/hubot.conf
ADD supervisord/sysconfig_supervisord /etc/sysconfig/supervisord
ADD hubot /hubot

RUN cd /hubot \
	&& npm cache clean \
	&& npm install \
	&& chown -R hubot:hubot /hubot \
	&& chmod +x /hubot/run.sh \
	&& chmod +x bin/hubot

EXPOSE 9001

WORKDIR /hubot

CMD ["/usr/local/bin/supervisord","--nodaemon","-c","/etc/supervisord.conf"]
