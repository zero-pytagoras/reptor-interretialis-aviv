# reptor-interretialis

Nginx in a docker container, routing subdomain traffic to upstream backends.

## What's in here

- `Dockerfile` - ubuntu 24.04, installs and runs nginx in the foreground.
- `docker-compose.yml` - builds the image, mounts `nginx.conf`, exposes 8080 on the host.
- `nginx.conf` - sample config with `test.example.com` and `beta.example.com` upstreams (primary + backup).
- `generate.sh` - takes a domain, writes a fresh `nginx.conf` for www/api/dev/test/beta, brings the stack up.

## Run it

```
docker compose up
```

Reachable on `http://localhost:8080`.

## Generate a config for your own domain

```
chmod +x generate.sh
./generate.sh mydomain.com
```

Overwrites `nginx.conf` with server blocks for `www`, `api`, `dev`, `test`, `beta` of your domain, each proxying to a `<sub>-backend:8080` upstream. Then runs `docker compose up -d --build` so the new config loads.

Backend hostnames (`www-backend`, etc.) are placeholders. Point them at real services on the same docker network, or swap them in the generated file.

## Notes

- Host port 8080 maps to container port 80, change in `docker-compose.yml` if you need 80 directly.
- The committed `nginx.conf` is a sample so compose has something to mount before you run the script.
- Tested on linux with docker compose v2.
