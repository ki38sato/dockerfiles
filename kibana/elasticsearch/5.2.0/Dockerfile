FROM elasticsearch:5.2.0

ENV ENTRYKIT_VERSION 0.4.0

RUN set -x \
	&& groupadd -g 3002 esuser \
	&& useradd -M -c "elasticsearch execute user" -g esuser -s /bin/bash -u 3002 esuser \
	&& /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji \
	&& /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu \
#	&& /usr/share/elasticsearch/bin/elasticsearch-plugin install delete-by-query \
	&& /usr/share/elasticsearch/bin/elasticsearch-plugin install discovery-ec2 \
	&& /usr/share/elasticsearch/bin/elasticsearch-plugin install repository-s3 \
	&& wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
	&& tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
	&& rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
	&& mv entrykit /bin/entrykit \
	&& chmod +x /bin/entrykit \
	&& entrykit --symlink

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

RUN set -ex \
	&& for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R esuser:esuser "$path"; \
	done

WORKDIR /usr/share/elasticsearch

COPY config ./config

ENTRYPOINT [ \
		"render", "/usr/share/elasticsearch/config/elasticsearch.yml", "--", \
		"/docker-entrypoint.sh" \
]
CMD ["elasticsearch"]