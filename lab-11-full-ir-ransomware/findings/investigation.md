# Initial Investigation

## Initial Triage Findings

The investigation identified several indicators consistent with a ransomware incident.

### Suspicious Processes

- `updater.exe` — suspicious executable observed at 09:12:03.
- `powershell.exe` — started at 09:12:09 and associated with suspicious command activity at 09:12:15.

### Suspicious File Activity

Multiple files were renamed with the `.locked` extension at 09:13:21.

### Ransomware Indicators

The following behaviors were observed:

- Mass file renaming
- `.locked` file extension
- Ransomware behavior detection
- Shadow-copy deletion
- Network isolation

### Initial Assessment

The available evidence strongly suggests ransomware activity on the affected workstation.

Further investigation is required to determine the likely initial access vector, execution mechanism, scope of impact, and indicators of compromise.

## Initial Access and Execution Analysis

The evidence indicates that the ransomware incident likely originated from a phishing email containing a macro-enabled Microsoft Word document.

The email was delivered to `finance.user` at 09:08:47 with the attachment `invoice_document.docm`. The user opened the attachment at 09:09:12, followed by Office macro execution at 09:09:18.

PowerShell telemetry shows `winword.exe` as the parent process. PowerShell subsequently downloaded `updater.exe` and executed it.

### Supported Attack Chain

1. Phishing email delivered to the user.
2. User opened `invoice_document.docm`.
3. Office macro execution occurred.
4. `winword.exe` initiated PowerShell.
5. PowerShell downloaded `updater.exe`.
6. `updater.exe` was executed.
7. Subsequent ransomware behavior was observed.

### Assessment

The evidence strongly supports a phishing-based initial access vector followed by malicious macro execution and PowerShell-based payload delivery.

The relationship between the macro execution and `updater.exe` is supported by the PowerShell parent-process and command-line evidence.