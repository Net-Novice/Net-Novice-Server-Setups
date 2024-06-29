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
    chmod +x premetheus-installer-arm.sh
    chmod +x node-exporter-installer-arm.sh
    ```
## Run the script

    ```bash
    sudo ./prometheus-installer-arm.sh
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
