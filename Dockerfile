FROM ghcr.io/aristanetworks/avd/universal:python3.11-avd-v5.2.3

# Image description
ARG IMAGE_DESCRIPTION="A docker image based on the AVD universal image, but including Node.js"

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

RUN apt-get update && apt-get install -y \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# OCI label: description (recommended for registry UI and multi-arch manifests)
LABEL org.opencontainers.image.description="${IMAGE_DESCRIPTION}"

CMD ["bash"]