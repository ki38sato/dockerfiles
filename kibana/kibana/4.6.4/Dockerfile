FROM kibana:4.6.4
RUN kibana plugin -i elasticsearch/marvel \
  && kibana plugin -i elastic/sense \
  && kibana plugin -i elastic/timelion \
  && kibana plugin --install sentinl -u https://github.com/sirensolutions/sentinl/releases/download/snapshot/sentinl-latest.tar.gz
