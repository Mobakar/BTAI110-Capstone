
## Overview
This project contains a shell script designed to automate system updates on Linux systems using `apt`. It ensures security through preliminary checks (internet connectivity, disk space), applies updates safely, logs detailed activity, and is meant to be scheduled weekly using cron.

## Features
- Verifies internet connectivity before proceeding
- Ensures at least 1GB free disk space
- Runs `apt update`, `apt upgrade`, and cleanup commands
- Logs all output to timestamped log files
- Designed for unattended updates while preserving system integrity

## Usage Instructions

### Prerequisites
- Linux system with `apt` package manager
- Script must be run with root privileges (`sudo`)
- Network connection and sufficient disk space

### Execute Manually
sudo ~/myproject/scripts/update_system.sh

### Schedule Weekly via Cron
- Open your crontab:
- run sudo crontab -e
- Add the following line to schedule the script every Sunday at 2 AM:
0 2 * * 0 /home/abucyber/myproject/scripts/update_system.sh
#Note:  you can schedule it to run at a time of your choosing by modifying the cron

#Logging
Logs are saved in ~/myproject/logs/update.log with the format:
update-YYYY-MM-DD_HH-MM-SS.log
Each log includes:
- Script metadata (user, hostname, timestamp)
- Status of internet and disk checks
- Update and upgrade results
- Summary of packages

You can also audit logs in /var/log/apt

#Security Notes
- Unattended upgrade uses the --yes flag for simplicity
- Always review logs to catch upgrade errors


Author
Script by Abubakar Mohammed, Narhid Abubakar Mohammed and Oppong Alexander
Purpose-built for secure, automated maintenance of Linux environments.
