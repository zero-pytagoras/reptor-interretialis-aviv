#!/usr/bin/env bash
#########################################
#
# Created by: Aviv
# Purpose: Generate nginx subdomain-routing config
# Version: 0.0.1
# Date: 01.05.2026
#
#########################################
DOMAIN=$1
SUBS=(www api dev test beta)

grep -qs "$DOMAIN" nginx.conf && { echo "Already exists."; exit 0; }

{
echo "events {}"
echo "http {"
for s in "${SUBS[@]}"; do
    echo "  upstream ${s}_servers { server ${s}-backend:8080; }"
    echo "  server { listen 80; server_name ${s}.${DOMAIN}; location / { proxy_pass http://${s}_servers; } }"
done
echo "}"
} > nginx.conf

docker compose up -d --build
