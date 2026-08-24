# Lab 11 — Full Incident Response: Ransomware Scenario

## Incident Scenario

### Background

The SOC team receives an alert from an endpoint security system reporting suspicious file activity on a Windows workstation.

The affected workstation belongs to an employee in the Finance department. The user reports that several documents can no longer be opened and that their filenames have changed unexpectedly.

### Initial Alert

At approximately 09:14, the endpoint security system reports:

- Multiple files renamed with a `.locked` extension
- Suspicious executable `updater.exe` detected
- Suspicious PowerShell activity detected
- Shadow-copy deletion behavior detected
- Possible ransomware encryption activity

### Affected Host

- Hostname: FINANCE-PC01
- Operating System: Windows 10
- User: finance.user
- Department: Finance
- IP Address: 192.168.10.25
- Incident Severity: High

### Initial Indicators

| Indicator | Type | Description |
|---|---|---|
| `updater.exe` | File | Suspicious executable |
| `powershell.exe` | Process | Potential execution mechanism |
| `.locked` | File extension | Files potentially encrypted |
| Mass file renaming | Behavior | Possible ransomware activity |
| Shadow-copy deletion | Behavior | Possible recovery prevention |

### Incident Objective

The SOC analyst must investigate the incident, establish a timeline, identify indicators of compromise, determine the likely attack sequence, recommend containment and eradication actions, and produce a final incident-response report.

### Investigation Tasks

1. Identify the initial compromise indicators.
2. Analyze the available endpoint evidence.
3. Build an incident timeline.
4. Identify suspicious processes and files.
5. Extract IOCs.
6. Determine the likely attack sequence.
7. Recommend containment actions.
8. Recommend eradication and recovery actions.
9. Document lessons learned.
10. Produce the final incident-response report.