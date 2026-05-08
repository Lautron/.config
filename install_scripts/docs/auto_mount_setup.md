# Auto-mount Drive Setup Guide

## Overview
Guide to automatically mount `/dev/sda1` on startup and create symlinks for user folders.

## System Information
- **OS:** CachyOS Linux
- **Target Device:** `/dev/sda1` (390.6GB, ext4)
- **Mount Point:** `/mnt/data/`
- **UUID:** `6d4df397-2961-4b14-a400-fa0daa94f112`

---

## Part 1: Auto-mount Drive on Startup

### Step 1: Create Mount Point
```bash
sudo mkdir -p /mnt/data
```

### Step 2: Add fstab Entry
Add the following line to `/etc/fstab`:
```
UUID=6d4df397-2961-4b14-a400-fa0daa94f112 /mnt/data ext4 defaults 0 2
```

Or use echo:
```bash
echo 'UUID=6d4df397-2961-4b14-a400-fa0daa94f112 /mnt/data ext4 defaults 0 2' | sudo tee -a /etc/fstab
```

### Step 3: Test Mount
```bash
sudo umount /mnt/ssd-data
sudo mount -a
```

### Step 4: Verify
```bash
ls /mnt/data
df -h /mnt/data
```

---

## Part 2: Create Symlinks for User Folders

This maps `~/Downloads`, `~/Documents`, and `~/Videos` to `/mnt/data/lautarob/`.

### Step 1: Backup Existing Folders (if needed)
If you have existing files in these folders:
```bash
mv ~/Downloads ~/Downloads.bak
```

### Step 2: Create Symlinks
```bash
ln -s /mnt/data/lautarob/Downloads ~/Downloads
ln -s /mnt/data/lautarob/Documents ~/Documents
ln -s /mnt/data/lautarob/Videos ~/Videos
```

### Step 3: Verify Symlinks
```bash
ls -la ~/ | grep -E "Downloads|Documents|Videos"
```

Expected output:
```
lrwxrwxrwx  Downloads -> /mnt/data/lautarob/Downloads
lrwxrwxrwx  Documents -> /mnt/data/lautarob/Documents
lrwxrwxrwx  Videos -> /mnt/data/lautarob/Videos
```

---

## Quick Reference

### Check UUID of a device
```bash
lsblk -f /dev/sda1
# or
sudo blkid /dev/sda1
```

### View current fstab
```bash
cat /etc/fstab
```

### Remount all entries in fstab
```bash
sudo mount -a
```

### Check mount status
```bash
mount | grep /dev/sda1
df -h /mnt/data
```