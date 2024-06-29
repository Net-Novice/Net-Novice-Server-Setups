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
    ## Run the script:

    ```bash
    sudo ./premetheus-installer-arm.sh
    ```
    ```service
    [Unit]
    Description=Prometheus
    Wants=network-online.target
    After=network-online.target
    
    StartLimitIntervalSec=500
    StartLimitBurst=5
    
    [Service]
    User=prometheus
    Group=prometheus
    Type=simple
    Restart=on-failure
    RestartSec=5s
    ExecStart=/usr/local/bin/prometheus \
      --config.file=/etc/prometheus/prometheus.yml \
      --storage.tsdb.path=/data \
      --web.console.templates=/etc/prometheus/consoles \
      --web.console.libraries=/etc/prometheus/console_libraries \
      --web.listen-address=0.0.0.0:9090 \
      --web.enable-lifecycle
    
    [Install]
    WantedBy=multi-user.target
    ```

    ```bash
    sudo ./node-exporter-installer-arm.sh
    ```

    ```service
    [Unit]
    Description=Node Exporter
    Wants=network-online.target
    After=network-online.target
    
    StartLimitIntervalSec=500
    StartLimitBurst=5
    
    [Service]
    User=node_exporter
    Group=node_exporter
    Type=simple
    Restart=on-failure
    RestartSec=5s
    ExecStart=/usr/local/bin/node_exporter \
        --collector.logind
    
    [Install]
    WantedBy=multi-user.target
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
