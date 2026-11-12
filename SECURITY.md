# Security policy

## Reporting a vulnerability

This repository is private, and GitHub offers private vulnerability reporting for public repositories only.
Report a vulnerability of the EntraOps Maester Pack directly to the maintainers of this repository (the code
owners in `.github/CODEOWNERS`), not in an issue: everyone with access to the repository reads its issues.
The same applies to vulnerabilities of EntraOps itself (the evaluation of the checks); don't report them in a
public repository either.

## What the pack can reach

The pack only reads the `findings.json` that EntraOps writes. It declares no service, no Microsoft Graph
scope, no network host and no module (`Uses` in `maester-pack.json`), writes nothing to a tenant and
contains text files only, so `Test-MtPack` rates it Low risk. The tests and helpers are generated from the
EntraOps rule catalog by `Build-EntraOpsMaesterPack.ps1` of the EntraOps repository; the EntraOps version
and commit of each release are in `entraops-source.json`.

## Supported versions

Only the newest release receives fixes.
