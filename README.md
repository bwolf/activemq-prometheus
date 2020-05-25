# ActiveMQ with jmx_prometheus_javaagent

Docker image based on [rmohr/activemq](https://github.com/rmohr/docker-activemq) with the [JMX Exporter](https://github.com/prometheus/jmx_exporter) included. This allows the easy integration of ActiveMQ into [Prometheus](https://prometheus.io).


## Github
The source repository of the image is on [github](https://github.com/bwolf/activemq-prometheus).


## Versioning
The version of ActiveMQ is hard coded into the `Dockerfile`.

## Container Images
Images can be found at [docker hub](https://hub.docker.com/r/bwolf/activemq-prometheus).


## Building
An automated build is configured via Docker hub. To build the image manually:

    docker build --rm -t you/activemq-prometheus:latest .
