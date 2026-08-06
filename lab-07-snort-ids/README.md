# SOC Lab Engineering Report
## Lab 07 — Snort IDS Setup + Custom Rule Writing

---

| Field | Details |
|---|---|
| **Author** | Ibitayo Alasi |
| **Current Role** | IT Support Specialist |
| **Target Role** | SOC Analyst |
| **Lab Number** | 07 of 20 |
| **Phase** | Phase 2 — Detection |
| **Date Completed** | 4 August 2026 |
| **Status** | ✅ Complete |

---

## 1. Executive Summary

This lab demonstrates Snort 3 IDS installation, custom rule writing, and attack detection on a Kali Linux Docker container. Five custom detection rules were written to detect ICMP ping sweeps, TCP SYN port scans, Nmap signature traffic, SSH connection attempts, and SMB traffic. Attacks were simulated using ping and Nmap, captured with tcpdump, and analyzed by Snort — generating 192 alerts across 200 packets. This lab covers both offensive (attack simulation) and defensive (IDS rule writing) perspectives.

---

## 2. Objectives

- Install Snort 3 on Kali Linux Docker container
- Write custom IDS rules for 5 attack signatures
- Capture network traffic using tcpdump
- Run Snort against PCAP file to generate alerts
- Detect ICMP ping sweep (Rule 1000001)
- Detect TCP SYN port scan (Rule 1000002)
- Detect Nmap signature via Win=1024 (Rule 1000003)
- Analyze and document 192 IDS alerts
- Map findings to MITRE ATT&CK framework

---

## 3. Environment

| Component | Details |
|---|---|
| IDS Platform | Snort++ 3.12.2.0 |
| Container | Kali Linux Docker (ARM64) |
| Attacker IP | 172.17.0.2 |
| Target IP | 172.17.0.1 (Mac Host) |
| Network | Docker Internal 172.17.0.0/16 |
| Total Alerts | 192 |
| PCAP Size | 200 packets |

---

## 4. Installation

```bash
# Launch Kali container with network capabilities and mounted volume
docker run -it \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  -v ~/soc-analyst-labs/lab-07-snort-ids:/lab07 \
  kali-soc-lab /bin/bash

# Install Snort and dependencies
apt update && apt install -y snort tcpdump iputils-ping nmap

# Verify installation
snort --version
```

---

## 5. Custom Rules Written

```snort
# Lab 07 — Custom Snort IDS Rules
# Author: Ibitayo Alasi

# Rule 1 — Detect ICMP ping sweep
alert icmp any any -> any any (msg:"ICMP Ping Detected"; sid:1000001; rev:1;)

# Rule 2 — Detect TCP SYN port scan
alert tcp any any -> any any (msg:"TCP SYN Scan Detected"; flags:S; sid:1000002; rev:1;)

# Rule 3 — Detect Nmap signature (Win=1024)
alert tcp any any -> any any (msg:"Nmap SYN Scan - Win1024"; flags:S; window:1024; sid:1000003; rev:1;)
```

### Rule Anatomy Explained

```
alert                    — Action (alert/drop/reject/log)
icmp                     — Protocol (icmp/tcp/udp/ip)
any any                  — Source IP + Port
->                       — Direction
any any                  — Destination IP + Port
(msg:"ICMP Ping"         — Alert message
sid:1000001;             — Unique rule ID
rev:1;)                  — Rule revision
```

---

## 6. Snort Configuration

```lua
-- Lab 07 Snort Configuration
-- Author: Ibitayo Alasi

HOME_NET = '172.17.0.0/24'
EXTERNAL_NET = 'any'

ips =
{
    enable_builtin_rules = false,
    rules = [[
        include /lab07/rules/local.rules
    ]]
}

alert_fast =
{
    file = true,
    packet = false,
}
```

---

## 7. Attack Simulation + Detection Process

### Step 1 — Capture traffic with tcpdump
```bash
tcpdump -i eth0 -w /lab07/logs/capture.pcap -c 200 &
```

### Step 2 — Generate attack traffic
```bash
ping -c 10 172.17.0.1      # Generates ICMP traffic
nmap -sS 172.17.0.1        # Generates TCP SYN scan
```

### Step 3 — Run Snort against PCAP
```bash
snort -c /lab07/snort.lua -r /lab07/logs/capture.pcap -l /lab07/logs/ -A alert_fast
```

---

## 8. Findings

### 8.1 Alert Summary
| Rule | SID | Alert Message | Count |
|---|---|---|---|
| Rule 1 | 1000001 | ICMP Ping Detected | 20 |
| Rule 2 | 1000002 | TCP SYN Scan Detected | 86 |
| Rule 3 | 1000003 | Nmap SYN Scan - Win1024 | 86 |
| **Total** | | | **192** |

### 8.2 Sample ICMP Alerts
```
08/02-03:02:15.508269 [**] [1:1000001:1] "ICMP Ping Detected" [**] 
  [Priority: 0] {ICMP} 172.17.0.2 -> 172.17.0.1

08/02-03:02:15.508360 [**] [1:1000001:1] "ICMP Ping Detected" [**] 
  [Priority: 0] {ICMP} 172.17.0.1 -> 172.17.0.2
```

