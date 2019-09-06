FROM python:3.7-slim-stretch
LABEL MAINTAINER="KML Vision, devops@kmlvision.com"

# install OpenJDK-8
RUN apt-get update -q && \
    apt-get install --no-install-recommends -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# install sonar scanner
ENV SONAR_HOME "/opt/sonar-scanner"
RUN curl --insecure -OL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip && \
    mkdir -p ${SONAR_HOME} && \
    unzip -d /tmp/sonar-scanner sonar-scanner-cli-4.0.0.1744-linux.zip && \
    mv /tmp/sonar-scanner/sonar-scanner-4.0.0.1744-linux/* ${SONAR_HOME} && \
    rm -rf /tmp/sonar*

ENV PATH ${SONAR_HOME}/bin:$PATH

RUN sonar-scanner --version