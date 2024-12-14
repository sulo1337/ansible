#!/bin/bash

# Set variables
TEMPLATE_ID=8001
TEMPLATE_NAME="ubuntu-2404-cloudinit-template"
IMAGE_NAME="jammy-server-cloudimg-amd64.img"
SSH_KEY_PATH="/tmp/id_rsa.pub"
DEFAULT_USER="sulochan"
DEFAULT_PASS="changeme"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Install qemu-guest-agent and empty machine-id using virt-customize
virt-customize -a $IMAGE_NAME --install qemu-guest-agent
virt-customize -a $IMAGE_NAME --run-command "echo -n > /etc/machine-id"

# Resize the cloud image
qemu-img resize $IMAGE_NAME 4G

# Create VM
qm create $TEMPLATE_ID --name "$TEMPLATE_NAME" --ostype l26 --memory 1024 --agent 1 --bios ovmf --machine q35 --efidisk0 local-lvm:0,pre-enrolled-keys=0 --cpu host --socket 1 --cores 1 --vga serial0 --serial0 socket

# Import disk
qm importdisk $TEMPLATE_ID $IMAGE_NAME local-lvm

# Configure disk
qm set $TEMPLATE_ID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$TEMPLATE_ID-disk-1,discard=on
qm set $TEMPLATE_ID --boot order=scsi0
qm set $TEMPLATE_ID --scsi1 local-lvm:cloudinit

# Set cloud-init configurations
qm set $TEMPLATE_ID --tags ubuntu-template,24.04,cloudinit
qm set $TEMPLATE_ID --ciuser $DEFAULT_USER
qm set $TEMPLATE_ID --cipassword $(openssl passwd -6 $DEFAULT_PASS)
qm set $TEMPLATE_ID --sshkeys $SSH_KEY_PATH
qm set $TEMPLATE_ID --ipconfig0 ip=dhcp

# Convert to template
qm template $TEMPLATE_ID

echo "Template $TEMPLATE_ID created successfully!"
