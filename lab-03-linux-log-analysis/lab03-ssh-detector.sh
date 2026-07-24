#!/bin/bash
echo "================================================"
echo "   SOC LAB 03 — SSH Brute Force Detector"
echo "   Author: Ibitayo Alasi"
echo "   Date: $(date)"
echo "================================================"
echo ""
echo "[*] Failed login attempts by username:"
sudo journalctl _SYSTEMD_UNIT=ssh.service --no-pager | grep "Failed password" | awk '{print $9}' | sort | uniq -c | sort -rn

echo ""
echo "[*] Failed login attempts by IP address:"
sudo journalctl _SYSTEMD_UNIT=ssh.service --no-pager | grep "Failed password" | awk '{print $11}' | sort | uniq -c | sort -rn

echo ""
echo "[*] Invalid usernames attempted:"
sudo journalctl _SYSTEMD_UNIT=ssh.service --no-pager | grep "Invalid user" | awk '{print $8}' | sort | uniq -c | sort -rn

echo ""
echo "[*] Total failed attempts:"
sudo journalctl _SYSTEMD_UNIT=ssh.service --no-pager | grep -c "Failed password"

echo ""
echo "[*] Accounts with 5+ failed attempts (potential brute force):"
sudo journalctl _SYSTEMD_UNIT=ssh.service --no-pager | grep "Failed password" | awk '{print $9}' | sort | uniq -c | sort -rn | awk '$1 >= 5 {print "ALERT: "$2" has "$1" failed attempts"}'

echo ""
echo "================================================"
echo "   Scan Complete"
echo "================================================"
