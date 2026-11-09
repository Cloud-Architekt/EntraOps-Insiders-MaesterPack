# Changelog

All notable changes of the EntraOps Maester Pack. The pack has the version of the EntraOps PowerShell
module it is generated from; the release workflow uses the section of a version as its release notes.

## 1.2.0

- First release of the EntraOps Maester Pack (code `EOPS`): 57 tests `MP.EOPS.<n>`, one per EntraOps
  finding rule, in eight categories (tier boundaries, classification, just-in-time access, account protection,
  workload and agent identities, access governance, ownership and delegation, drift).
- `MP.EOPS.6003` (unauthorized access) and `MP.EOPS.6004` (missing access) report the access drift
  (Microsoft Entra ID Governance > Access Guardian) of Control Plane and Management Plane access package resources.
- The tests report the results of the `findings.json` that EntraOps 1.2.0 or later writes, from
  `Reports/Findings/data` of the EntraOps working folder (`ENTRAOPS_ROOT`, `<home>/EntraOps` or the current
  folder) or `EntraOps.FindingsPath`, and skip results of another tenant or older than
  `EntraOps.MaxFindingsAgeDays` (default 7 days).
- A rule that EntraOps could not evaluate (status `Error`) is reported as a Maester error with the reason;
  excluded and deprecated rules are skipped with the reason.
- The reason code of EntraOps (`ReasonCode`) decides how a skipped rule is reported: a rule with nothing in its
  scope (`NotApplicable`) is skipped as not applicable, one that affects only unclassified objects
  (`Unclassified`) or lacked its data (`MissingData`) is skipped with the reason. A passed or failed rule shows
  the note of EntraOps (`Note`) in its result, for example data it could not evaluate. Results of an EntraOps
  version without reason codes are read from the reason text.
- Findings dismissed or risk accepted in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`)
  don't fail a test. With dismissed findings (false positives) only, the test passes; with risk-accepted
  findings and no open one, it is skipped and the reason lists the accepted risks with their expiry date and
  reference, as the control is not met. A failed test names its accepted findings apart. Each test
  description explains how to add an exception.
- A passed or failed result names the tenant and the date of the EntraOps results. The tenant is compared with
  Maester's only while Microsoft Graph is connected, not with `-SkipGraphConnect`.
- The pack's page in the Maester report has its own menu: all results, the tests not met and the tests not
  evaluated, the guide (Get started, Connect, Run) and the pack. Maester 3.0.0-rc56 or later shows it; an older
  version shows its default menu, without the guide.
- Each test, except the Info tests, rates its remediation (`UserImpact`, `ImplementationCost`) like its
  description, and uses a resource type of the Maester taxonomy, so the report groups and filters the pack's
  results with Maester's own tests.
- No connection, permission or module is needed; Low risk.
