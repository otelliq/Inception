# Inception

> A Docker-based infrastructure project (42 School) that provisions a small production-like stack with **Nginx + WordPress + MariaDB**, using Docker Compose, custom Dockerfiles, volumes, and networking.

![DevOps](https://img.shields.io/badge/topic-docker%20%7C%20compose%20%7C%20nginx-informational)
![Project](https://img.shields.io/badge/42%20School-Inception-black)

## Overview

`Inception` is a system administration / DevOps project focused on building an isolated multi-service setup with Docker.

In this repository, the stack is defined in:

- `srcs/docker-compose.yml`
- `srcs/requirements/` (service Dockerfiles/config)

The Compose file defines the following services:

- **mariadb** (database)
- **wordpress** (PHP-FPM)
- **nginx** (reverse proxy / TLS)

It also defines persistent volumes for WordPress and MariaDB data.

**Repository:** `otelliq/Inception`  
**Default branch:** `main`

## Services

### MariaDB
- Built from: `srcs/requirements/mariadb`
- Persists data to a bind-mounted volume (see `docker-compose.yml`)

### WordPress
- Built from: `srcs/requirements/wordpress`
- Depends on MariaDB
- Persists WordPress files to a bind-mounted volume

### Nginx
- Built from: `srcs/requirements/nginx`
- Exposes port **443**
- Serves the WordPress site via the internal network

## Volumes & paths (important)

Your `docker-compose.yml` currently uses **absolute host paths** (example):

- `/home/kali/data/wordpress`
- `/home/kali/data/mariadb`

And it references an `.env` file using an absolute path:

- `/home/kali/Desktop/debut/srcs/.env`

If you run this project on a different machine/user, you’ll likely need to update these paths (or refactor them into relative paths / variables).

## Build & run

From the repository root:

```bash
# build + start
make

# or directly:
docker compose -f srcs/docker-compose.yml up --build
```

Stop:

```bash
docker compose -f srcs/docker-compose.yml down
```

## Project structure

```text
.
├── Makefile
└── srcs/
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        ├── nginx/
        └── wordpress/
```

## Notes

- Prefer environment-variable based paths in `docker-compose.yml` to keep the project portable.
- Consider adding `.env.example` (without secrets) so others know what to configure.

## License

No license file is included. If you want reuse outside the academic context, add a `LICENSE` file (MIT/Apache-2.0 are common choices).
