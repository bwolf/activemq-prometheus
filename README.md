ActiveMQ with jmx_prometheus_javaagent
======================================

Docker image based on [rmohr/activemq](https://github.com/rmohr/docker-activemq) with [JMX Exporter](https://github.com/prometheus/jmx_exporter) included.
Allows easy integration of ActiveMQ into the [Prometheus](https://prometheus.io) monitoring
system.

## Github
The source repository of the image is on [github](https://github.com/bwolf/activemq-prometheus).

## Versioning
The version of ActiveMQ is hard coded into the `Dockerfile`.

## Building

An automated build is configured via docker hub. To build the image manually and push it:

    docker build --rm -t activemq-prometheus: .
    docker tag activemq-prometheus:5.15.3 bwolf/activemq-prometheus:5.15.3
    docker login # login with username password
    docker push bwolf/activemq-prometheus:5.15.3

The image `bwolf/activemq-prometheus` is located at [docker hub](https://hub.docker.com/r/bwolf/activemq-prometheus/).
