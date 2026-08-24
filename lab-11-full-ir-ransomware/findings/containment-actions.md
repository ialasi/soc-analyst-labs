# Containment Actions

## Immediate Containment

Incident severity: High

Affected host: FINANCE-PC01

### Actions Taken

1. Isolated FINANCE-PC01 from the network.
2. Prevented further communication with the suspected payload delivery domain.
3. Preserved available evidence before remediation.
4. Identified the suspicious executable `updater.exe`.
5. Identified the malicious document `invoice_document.docm`.
6. Suspended further user activity on the affected workstation.
7. Began investigation of potentially affected files and systems.

## Recommended Additional Containment

- Block the suspected malicious domain at DNS and web filtering controls.
- Search the environment for `invoice_document.docm`.
- Search endpoints for `updater.exe`.
- Search for `.locked` files across the environment.
- Review PowerShell activity for other affected hosts.
- Reset credentials associated with the affected account after evidence preservation.
- Determine whether other workstations received the same email.

## Containment Objective

Prevent the ransomware from spreading while preserving evidence required for investigation and eradication.
