#!/bin/bash
# OPUDP Custom Manager Installer - OfficialOnePesewa

clear

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

figlet -f big "OPUDP" | lolcat
echo -e "${GREEN}          OPUDP Custom Manager Installer${NC}"
echo -e "${YELLOW}               OfficialOnePesewa${NC}"
echo ""

apt update -y && apt upgrade -y
apt install lolcat figlet neofetch unzip curl jq -y

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}               SYSTEM INFORMATION${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo -e "Architecture: $(uname -m)"
echo -e "RAM: $(free -h | awk '/^Mem:/ {print $2}')"
echo -e "Storage: $(df -h / | awk 'NR==2 {print $2}')"
echo -e "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

rm -rf /root/udp
mkdir -p /root/udp
cd /root/udp

echo -e "${YELLOW}Downloading OPUDP binary...${NC}"
wget https://github.com/OfficialOnePesewa/OPUDP-Custom/raw/main/udp-custom-linux-amd64 -O udp-custom
chmod +x udp-custom

wget https://github.com/OfficialOnePesewa/OPUDP-Custom/raw/main/config.json -O config.json

cat > /etc/systemd/system/opudp-custom.service <<EOF
[Unit]
Description=OPUDP Custom by OfficialOnePesewa
After=network.target

[Service]
User=root
WorkingDirectory=/root/udp
ExecStart=/root/udp/udp-custom server
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

cd /root
mkdir -p /etc/OPUDP/op-system
cd /etc/OPUDP

wget https://github.com/OfficialOnePesewa/OPUDP-Custom/raw/main/op-system.zip -O op-system.zip
unzip -o op-system.zip

cd op-system
cp menu /usr/local/bin/opcustom
cp *.sh /etc/OPUDP/op-system/
chmod +x /usr/local/bin/opcustom /etc/OPUDP/op-system/*.sh

cd /etc/OPUDP
rm -f op-system.zip

systemctl daemon-reload
systemctl start opudp-custom
systemctl enable opudp-custom

clear
echo -e "${GREEN}✅ Installation Completed Successfully!${NC}"
echo ""
echo -e "Dashboard Command → ${YELLOW}opcustom${NC}"
echo -e "GitHub: ${BLUE}OfficialOnePesewa${NC}"
sleep 3
reboot