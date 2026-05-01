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
[ -z "$DOMAIN" ] && { echo "usage: $0 domain"; exit 1; }
SUBS=(www api dev test beta)

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
