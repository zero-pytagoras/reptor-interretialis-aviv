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
[ -z "$DOMAIN" ] && { echo "usage: $0 domain"; exit 1; } # i'd prefer you avoid oneliners. in some cases it may become unreadable and hard to maintain
SUBS=(www api dev test beta)

{
echo "events {}"
echo "http {"
for s in "${SUBS[@]}"; do # when talked about the shell programming i mentioned not to use single letter variables because it makes the code unreadable.
    echo "  upstream ${s}_servers { server ${s}-backend:8080; }"
    echo "  server { listen 80; server_name ${s}.${DOMAIN}; location / { proxy_pass http://${s}_servers; } }"
done
echo "}"
} > nginx.conf # you are overriding the config but the output is not quite what is required, because the config file is missing several parameters, such as users.
# it is mostly missing the upstream section that enables load-balancing the redirect to other servers

docker compose up -d --build # this was not required.
