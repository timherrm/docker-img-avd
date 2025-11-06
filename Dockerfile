FROM node:25.0.0-slim

# Install system dependencies and Python
RUN apt-get update && apt-get install -y python3 python3-pip git && rm -rf /var/lib/apt/lists/*

# Copy requirements files
COPY pip-requirements.txt .
COPY galaxy-requirements.yml .

# Install Python packages
RUN pip3 install -r pip-requirements.txt --break-system-packages

# Install Ansible collections
RUN ansible-galaxy collection install -r galaxy-requirements.yml

# Verify installations
RUN node --version && python3 --version && git --version && ansible --version && pip freeze && ansible-galaxy collection list

# Set working directory
WORKDIR /workspaces/arista-fabric

CMD ["bash"]
