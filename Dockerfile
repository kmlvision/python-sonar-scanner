FROM python:3.13-slim-bookworm
LABEL MAINTAINER="KML Vision, devops@kmlvision.com"

RUN apt-get update -q && \
    apt-get install --no-install-recommends -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

RUN pip install poetry==2.1.4

# install sonar scanner
ENV SONAR_VERSION=7.2.0.5079
ENV SONAR_HOME="/opt/sonar-scanner"
RUN curl --insecure -OL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_VERSION}-linux-x64.zip && \
    mkdir -p ${SONAR_HOME} && \
    unzip -d /tmp/sonar-scanner sonar-scanner-cli-${SONAR_VERSION}-linux-x64.zip && \
    mv /tmp/sonar-scanner/sonar-scanner-${SONAR_VERSION}-linux-x64/* ${SONAR_HOME} && \
    rm -rf /tmp/sonar*

ENV PATH="${SONAR_HOME}/bin:$PATH"

RUN sonar-scanner --version
