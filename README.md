<div align="center">
  <img src="https://hsto.org/webt/nc/kx/au/nckxaurura8zfd6pxx5vdh_ssw4.png" alt="Logo" width="120" />
</div>

# OpenRPC documentation builder

[![Build][badge_automated]][link_hub]
[![Build][badge_build]][link_hub]
[![Test Status][badge_test]][link_test]
[![Docker Pulls][badge_pulls]][link_hub]
[![Issues][badge_issues]][link_issues]
[![License][badge_license]][link_license]

This tool build documentation from [OpenRPC] schema. It based on [OpenRPC docs-react][openrpc-docs-react] component and [create-react-app].

You must put open-rpc schema into `/app/src/schema/openrpc.json` file, then run `yarn run build`.  

Also you can put any additional files into `public` directory, all files from `public` will be moved into `build` directory with built documentation.

## Environment variables

Tool support all environment variables from [create-react-app]

### Additional variables

Name              | Possible values | Default | Description
:---------------: | :-------------: | :-----: | :----------------
`REACT_APP_THEME` | `dark`, `light` | `light` | Application theme

## Examples

All supported docker tags [can be found here][link_hub_tags].

### Build using volumes

Run into your shell (your open-rpc schema must be located in `./path/to/your/openrpc.json`):

```shell script
$ mkdir ./public # create directory for generated assets

$ docker run \
    --rm \
    --user "$(id -u):$(id -g)" \
    -v $(pwd)/path/to/your/openrpc.json:/app/src/schema/openrpc.json:ro \
    -v $(pwd)/public:/app/build:rw \
    avtodev/open-rpc-docs-builder:1.2 \
    yarn run build
```

And then watch into `./public` directory.

### Docker usage example

```dockerfile
FROM avtodev/open-rpc-docs-builder:1.2 AS builder

# Copy openrpc.json file into `/app/src/schemas` derictory
COPY --chown=node ./openrpc.json /app/src/schemas/openrpc.json
# You can copy additional json-schema files into public directory
COPY --chown=node ./schemas/json-schema /app/public/schema

RUN yarn run build

# Optional you can copy built documentation into any other container (eg.: nginx)
FROM alpine:latest

COPY --from=builder /app/build /public
```

## Releasing

New versions publishing is very simple - just update dependencies version(s) in `./package.json` file (or make any another changes) and "publish" new release using repo releases page. This action will trigger docker images (re)building (eg.: release `v1.2.3` will create or update docker images with tags `1.2` and `1.2.3`).

> Release version _(and git tag, of course)_ MUST starts with `v` prefix (eg.: `v0.0.1` or `v1.2.3`) and follows semantic versioning rules
>
> Do not forget to update docker image version tag in "usage example" above

### License

MIT. Use anywhere for your pleasure.

[OpenRPC]:https://spec.open-rpc.org/
[openrpc-docs-react]:https://github.com/open-rpc/docs-react
[create-react-app]:https://github.com/facebook/create-react-app
[badge_automated]:https://img.shields.io/docker/cloud/automated/avtodev/open-rpc-docs-builder.svg?maxAge=30
[badge_pulls]:https://img.shields.io/docker/pulls/avtodev/open-rpc-docs-builder.svg?maxAge=30
[badge_issues]:https://img.shields.io/github/issues/avto-dev/open-rpc-docs-builder-docker.svg?maxAge=30
[badge_build]:https://img.shields.io/docker/cloud/build/avtodev/open-rpc-docs-builder.svg?maxAge=30
[badge_license]:https://img.shields.io/github/license/avto-dev/open-rpc-docs-builder-docker.svg?maxAge=30
[badge_test]:https://img.shields.io/github/workflow/status/avto-dev/open-rpc-docs-builder-docker/build?maxAge=30&logo=github
[link_test]:https://github.com/avto-dev/open-rpc-docs-builder-docker/actions
[link_hub]:https://hub.docker.com/r/avtodev/open-rpc-docs-builder
[link_hub_tags]:https://hub.docker.com/r/avtodev/open-rpc-docs-builder/tags
[link_license]:https://github.com/avto-dev/open-rpc-docs-builder-docker/blob/master/LICENSE
[link_issues]:https://github.com/avtodev/open-rpc-docs-builder-docker/issues
