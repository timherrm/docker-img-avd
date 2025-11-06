FROM node:25.0.0-slim

# Image description
ARG IMAGE_DESCRIPTION="An docker image based on node, containing python, ansible, pyavd and the ansible-galaxy arista.avd collection."

# Install system dependencies and Python
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements files
COPY pip-requirements.txt .

# Install Python packages
RUN pip3 install -r pip-requirements.txt --break-system-packages

# Copy requirements files
COPY galaxy-requirements.yml .

# Install Ansible collections
RUN ansible-galaxy collection install -r galaxy-requirements.yml

# OCI label: description (recommended for registry UI and multi-arch manifests)
LABEL org.opencontainers.image.description="${IMAGE_DESCRIPTION}"

# Verify installations
RUN node --version && \
    python3 --version && \
    git --version && \
    ansible --version

# Set working directory
WORKDIR /workspaces/arista-fabric

CMD ["bash"]
