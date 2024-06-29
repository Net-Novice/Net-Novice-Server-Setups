#!/bin/bash

# Step 1: Install Prometheus
echo "Installing Prometheus..."
wget https://github.com/prometheus/prometheus/releases/download/v2.35.0/prometheus-2.35.0.linux-amd64.tar.gz
tar -xzf prometheus-2.35.0.linux-amd64.tar.gz
cd prometheus-2.35.0.linux-amd64
sudo cp prometheus promtool /usr/local/bin/
sudo cp -r consoles/ console_libraries/ /etc/prometheus/
sudo cp prometheus.yml /etc/prometheus/prometheus.yml

# Step 2: Install Node Exporter
echo "Installing Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar -xzf node_exporter-1.2.2.linux-amd64.tar.gz
cd node_exporter-1.2.2.linux-amd64
sudo cp node_exporter /usr/local/bin/

# Step 3: Configure Prometheus to scrape Node Exporter
echo "Configuring Prometheus..."
sudo tee /etc/prometheus/prometheus.yml > /dev/null << 'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
EOF

# Step 4: Start Prometheus and Node Exporter
echo "Starting Prometheus and Node Exporter..."
sudo systemctl restart prometheus
sudo systemctl enable prometheus
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Step 5: Install Grafana (optional)
echo "Installing Grafana..."
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

echo "Setup completed!"
echo "Prometheus is running on http://localhost:9090"
echo "Node Exporter is running on http://localhost:9100"
echo "Grafana is running on http://localhost:3000"
echo "Login to Grafana using admin/admin and configure Prometheus as a data source."
