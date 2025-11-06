FROM node:25.1.0-slim

# Install system dependencies and Python
RUN apt-get update && apt-get install -y python3 python3-pip git && rm -rf /var/lib/apt/lists/*

# Create non-root user with a stable UID/GID (CI-safe)
RUN groupadd -g 1001 ciuser && useradd -m -u 1001 -g 1001 ciuser

# Copy requirements files
COPY pip-requirements.txt .
COPY galaxy-requirements.yml .

# Install Python packages
RUN pip3 install -r pip-requirements.txt --break-system-packages

# Prepare work directory
WORKDIR /workspaces/arista-fabric
RUN mkdir -p /workspaces/arista-fabric && chown -R ciuser:ciuser /workspaces

# Switch to non-root user
USER ciuser

# Install Ansible collections
RUN ansible-galaxy collection install -r galaxy-requirements.yml

CMD ["bash"]
