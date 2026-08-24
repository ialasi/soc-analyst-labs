# Lab 10 Investigation — SSH Brute-Force Detection

## Date

21 August 2026

## Environment

- Host: macOS
- SIEM: Splunk
- Attack platform: Kali Linux Docker container
- Kali container: romantic_kepler
- Target: macOS SSH service
- Target hostname: host.docker.internal
- Target SSH port: 22

## Attack Simulation

A controlled SSH authentication attack was generated from the Kali Docker
container against the macOS SSH service.

The connection was first verified using:

    nc -vz host.docker.internal 22

Result:

    Connection to host.docker.internal (192.168.65.254) 22 port [tcp/ssh] succeeded!

Hydra was installed and available in the Kali container.

An invalid SSH username and password were used to generate controlled
authentication activity.

## Log Collection

macOS SSH activity was collected using:

    log stream --predicate 'process == "sshd"' --style syslog

The output was continuously written to:

    findings/sshd.log

The file was monitored by Splunk using a continuously monitored input.

## Splunk Index

Index:

    bruteforce

Sourcetype:

    sshd-too_small

## Observed SSH Activity

Example events included:

    sshd[9963]
    sshd[9972]

The macOS unified logging system exposed SSH user lookup activity rather
than the Linux-style "Failed password" message.

Example:

    Created Activity ID: 0x1f6b90, Description: Retrieve User by Name

## Detection Logic

The following SPL was used:

    index=bruteforce "Created Activity ID"
    | rex "sshd\[(?<pid>[0-9]+)\]"
    | bin _time span=5m
    | stats dc(pid) AS ssh_attempts count AS events BY _time
    | where ssh_attempts >= 2

## Detection Result

Splunk detected:

    SSH attempts: 2
    Events: 2
    Detection window: 5 minutes

Time window:

    2026-08-21 14:15:00

## Alert

Alert name:

    SSH Brute Force - Multiple Authentication Attempts

Alert type:

    Real-time

Trigger condition:

    Number of Results > 0

Trigger action:

    Add to Triggered Alerts

## Analyst Assessment

The observed activity represents repeated SSH authentication-related
activity against the macOS SSH service.

Multiple distinct sshd processes were observed within a five-minute window.
This behavior is consistent with repeated authentication attempts and can
serve as a basic brute-force detection signal.

The detection was adapted to macOS unified logging because macOS did not
produce the Linux-style "Failed password" message expected from a typical
Linux SSH server.

## Conclusion

The SIEM successfully ingested macOS SSH telemetry, identified repeated
sshd activity, and generated a detection alert when multiple SSH processes
were observed within a five-minute window.

## MITRE ATT&CK Mapping

### T1110 — Brute Force

The simulated activity involved repeated authentication attempts against
an SSH service.

### T1110.001 — Password Guessing

The lab used an invalid username/password combination to generate
authentication-related activity and demonstrate detection of repeated
SSH attempt.