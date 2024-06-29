#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install Prometheus
echo "Installing Prometheus..."
wget https://github.com/prometheus/prometheus/releases/download/v2.41.0/prometheus-2.41.0.linux-amd64.tar.gz
tar -xvf prometheus-2.41.0.linux-amd64.tar.gz
sudo mv prometheus-2.41.0.linux-amd64 /usr/local/prometheus

# Create Prometheus user
sudo useradd --no-create-home --shell /bin/false prometheus

# Set ownership of Prometheus files
sudo chown -R prometheus:prometheus /usr/local/prometheus

# Create Prometheus configuration directory
sudo mkdir /etc/prometheus
sudo mv /usr/local/prometheus/prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

# Create Prometheus service file
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd services and start Prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Install Node Exporter
echo "Installing Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar -xvf node_exporter-1.5.0.linux-amd64.tar.gz
sudo mv node_exporter-1.5.0.linux-amd64 /usr/local/node_exporter

# Create Node Exporter user
sudo useradd --no-create-home --shell /bin/false node_exporter

# Set ownership of Node Exporter files
sudo chown -R node_exporter:node_exporter /usr/local/node_exporter

# Create Node Exporter service file
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd services and start Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Clean up
rm prometheus-2.41.0.linux-amd64.tar.gz
rm node_exporter-1.5.0.linux-amd64.tar.gz

echo "Prometheus and Node Exporter installation completed."
