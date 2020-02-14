FROM debian:9.6-slim
LABEL Author=JimmyRianto

RUN \
  apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
    software-properties-common \
    curl \
    ca-certificates \
    apt-transport-https \
    gnupg2
    
RUN curl -sL 'https://getenvoy.io/gpg' | apt-key add -
RUN apt-key fingerprint 6FF974DB
RUN add-apt-repository \
        "deb [arch=amd64] https://dl.bintray.com/tetrate/getenvoy-deb \
        $(lsb_release -cs) \
        stable"

RUN apt-get update
RUN apt-get install -y getenvoy-envoy
RUN envoy --version

COPY ./app /app
WORKDIR /app

RUN curl -L https://getenvoy.io/cli | bash -s -- -b /usr/local/bin
CMD getenvoy run standard:1.11.1 -- --config-path ./front-envoy.yaml
