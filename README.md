# docker-img-avd

An multi-arch docker image based on node, containing python, ansible, pyavd and the ansible-galaxy arista.avd collection.

This repository contains:

- `Dockerfile` - builds a container from `node:<version>-slim` and installs Python packages and Ansible collections
- `pip-requirements.txt` - specifies Python package versions
- `galaxy-requirements.yml` - specifies Ansible collections to install
- `.github/workflows/docker-build.yml` - GitHub Actions workflow that builds multi-architecture images and pushes to GitHub Container Registry (ghcr.io)

## Image name

Images are published to GitHub Container Registry under the repository path:

```bash
ghcr.io/timherrm/docker-img-avd
```

## Tags produced by the workflow

The workflow creates these tags on each build:

- `avd-<version>` — the AVD collection version installed in the image (e.g. `avd-5.7.2`)
- `avd-<version>-<YYYYMMDDhhmm>` — AVD collection version with build date and time (e.g. `avd-5.7.2-202510231803`)
- `latest` — points to the latest build on `main`

## Pulling the image

```bash
docker pull ghcr.io/timherrm/docker-img-avd:avd-5.7.2
```

## Managing Dependencies

### Python Packages

Python packages and their versions are managed in `pip-requirements.txt`. To add or update Python packages:

1. Edit `pip-requirements.txt`
2. Push to `main`
3. The workflow will build a new image with updated packages

### Ansible Collections

Ansible collections are managed in `galaxy-requirements.yml`. To add or update collections:

1. Edit `galaxy-requirements.yml`
2. Push to `main`
3. The workflow will build a new image with updated collections

## License

See `LICENSE` in this repository.
