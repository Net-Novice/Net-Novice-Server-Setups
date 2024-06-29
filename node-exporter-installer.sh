#!/bin/bash

# Create system user node_exporter
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter

# Download node_exporter release
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz

# Extract node_exporter binary
tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz

# Move node_exporter binary to /usr/local/bin/
sudo mv node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/

# Clean up extracted files
rm -rf node_exporter*

# Display node_exporter version
node_exporter --version

# Pause for user confirmation before continuing
read -p "Press Enter to continue..."

# Display node_exporter help
node_exporter --help

# Create systemd service file for node_exporter
sudo nano /etc/systemd/system/node_exporter.service

# Add content to /etc/systemd/system/node_exporter.service
# Note: You will need to manually add the service unit content as required.

# Enable and start node_exporter service
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Check status of node_exporter service
sudo systemctl status node_exporter
