# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## v1.2.0

### Changed

- User in dockerfile now `node` (previously used `root`)
- Added files owner changed `root` &rarr; `node`
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
