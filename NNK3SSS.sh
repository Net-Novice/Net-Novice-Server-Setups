#!/bin/bash

# Update package lists
sudo apt-get update

# Upgrade installed packages
sudo apt-get upgrade -y

# Open the cmdline.txt file for editing
sudo nano /boot/cmdline.txt

# Append cgroup configuration to the end of the file
sudo sed -i '$s/$/ cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

# Reboot the system to apply changes
sudo reboot

# Download and install K3s using the specified URL and token
curl -sfL https://get.k3s.io | K3S_URL=https://10.20.4.102:6443 K3S_TOKEN=K100f7ba1434e4ce373dd21ea6e0bdac2ef88b5bf69c296d3472ff8e7c9eb116ca3::server:e776bc09cf7588a74c2eb7c85db7395f sh -