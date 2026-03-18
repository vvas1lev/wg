#!/usr/bin/env bash
# scripts/bootstrap.sh
# One-time EC2 setup. Installs system packages, Python deps, and the
# systemd template unit. Idempotent — safe to re-run.

set -euo pipefail

log() { echo "[bootstrap] $*"; }

log "Installing system packages..."
dnf update -y
dnf install -y wireguard-tools iptables awscli git python3 python3-pip

log "Configuring sysctl..."
cat > /etc/sysctl.d/99-wireguard.conf <<EOF
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOF
sysctl --system

#log "Installing Python package..."
#pip3 install --quiet /opt/wireguard-infra

#log "Installing systemd template unit..."
#cp /opt/wireguard-infra/systemd/wg-tunnel@.service /etc/systemd/system/
#chmod +x /opt/wireguard-infra/scripts/write-conf.sh
#systemctl daemon-reload

log "Bootstrap complete. Use: wg-mgmt <command>"
