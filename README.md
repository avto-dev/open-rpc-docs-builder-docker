<div align="center">
  <img src="https://habrastorage.org/webt/bl/zs/iw/blzsiwdibuwuxbrz4sfx2av0pew.png" alt="App Logotype" width="100" />
</div>

# OpenRPC documentation builder

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

## Docker usage example

```dockerfile
FROM avto-dev/openrpc-docs-builder:latest AS builder

# Copy openrpc.json file into /app/src/schemas derictory
COPY ./openrpc.json /app/src/schemas

# You can copy additional json-schema files into public directory
COPY ./schemas/json-schema /app/public/schema

RUN yarn run build

FROM alpine:latest

COPY --from=builder /app/build /public
```

[OpenRPC]:https://spec.open-rpc.org/
[openrpc-docs-react]:https://github.com/open-rpc/docs-react
[create-react-app]:https://github.com/facebook/create-react-app