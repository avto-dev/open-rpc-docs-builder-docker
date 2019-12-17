<div align="center">
  <img src="https://habrastorage.org/webt/bl/zs/iw/blzsiwdibuwuxbrz4sfx2av0pew.png" alt="App Logotype" width="100" />
</div>

# OpenRPC documentation builder

[![Build][badge_automated]][link_hub]
[![Build][badge_build]][link_hub]
[![Docker Pulls][badge_pulls]][link_hub]
[![Issues][badge_issues]][link_issues]
[![License][badge_license]][link_license]

This tool build documentation from [OpenRPC] schema.
It based on [OpenRPC docs-react][openrpc-docs-react] component and [create-react-app].

You must put open-rpc schema into `src/schema/openrpc.json` file, then run `yarn run build`.  

Also you can put any additional files into `public` directory,
all files from `public` will be moved into `build` directory with built documentation.

## Environment variables

Tool support all environment variables from [create-react-app]

### Additional variables

Name | Possible values | Default | Description
:---:|:---:|:---:|:---
`REACT_APP_THEME` | `dark`,`light` | `light` | Theme of application

## Examples

### Build using volumes

```shell script
container_id=$(docker run -v /puth/to/schema/folder:/app/src/schema:ro avto-dev/open-rpc-docs-builder:latest yarn run build)

docker cp $container_id:/build/. $(pwd)/public
```

### Docker usage example

```dockerfile
FROM avto-dev/open-rpc-docs-builder:latest AS builder

# Copy openrpc.json file into /app/src/schemas derictory
COPY ./openrpc.json /app/src/schemas

# You can copy additional json-schema files into public directory
COPY ./schemas/json-schema /app/public/schema

RUN yarn run build

# Optional you can copy built documentation into any other container (e.g nginx)
FROM alpine:latest

COPY --from=builder /app/build /public
```

[OpenRPC]:https://spec.open-rpc.org/
[openrpc-docs-react]:https://github.com/open-rpc/docs-react
[create-react-app]:https://github.com/facebook/create-react-app
[badge_automated]:https://img.shields.io/docker/automated/avto-dev/open-rpc-docs-builder.svg?style=flat-square&maxAge=30
[badge_pulls]:https://img.shields.io/docker/pulls/avto-dev/open-rpc-docs-builder.svg?style=flat-square&maxAge=30
[badge_issues]:https://img.shields.io/github/issues/avto-dev/open-rpc-docs-builder.svg?style=flat-square&maxAge=30
[badge_build]:https://img.shields.io/docker/build/avto-dev/open-rpc-docs-builder.svg?style=flat-square&maxAge=30
[badge_license]:https://img.shields.io/github/license/avto-dev/open-rpc-docs-builder.svg?style=flat-square&maxAge=30
[link_hub]:https://hub.docker.com/r/avto-dev/open-rpc-docs-builder/
[link_license]:https://github.com/avto-dev/open-rpc-docs-builder/blob/master/LICENSE
[link_issues]:https://github.com/avto-dev/open-rpc-docs-builder/issues
