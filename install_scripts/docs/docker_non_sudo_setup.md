# Docker Non-Sudo Access Setup

This guide fixes the error:

`Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?`

## Overview

Allow your user to run Docker without `sudo` by:

1. Creating the `docker` group (if missing)
2. Adding your user to that group
3. Ensuring the Docker daemon is running
4. Refreshing group membership in your shell

---

## Step-by-Step Process

### 1) Create the `docker` group

```bash
sudo groupadd docker 2>/dev/null || true
```

### 2) Add your user to the `docker` group

```bash
sudo usermod -aG docker "$USER"
```

### 3) Enable and start Docker daemon

```bash
sudo systemctl enable --now docker
```

### 4) Refresh group membership

Use one of these options:

- Log out and log back in (recommended)
- Or run:

```bash
newgrp docker
```

---

## Verify

Run:

```bash
docker info
docker run hello-world
```

If these commands work without `sudo`, setup is complete.

---

## Troubleshooting

### Check Docker service status

```bash
systemctl status docker --no-pager
```

### Inspect daemon logs

```bash
journalctl -u docker -n 100 --no-pager
```

### Check socket ownership and permissions

```bash
ls -l /var/run/docker.sock
```

Expected owner/group is usually `root:docker`.
