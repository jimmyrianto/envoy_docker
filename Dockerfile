FROM envoyproxy/envoy:latest
LABEL Author=JimmyRianto

RUN \
  apt-get update \
  && apt-get install -y \
    curl
    
# RUN apt-get update
# RUN apt-get install curl wget

COPY ./app /app
WORKDIR /app

RUN curl -L https://getenvoy.io/cli | bash -s -- -b /usr/local/bin
RUN getenvoy run standard:1.11.1 -- --config-path ./front-proxy.yaml
