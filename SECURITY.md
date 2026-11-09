# Security policy

## Reporting a vulnerability

Please report a vulnerability of the EntraOps Maester Pack privately through
[GitHub security advisories](https://github.com/Cloud-Architekt/EntraOps-Insiders-MaesterPack/security/advisories/new),
not in a public issue. Vulnerabilities of EntraOps itself (the evaluation of the checks) belong to the
[EntraOps repository](https://github.com/Cloud-Architekt/EntraOps/security/policy).

## What the pack can reach

The pack only reads the `findings.json` that EntraOps writes. It declares no service, no Microsoft Graph
scope, no network host and no module (`Uses` in `maester-pack.json`), writes nothing to a tenant and
contains text files only, so `Test-MtPack` rates it Low risk. The tests and helpers are generated from the
EntraOps rule catalog by `Build-EntraOpsMaesterPack.ps1` of the EntraOps repository; the EntraOps version
and commit of each release are in `entraops-source.json`.

## Supported versions

Only the newest release receives fixes.
