# Eradication Plan

## Malicious Artifacts

The investigation identified the following artifacts requiring remediation:

- `invoice_document.docm`
- `updater.exe`
- Malicious PowerShell execution
- Persistence or scheduled tasks, if discovered
- Any additional copies of the payload
- Potentially compromised credentials

## Eradication Actions

1. Preserve forensic evidence before deleting malicious artifacts.
2. Remove the malicious document from affected systems.
3. Remove the `updater.exe` payload.
4. Identify and remove any persistence mechanisms.
5. Review PowerShell execution history.
6. Scan the affected workstation using endpoint security tools.
7. Search the environment for the identified IOCs.
8. Reset compromised credentials.
9. Verify that no additional ransomware processes remain.
10. Confirm that the workstation is clean before reconnecting it to the network.

## Eradication Verification

The host should not be returned to production until:

- No malicious processes are detected.
- No known ransomware artifacts remain.
- No persistence mechanisms are identified.
- Security scans return clean results.
- Required credentials have been reset.
- IOC searches show no additional affected hosts.
