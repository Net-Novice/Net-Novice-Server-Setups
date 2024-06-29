Sure, here is the markdown file containing the detailed instructions for setting up Prometheus and Node Exporter on a Raspberry Pi:

```markdown
# Setup Instructions for Prometheus and Node Exporter on Raspberry Pi

## Prerequisites

Ensure you have the necessary tools installed on your Raspberry Pi:
```bash
sudo apt-get update
sudo apt-get install -y wget tar nano
```

## Download and Run Setup Scripts

1. **Download the setup scripts**:
    - Prometheus installer: [prometheus-installer.sh](https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/premetheus-installer-arm.sh)
    - Node Exporter installer: [node-exporter-installer.sh](https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/node-exporter-installer-arm.sh)
    - ```bash
      wget https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/premetheus-installer-arm.sh
      ```
    - ```bash
      wget https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/node-exporter-installer-arm.sh
       ```
2. **Make the scripts executable**:
    ```bash
    chmod +x prometheus-installer.sh
    chmod +x node-exporter-installer.sh
    ```

## Prometheus Setup Script

Update the Prometheus installer script to download the ARM version of Prometheus:

```bash
#!/bin/bash

# Create system user prometheus
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false prometheus

# Download Prometheus release
wget https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-armv7.tar.gz

# Extract Prometheus files
tar -xvf prometheus-2.32.1.linux-armv7.tar.gz

# Create necessary directories
sudo mkdir -p /data /etc/prometheus

# Move Prometheus binaries to /usr/local/bin/
cd prometheus-2.32.1.linux-armv7
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

# Create systemd service file for Prometheus
sudo nano /etc/systemd/system/prometheus.service

# Add content to /etc/systemd/system/prometheus.service
# Note: You will need to manually add the service unit content as required.

# Enable and start Prometheus service
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Check status of Prometheus service
sudo systemctl status prometheus
```

## Node Exporter Setup Script

Update the Node Exporter installer script to download the ARM version of Node Exporter:

```bash
#!/bin/bash

# Create system user node_exporter
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter

# Download node_exporter release
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-armv7.tar.gz

# Extract node_exporter binary
tar -xvf node_exporter-1.3.1.linux-armv7.tar.gz

# Move node_exporter binary to /usr/local/bin/
sudo mv node_exporter-1.3.1.linux-armv7/node_exporter /usr/local/bin/

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
```

## Configure Prometheus to Scrape Node Exporter

1. **Edit the Prometheus configuration file**:
    ```bash
    sudo nano /etc/prometheus/prometheus.yml
    ```
    - Add the following job to the configuration file:
    ```yaml
    ...
      - job_name: node_export
        static_configs:
          - targets: ["localhost:9100"]
    ```

2. **Check the Prometheus configuration**:
    ```bash
    promtool check config /etc/prometheus/prometheus.yml
    ```

3. **Reload Prometheus configuration**:
    ```bash
    curl -X POST http://localhost:9090/-/reload
    ```

## Verify Installation

1. **Check the status of Prometheus**:
    ```bash
    sudo systemctl status prometheus
    ```

2. **Check the status of Node Exporter**:
    ```bash
    sudo systemctl status node_exporter
    ```

Following these steps will set up Prometheus and Node Exporter on your Raspberry Pi, with Prometheus configured to scrape metrics from Node Exporter.
```

This markdown file provides detailed instructions for downloading, running the setup scripts, editing the necessary files, and verifying the installations on a Raspberry Pi.
