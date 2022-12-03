#! /bin/bash

sudo yum update -y
sudo yum upgrade -y

curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh && sudo bash add-google-cloud-ops-agent-repo.sh --also-install

curl -L https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 > /usr/local/bin/cloud_sql_proxy && chmod +x /usr/local/bin/cloud_sql_proxy

echo "
[Unit]
Description=Proxy SQL
After=network.target
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/usr/local/bin/cloud_sql_proxy -ip_address_types=PRIVATE,PUBLIC -instances=${instance_connection_name}=tcp:0.0.0.0:${instance_port}

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/proxysql.service

systemctl start proxysql
systemctl enable proxysql