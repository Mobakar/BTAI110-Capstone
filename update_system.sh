#!/bin/bash

# Script to automate system updates with logging and security checks
# Run with sudo or as root

# --- Variables ---

LOG_DIR="/home/user/myproject/logs/update.log"
LOG_FILE="$LOG_DIR/update-$(date +'%Y-%m-%d_%H-%M-%S').log"
TMP_DIR="/tmp/auto-update"


# --- Setup ---
mkdir -p "$LOG_DIR" "$TMP_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1  # Log all output

echo "=== System Update Script ==="
echo "Date: $(date)"
echo "User: $(whoami)"
echo "Host: $(hostname)"

# --- Security Check: Verify Internet Connectivity ---
ping -c 1 google.com >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: No internet connection. Aborting."
    exit 1
fi

# --- Check Disk Space (Min 1GB Free) ---
FREE_SPACE=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')
if [ "$FREE_SPACE" -lt 1 ]; then
    echo "ERROR: Less than 1GB free on root partition. Aborting."
    exit 1
fi

# --- Update Package Lists ---
echo "--- Running 'apt update' ---"
apt update
if [ $? -ne 0 ]; then
    echo "ERROR: 'apt update' failed. Check network/repos."
    exit 1
fi

# --- Upgrade Packages (Unattended, Security-First) ---
echo "--- Running 'apt upgrade'"
apt upgrade --yes
if [ $? -ne 0 ]; then
    echo "WARNING: Some upgrades failed. Manual review needed."
fi

# --- Clean Up ---
echo "--- Cleaning Up ---"
apt autoremove --yes
apt clean

# --- Log Results ---
echo "=== Update Summary ==="
echo "Last update: $(date)"
echo "Packages upgraded:"
apt list --upgradable 2>/dev/null | grep -v "^Listing..."

echo "Update completed. Log saved to $LOG_FILE"
exit 0
