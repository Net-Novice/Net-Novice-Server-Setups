# Net Novice Servers prettiest and maintenance docs

# Servers

## Net-Novice-File-01
- Docker
  - Portainer-Ce
  - Net-Novice-Main
  - Net-Novice-1337
  - Net-Novice-1338

## Net-Novice-WebBK-01
- Docker
  - Portainer-Agent
  - Net-Novice-Main-BK
  - Net-Novice-1337-BK
  - Net-Novice-1338-BK

# Cloudflare
- Cloudflare Tunnels
  - Net-Novice-Main-01
    - Selfhosted Websites
  - Net-Novice-Main-02
    - Testing Selfhosted Websites
  - Net-Novice-Web-01
    - For Main and client websites

# Docker Scripts

## Websites

```bash
version: '3'

services:
  apache:
    image: php:apache
    ports:
      - 46732:80
    volumes:
      - /mnt/Drive-1/websites/Main:/var/www/html
      - /home/pi/docker/apache/net-novice-main/apache2.conf:/etc/apache2/apache2.conf
    restart: unless-stopped

````

# Backups

## Websites

- Production websites should be backed up to Google Drive every week remove old backups after 2 months

- Client websites should be backed up to Google Drive every day remove old backups after 2 weeks

## Database

- Databases for production servers should be backed up every 4 hours backups stored on Google Drive remove old backups after 1 week

- Databases for client servers should be backed up every week backups stored on Google Drive remove old backups after 3 weeks

# Server Set Up

## Production Servers

- Initial setup script:
  ```bash
  wget https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/NNBPSSS.sh && sudo bash NNBPSSS.sh
  ````
  
- Prometheus Setup Scrip
  ````bash
  wget https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/NNPSS.sh && sudo bash NNBTSSS.sh
  ````
  
- K3S
  ```bash
  wget https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/NNK3SSS.sh && sudo bash NNK3SSS.sh
  ````
## Test Servers
- Initial setup script:
  ````bash
  wget https://raw.githubusercontent.com/Net-Novice/Net-Novice-Server-Setups/main/NNBTSSS.sh && sudo bash NNBTSSS.sh

  ````

# Maintenance

## Updates
- Auto update should be enabled on all production servers
- Manual ````sudo apt update && sudo apt upgrade -y```` should be run once a mount
