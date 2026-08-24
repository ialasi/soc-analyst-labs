# Lessons Learned

## Incident Summary

The simulated ransomware incident began with a phishing email containing a macro-enabled Word document. The document was opened by the user, resulting in macro execution and subsequent PowerShell activity.

PowerShell downloaded and executed `updater.exe`, followed by ransomware-related file activity.

## Security Gaps Identified

1. User interaction with a suspicious email attachment.
2. Macro execution from a downloaded Office document.
3. PowerShell permitted to download and execute a payload.
4. Insufficient prevention of suspicious executable downloads.
5. Ransomware was able to modify multiple files before detection.

## Recommended Improvements

### Email Security

- Strengthen filtering of suspicious attachments.
- Block or quarantine high-risk macro-enabled documents from external senders.
- Improve phishing detection.

### Endpoint Security

- Restrict unnecessary Office macro execution.
- Monitor suspicious parent-child process relationships.
- Detect mass file modifications.
- Improve ransomware behavioral detection.

### PowerShell Security

- Enable appropriate PowerShell logging.
- Monitor suspicious PowerShell commands.
- Restrict unnecessary script execution.
- Alert on downloads initiated through PowerShell.

### User Awareness

- Provide phishing-awareness training.
- Teach users to verify unexpected invoice requests.
- Encourage immediate reporting of suspicious attachments.

### Backup and Recovery

- Maintain tested offline or otherwise protected backups.
- Regularly test restoration procedures.
- Monitor backup infrastructure for ransomware-related tampering.

## Conclusion

The incident demonstrates the importance of layered security controls. Email security, endpoint detection, PowerShell monitoring, user awareness, network isolation, and reliable backups can collectively reduce the impact of ransomware attacks.
