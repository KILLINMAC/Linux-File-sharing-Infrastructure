#!/bin/bash

set -e

echo "   NFS SERVER SETUP STARTING"

# 1. Update system
sudo apt update -y

# 2. Install NFS server
sudo apt install nfs-kernel-server -y

# 3. Create shared directory
SHARED_DIR="/shared/data"

sudo mkdir -p $SHARED_DIR

# Set safe permissions
sudo chown nobody:nogroup $SHARED_DIR
sudo chmod 775 $SHARED_DIR

echo "Shared directory created at $SHARED_DIR"

# 4. Configure exports
echo "Configuring /etc/exports..."

EXPORT_LINE="$SHARED_DIR *(rw,sync,no_subtree_check)"

# Remove old entry if exists
sudo sed -i "\|$SHARED_DIR|d" /etc/exports

# Add new export
echo "$EXPORT_LINE" | sudo tee -a /etc/exports > /dev/null

# 5. Apply exports
sudo exportfs -rav

# 6. Restart and enable NFS service
echo "Starting NFS service..."
sudo systemctl restart nfs-kernel-server
sudo systemctl enable nfs-kernel-server

echo "   NFS SERVER SETUP COMPLETED"

# Verification
echo "Exported shares:"
sudo exportfs -v
