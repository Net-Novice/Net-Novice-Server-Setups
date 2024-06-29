# Setup Instructions for Prometheus and Node Exporter

## Download and Run Setup Scripts

1. **Download the setup scripts**:
    - Prometheus installer: [prometheus-installer.sh](https://github.com/Net-Novice/Net-Novice-Server-Setups/blob/main/prometheus-installer.sh)
    - Node Exporter installer: [node-exporter-installer.sh](https://github.com/Net-Novice/Net-Novice-Server-Setups/blob/main/node-exporter-installer.sh)

2. **Make the scripts executable**:
    ```bash
    chmod +x prometheus-installer.sh
    chmod +x node-exporter-installer.sh
    ```

3. **Run the Prometheus setup script**:
    ```bash
    sudo ./prometheus-installer.sh
    ```

4. **Pause to edit the Prometheus service file**:
    - When the script pauses, open the service file for editing:
    ```bash
    sudo nano /etc/systemd/system/prometheus.service
    ```
    - Add the following content to `/etc/systemd/system/prometheus.service`:
    ```ini
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
    - Save and exit the editor.

5. **Run the Node Exporter setup script**:
    ```bash
    sudo ./node-exporter-installer.sh
    ```

6. **Pause to edit the Node Exporter service file**:
    - When the script pauses, open the service file for editing:
    ```bash
    sudo nano /etc/systemd/system/node_exporter.service
    ```
    - Add the following content to `/etc/systemd/system/node_exporter.service`:
    ```ini
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
    - Save and exit the editor.

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

Following these steps will set up Prometheus and Node Exporter on your system, with Prometheus configured to scrape metrics from Node Exporter.
