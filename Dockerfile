FROM python:3.11-slim-bullseye
LABEL MAINTAINER="KML Vision, devops@kmlvision.com"

RUN apt-get update -q && \
    apt-get install --no-install-recommends -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

# install sonar scanner
ENV SONAR_HOME="/opt/sonar-scanner"
RUN curl --insecure -OL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610-linux-x64.zip && \
    mkdir -p ${SONAR_HOME} && \
    unzip -d /tmp/sonar-scanner sonar-scanner-cli-6.2.1.4610-linux-x64.zip && \
    mv /tmp/sonar-scanner/sonar-scanner-6.2.1.4610-linux-x64//* ${SONAR_HOME} && \
    rm -rf /tmp/sonar*

ENV PATH="${SONAR_HOME}/bin:$PATH"

RUN sonar-scanner --version