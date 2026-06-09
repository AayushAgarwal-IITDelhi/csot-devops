#!/usr/bin/env bash
set -euo pipefail

# 1) Generate self-signed cert (openssl req -x509 -nodes -newkey rsa:… or ec:…)
#    → write certificate and private key to files you choose
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/09csot.key \
  -out /etc/ssl/certs/09csot.crt \
  -subj "/CN=localhost"

# 2) Write an nginx config that includes:
#      listen 8443 ssl;
#      ssl_certificate     …;
#      ssl_certificate_key …;

sudo tee /etc/nginx/09.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    server {
        listen 8443 ssl;
        server_name _;

        ssl_certificate     /etc/ssl/certs/09csot.crt;
        ssl_certificate_key /etc/ssl/private/09csot.key;

        location / {
            proxy_pass http://127.0.0.1:8000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }

    server {
        listen 80;
        server_name _;
        return 301 https://$host$request_uri;
    }
}
EOF

# 3) Start nginx pointing at that config (e.g. nginx -c /path/to/your.conf)

sudo nginx -c /etc/nginx/09.conf