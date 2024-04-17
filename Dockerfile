FROM python:3.11-slim
LABEL MAINTAINER="KML Vision, devops@kmlvision.com"

RUN apt-get update -q && \
    apt-get install --no-install-recommends -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# install sonar scanner
ENV SONAR_HOME "/opt/sonar-scanner"
RUN curl --insecure -OL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    mkdir -p ${SONAR_HOME} && \
    unzip -d /tmp/sonar-scanner sonar-scanner-cli-5.0.1.3006-linux.zip && \
    mv /tmp/sonar-scanner/sonar-scanner-5.0.1.3006-linux/* ${SONAR_HOME} && \
    rm -rf /tmp/sonar*

ENV PATH ${SONAR_HOME}/bin:$PATH

RUN sonar-scanner --version