# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## v1.3.0

### Changed

- Updated `@open-rpc/docs-react` from `1.1.5` to `1.2.0`
- Updated `@types/node` from `12.12.36` to `13.13.0`
- Updated `@open-rpc/meta-schema` from `1.6.0` to `1.10.2`
- Updated `react-scripts` from `3.3.0` to `3.4.1`
- Updated `@open-rpc/schema-utils-js` from `1.12.3` to `1.13.0`
- Updated styles for compatible with `@open-rpc/docs-react` `1.2`
- Updated node image from `node:12-alpine` to `node:13-alpine`

## v1.2.0

### Changed

- User in dockerfile now `node` (previously used `root`)
- Files owner (that added during image building) changed `root` &rarr; `node`
- All files from branch `image-1.1` moved into `master` branch
- GitHub actions uses **latest** example from `open-rpc/examples` repository (previously version was fixed)
- Usage examples in readme file
- Building rules on `hub.docker.com`

### Added

- Changelog linting using GitHub actions

## v1.1.0

### Added

- [Open rpc][open-rpc] documentation builder
- Image with component version `~1.1` (branch `image-1.1`) with docker tag `1.1`

[keepachangelog]:https://keepachangelog.com/en/1.0.0/
[semver]:https://semver.org/spec/v2.0.0.html