### 8.3 Sample Nmap SYN Scan Alerts
```
08/02-03:02:25.337158 [**] [1:1000003:1] "Nmap SYN Scan - Win1024" [**] 
  [Priority: 0] {TCP} 172.17.0.2:61093 -> 172.17.0.1:8888

08/02-03:02:25.337273 [**] [1:1000003:1] "Nmap SYN Scan - Win1024" [**] 
  [Priority: 0] {TCP} 172.17.0.2:61093 -> 172.17.0.1:993
```

### 8.4 Ports Detected in Nmap Scan
Port scan detected against: 80, 443, 22, 25, 53, 111, 135, 139, 143, 199, 256, 340, 425, 444, 445, 554, 587, 993, 995, 1025, 1027, 1044, 1067, 1070, 1075, 1096, 1099, 1119, 1121, 1199, 1443, 1500, 1720, 1723, 1805, 2170, 2301, 2381, 3001, 3268, 3306, 3322, 3367, 3389, 3517, 3784, 3826, 3905, 3920, 4567, 5269, 5544, 5822, 5900, 5902, 5910, 6004, 6699, 6779, 6901, 7402, 7777, 8008, 8080, 8443, 8500, 13722, 14000, 16016, 19, 21, 23, 32, 32772, 32773, 49161, 52869, 60020

---

## 9. Alert Format Explained

```
08/02-03:02:25  — Timestamp (Month/Day-Hour:Min:Sec)
[**]            — Alert delimiter
[1:1000003:1]   — Generator:SID:Revision
"Nmap SYN..."   — Rule message
[Priority: 0]   — Alert priority
{TCP}           — Protocol
172.17.0.2      — Source IP
:61093          — Source Port
->              — Direction
172.17.0.1      — Destination IP
:8888           — Destination Port
```

---

## 10. Evidence

### Snort Installed
![Snort Install](screenshots/01-snort-installed.png)

### Custom Rules Created
![Rules](screenshots/02-rules-created.png)

### Snort Configuration
![Config](screenshots/03-snort-config.png)

### Snort Starting
![Starting](screenshots/04-snort-starting.png)

### Snort Running
![Running](screenshots/05-snort-running.png)

### Traffic Capture
![Tcpdump](screenshots/07-tcpdump-capture.png)

### ICMP Alerts Detected
![ICMP](screenshots/09-icmp-alerts.png)

### Nmap SYN Scan Alerts
![Nmap](screenshots/11-nmap-syn-alerts.png)

### 192 Total Alerts
![Total](screenshots/15-192-alerts.png)

### Snort Summary Statistics
![Summary](screenshots/16-snort-summary.png)

---

## 11. SOC Analyst Relevance

| Skill Practiced | Real SOC Application |
|---|---|
| Snort rule writing | Core IDS/IPS skill in enterprise SOC |
| ICMP detection | Ping sweep reconnaissance detection |
| SYN scan detection | Port scan / attacker recon detection |
| Nmap fingerprinting | Tool identification from traffic patterns |
| PCAP analysis | Offline forensic investigation skill |
| Alert triage | Reading and interpreting IDS alerts |

---

## 12. MITRE ATT&CK Mapping

| Technique | ID | Snort Rule | Detected |
|---|---|---|---|
| Network Service Scanning | T1046 | SID 1000002 | ✅ 86 alerts |
| Active Scanning — Port Scan | T1595.001 | SID 1000003 | ✅ 86 alerts |
| Active Scanning — ICMP | T1595.003 | SID 1000001 | ✅ 20 alerts |

---

## 13. Snort Rule Writing Reference

| Component | Options | Example |
|---|---|---|
| Action | alert, drop, reject, log | alert |
| Protocol | tcp, udp, icmp, ip | tcp |
| Direction | ->, <>, <- | -> |
| flags | S=SYN, A=ACK, F=FIN, R=RST | flags:S |
| window | TCP window size | window:1024 |
| msg | Alert message | msg:"Scan Detected" |
| sid | Unique rule ID (>1000000 for custom) | sid:1000001 |
| rev | Rule revision | rev:1 |

---

## 14. Key Takeaways

1. **Snort 3 syntax differs from Snort 2** — threshold keyword removed; use rate_filter instead
2. **Win=1024 fingerprints Nmap** — unique window size identifies the scanning tool
3. **PCAP analysis is powerful** — capture once, analyze many times with different rules
4. **192 alerts from 200 packets** — shows how noisy IDS can be without tuning
5. **SID numbering matters** — custom rules use SIDs above 1,000,000 to avoid conflicts
6. **Docker volume mounting** — essential for persisting IDS logs after container exits

---

## 15. Next Lab

**Lab 08 — Phishing Email Analysis**
Analyze phishing email headers, investigate malicious attachments using VirusTotal and Any.run sandbox, extract IOCs, and write a phishing investigation report.

---

*Report authored by Ibitayo Alasi — IT Support Specialist → SOC Analyst*
*GitHub: [github.com/ialasi](https://github.com/ialasi)*
