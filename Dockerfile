FROM tarampampam/node:12-alpine
LABEL Description="%%app_name%% application" Vendor="dev@avtocod.ru"

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --production=true

COPY . ./
