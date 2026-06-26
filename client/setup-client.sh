#!/bin/bash

set -e

# ===== CONFIG =====
SERVER_IP="172.31.46.90"
SHARE="/shared/data"
MOUNT_POINT="/mnt/shared"

echo "   NFS CLIENT SETUP STARTING"

# 1. Update system
echo "Updating system..."
sudo apt update -y

# 2. Install NFS client package
echo "Installing NFS client..."
sudo apt install nfs-common -y

# 3. Create mount point
sudo mkdir -p $MOUNT_POINT

# 4. Mount NFS share (temporary mount)
sudo mount ${SERVER_IP}:${SHARE} $MOUNT_POINT

# Verify mount
df -h | grep $MOUNT_POINT || true

# 5. Make mount permanent using /etc/fstab
echo "Configuring /etc/fstab..."

FSTAB_LINE="${SERVER_IP}:${SHARE} ${MOUNT_POINT} nfs defaults,_netdev 0 0"

# Remove old entry if exists
sudo sed -i "\|${MOUNT_POINT}|d" /etc/fstab

# Add new entry
echo "$FSTAB_LINE" | sudo tee -a /etc/fstab > /dev/null

# Test fstab entry safely
sudo mount -a

echo "   NFS CLIENT SETUP COMPLETED"

# Final check
echo "Active mounts:"
mount | grep nfs || true
