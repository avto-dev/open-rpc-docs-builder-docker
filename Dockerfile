FROM node:13-alpine

LABEL \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="Open rpc documentation builder" \
  org.label-schema.description="Tool for build documentation from open rpc schema" \
  org.label-schema.version="1.1" \
  org.label-schema.vendor="avto-dev" \
  org.label-schema.vcs-url="https://github.com/avto-dev/open-rpc-docs-builder-docker"

RUN set -x \
    && mkdir /app \
    && chown node:node /app

USER node:node

COPY --chown=node ./public /app/public
COPY --chown=node ./src /app/src
COPY --chown=node ./package.json /app
COPY --chown=node ./tsconfig.json /app

WORKDIR /app

RUN set -x \
  && yarn install --network-timeout 100000 --production=true \
  && yarn list --pattern 'open-rpc'
