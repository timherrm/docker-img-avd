FROM node:26.13.1-trixie-slim

# Install system dependencies and Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip git jq vim bash-completion && \
    rm -rf /var/lib/apt/lists/*

# Replace default node user with ciuser (UID/GID 1000)
RUN userdel -r node && \
    groupdel node && \
    groupadd -g 1000 ciuser && \
    useradd -m -u 1000 -g 1000 ciuser

# Copy requirements files
COPY pip-requirements.txt .

# Install Python packages
RUN pip3 install -r pip-requirements.txt --break-system-packages

# Prepare work directory
WORKDIR /workspaces/arista-fabric
RUN mkdir -p /workspaces/arista-fabric && \
    chown -R 1001:1001 /workspaces

# Enable passwordless root access
# RUN passwd -d root

# Switch to non-root user
USER ciuser

# Copy requirements files
COPY requirements.yml .

# Install Ansible collections
RUN ansible-galaxy collection install -r requirements.yml

# Verify installations
RUN node --version && \
    python3 --version && \
    git --version && \
    ansible --version && \
    ansible-galaxy collection list

CMD ["bash"]
