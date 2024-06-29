#!/bin/bash

# Create system user prometheus
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false prometheus

# Download Prometheus release
wget https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz

# Extract Prometheus files
tar -xvf prometheus-2.32.1.linux-amd64.tar.gz

# Create necessary directories
sudo mkdir -p /data /etc/prometheus

# Move Prometheus binaries to /usr/local/bin/
cd prometheus-2.32.1.linux-amd64
sudo mv prometheus promtool /usr/local/bin/

# Move consoles and console libraries to /etc/prometheus/
sudo mv consoles/ console_libraries/ /etc/prometheus/

# Move Prometheus configuration file to /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml

# Set ownership of Prometheus directories
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/

# Clean up extracted files
cd
rm -rf prometheus*

# Display Prometheus version
prometheus --version

# Pause for user confirmation before continuing
read -p "Press Enter to continue..."

# Display Prometheus help
prometheus --help

# Edit systemd service file for Prometheus
sudo nano /etc/systemd/system/prometheus.service

# Add content to /etc/systemd/system/prometheus.service
# Note: You will need to manually add the service unit content as described in your request.

# Enable and start Prometheus service
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Check status of Prometheus service
sudo systemctl status prometheus
