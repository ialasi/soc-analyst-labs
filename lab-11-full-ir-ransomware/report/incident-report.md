# SOC Incident Response Report — Ransomware Incident

## 1. Executive Summary

On 24 August 2026, the SOC investigated a suspected ransomware incident affecting workstation `FINANCE-PC01`.

The investigation identified a likely phishing-based initial access vector involving a macro-enabled Microsoft Word document named `invoice_document.docm`.

Evidence showed that the user opened the document, followed by Office macro execution. `winword.exe` subsequently initiated PowerShell, which downloaded and executed `updater.exe`.

Shortly afterward, multiple files were renamed with the `.locked` extension. Ransomware behavior was detected, and shadow-copy deletion activity was observed.

The affected workstation was isolated from the network to prevent further spread.

## 2. Incident Classification

| Field | Value |
|---|---|
| Incident Type | Ransomware |
| Severity | High |
| Affected Host | FINANCE-PC01 |
| Affected User | finance.user |
| Department | Finance |
| Initial Access | Phishing / Malicious Document |
| Status | Contained |
| Investigation Date | 24 August 2026 |

## 3. Initial Access

The investigation identified an email delivered to `finance.user` at 09:08:47.

The email contained:

- Sender: `accounts-payable@vendor-invoice.example`
- Subject: `Urgent Invoice Review Required`
- Attachment: `invoice_document.docm`

The user opened the attachment at 09:09:12, followed by Office macro execution at 09:09:18.

The evidence strongly supports the macro-enabled document as the initial access mechanism.

## 4. Attack Chain

The observed attack chain was:

1. Phishing email delivered to the user.
2. User opened `invoice_document.docm`.
3. Office macro execution occurred.
4. `winword.exe` initiated PowerShell.
5. PowerShell downloaded `updater.exe`.
6. PowerShell executed `updater.exe`.
7. Mass file renaming occurred.
8. Ransomware behavior was detected.
9. Shadow-copy deletion behavior was observed.
10. The workstation was isolated.

## 5. Timeline

| Time | Event |
|---|---|
| 09:08:47 | Phishing email delivered |
| 09:09:12 | User opened `invoice_document.docm` |
| 09:09:18 | Office macro executed |
| 09:09:19 | PowerShell downloaded `updater.exe` |
| 09:09:21 | PowerShell executed `updater.exe` |
| 09:09:22 | `updater.exe` process created |
| 09:11:42 | `winword.exe` activity observed |
| 09:12:03 | `updater.exe` observed in endpoint telemetry |
| 09:12:09 | PowerShell process observed |
| 09:13:21 | Mass `.locked` file activity detected |
| 09:14:02 | Ransomware behavior detected |
| 09:14:45 | Shadow-copy deletion detected |
| 09:15:17 | Workstation isolated |

## 6. Indicators of Compromise

| Indicator | Type | Confidence |
|---|---|---|
| `invoice_document.docm` | File | High |
| `updater.exe` | File | High |
| `malicious-update.example` | Domain | High |
| `.locked` | File extension | High |
| `powershell.exe` | Process | High |
| `winword.exe` | Process relationship | Medium |

## 7. Impact Assessment

The investigation identified multiple files with the `.locked` extension, including:

- `Financial_Report.xlsx.locked`
- `Employee_List.docx.locked`
- `Network_Diagram.pdf.locked`
- `Security_Policy.docx.locked`
- `Incident_Notes.txt.locked`

The available evidence indicates that files on `FINANCE-PC01` were affected.

There is currently no evidence in the simulated dataset confirming compromise of additional workstations.

## 8. Containment

The following containment actions were performed or recommended:

- FINANCE-PC01 was isolated from the network.
- The suspected payload delivery domain was identified for blocking.
- Suspicious files were identified.
- Evidence was preserved before remediation.
- The affected user's activity was suspended.
- The environment should be searched for the identified IOCs.
- Other systems receiving the same email should be investigated.

## 9. Eradication

Recommended eradication actions include:

1. Preserve forensic evidence.
2. Remove `invoice_document.docm`.
3. Remove `updater.exe`.
4. Identify and remove persistence mechanisms.
5. Review PowerShell execution history.
6. Perform endpoint security scans.
7. Search the environment for all identified IOCs.
8. Reset potentially compromised credentials.
9. Confirm no ransomware processes remain.

## 10. Recovery

Recovery should include:

- Restoring affected files from known-good backups.
- Validating restored files.
- Applying security updates.
- Updating endpoint protection.
- Resetting affected credentials.
- Performing full security scans.
- Monitoring the workstation after recovery.
- Reconnecting the workstation only after security validation.

## 11. Lessons Learned

The incident highlights several security improvement opportunities:

### Email Security

Improve detection and blocking of suspicious macro-enabled attachments.

### Endpoint Security

Monitor suspicious process relationships and mass file modifications.

### PowerShell Monitoring

Improve visibility into PowerShell downloads and execution.

### User Awareness

Provide additional phishing-awareness training, particularly around unexpected invoice documents.

### Backup Protection

Maintain reliable, tested backups that cannot easily be modified or deleted by ransomware.

## 12. Final Assessment

The investigation strongly supports a phishing-based ransomware infection involving a malicious macro-enabled Word document.

The evidence shows a progression from email delivery to document execution, PowerShell-based payload delivery, execution of `updater.exe`, mass file modification, and recovery-inhibition behavior.

The incident was successfully contained in the simulated environment by isolating the affected workstation.

Further environment-wide IOC searches would be required before declaring the incident fully eradicated.

## 13. Incident Response Status

**Current Status: Contained — Recovery Pending Validation**

**Severity: High**

**Primary Initial Access Vector: Phishing / Malicious Office Document**

**Primary Payload: `updater.exe`**

**Primary Execution Mechanism: PowerShell**

**Primary Impact: File Encryption / Renaming**