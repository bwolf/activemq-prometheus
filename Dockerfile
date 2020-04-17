# Build custom ActiveMQ image with jmx_exporter instrumentation to allow scaping metrics by Prometheus.
# Based on rmohr's activemq Dockerfile.
# See https://github.com/rmohr/docker-activemq.
# See https://github.com/prometheus/jmx_exporter.

FROM rmohr/activemq:5.15.9

ENV ACTIVEMQ_TCP=61616 ACTIVEMQ_AMQP=5672 ACTIVEMQ_STOMP=61613 ACTIVEMQ_MQTT=1883 ACTIVEMQ_WS=61614 ACTIVEMQ_UI=8161
ENV ACTIVEMQ_HOME /opt/activemq

ENV AGENT_VERSION=0.3.0
ENV AGENT_SHA512=af1abc5e9412e62f767d2ece00930b08e749278030ff26a690d721c707b526ca1f99731e75a4f23f5080e7f57b4d61c3e3f8d510b7c0e998e1eb397b1e1ac08c
ENV AGENT_BASE=jmx_prometheus_javaagent
ENV AGENT=$AGENT_BASE-$AGENT_VERSION.jar
ENV AGENT_CONFIG=config.yaml
ENV AGENT_PORT=8080
ENV AGENT_OPTS="-javaagent:/$AGENT=$AGENT_PORT:/config.yaml"

ADD https://repo1.maven.org/maven2/io/prometheus/jmx/$AGENT_BASE/$AGENT_VERSION/$AGENT /
USER root
RUN chmod 0644 /$AGENT && if [ "$AGENT_SHA512" != "$(cd / && sha512sum $AGENT | awk '{print($1)}')" ]; then \
        echo "Agent sha512 value doesn't match! exiting."  && exit 1; \
    fi
COPY $AGENT_CONFIG /

USER activemq
WORKDIR $ACTIVEMQ_HOME
EXPOSE $ACTIVEMQ_TCP $ACTIVEMQ_AMQP $ACTIVEMQ_STOMP $ACTIVEMQ_MQTT $ACTIVEMQ_WS $ACTIVEMQ_UI $AGENT_PORT

ENV ACTIVEMQ_OPTS_MEMORY="-Xms64M -Xmx1G"
ENV ACTIVEMQ_CONF=$ACTIVEMQ_HOME/conf
ENV ACTIVEMQ_OPTS="$AGENT_OPTS $ACTIVEMQ_OPTS_MEMORY -Djava.util.logging.config.file=logging.properties -Djava.security.auth.login.config=$ACTIVEMQ_CONF/login.config"

CMD ["/bin/sh", "-c", "bin/activemq console"]
