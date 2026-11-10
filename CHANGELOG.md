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
- A failed test links each affected object to the Microsoft Entra admin center (users, groups, service
  principals, Conditional Access policies and the access package of an assignment policy) and to the EntraOps
  reports that show it, as the Findings view of the Privileged Assets report does: PIM Request Flow, Access
  Package Flow, Conditional Access Analysis, Configuration Analyzer, Tier Breach Analyzer (the path), EAM Dashboard
  (the role assignment and the object) and Access Path Map. Every result links its rule in the Findings view. The
  reports are found next to `findings.json` (`Reports`, or the `EntraOps-Reporting` artifact), or set with
  `EntraOps.ReportsPath` (a URL or a folder; `None` turns the links off).
- A failed test lists the type and tier of each object, the number of affected objects, and the
  evidence that the message of EntraOps doesn't name (PIM assignment type, scope, nested groups, identities
  without an access package), so two results with the same message are told apart. Objects with the same name show
  the start of their ID.
- In Maester's affected objects (by default since Maester 3.0.0-rc73, with `-IncludeAffectedObjects` before), the users, groups, service principals and Conditional Access
  policies of the failed tests are listed on Maester's Affected objects page (all of them, also beyond the 50 findings
  of the tables), with their EntraOps tier.
- The checks that ask for a review, not a fix (`MP.EOPS.2004`, `4010`, `5004`, `5005`, `8001`, `8003`: `Investigate`
  in the EntraOps rule catalog and in `findings.json`) report their findings as Maester's Investigate result instead
  of Failed. Results of EntraOps versions without the flag still report them as Failed.
- The results show the affected objects in tables of two columns, so they fit the result panel of the Maester
  report. Objects with the same finding share a section: the finding once, then a table of the objects with their
  evidence and links ("142 PIM role settings: Can be activated without approval."). Objects with several findings
  are named once, with the number of their findings and the links that all of them share, and their findings in
  the rows below. Findings of an object that differ in one name only are one row that names them all, each linked
  to its own report ("at lab-landingzones, lab-platform and secplaybook-rg", or the 29 delegated permissions of
  Microsoft Graph that one application has); at most five rows per object, then the number of the others.
- The object column has the tier of the object (🔐 Control Plane, ☁️ Management Plane, ⚙️ Workload Plane, as the
  EntraOps-based tests of Maester show them, ❔ Unclassified) and its type (👤 user, 👥 group, 🤖 service principal,
  🛡️ Conditional Access policy, ⏱️ PIM role setting, 📦 access package policy ...) as icons, with a legend per test.
  A finding shows the `Detail` of EntraOps, its message without the object and tier ("Reaches 10 Control Plane
  services ..."; for results of EntraOps versions without it, the pack removes them the same way), the evidence
  (⏳ eligible, 📌 permanent, scope, groups) and its links (Tier breach, Assignment, PIM flow, Package flow, CA
  analysis, Configuration; the tooltip names the report). Emphasis is sparing: the tiers and the role or
  permission of a finding in bold, the evidence in italics, IDs as code; other names are plain text. The summary
  has one line per fact with its icon.
- When the results cannot be used, all tests are skipped with the reason and what to do, and `Invoke-Maester`
  shows it once as a warning: no `findings.json` (with the full path checked, also for a relative
  `EntraOps.FindingsPath`, which may start with `~`), a file that is empty, cut off or no EntraOps finding results
  file (a cut-off file was an error in each test), an unknown schema, another tenant or old results. An
  `EntraOps.ReportsPath` folder without the EntraOps reports gives no report links, and the results say so.
- Each result shows the settings EntraOps evaluated the check with (`Parameters`, for example `MaxHours: 4`), the
  findings accepted by finding exceptions in a table (state, expiry, reference, justification, who accepted them),
  and the exceptions to look after: expired ones (their findings count again), ones that match no finding anymore,
  and risk acceptances that expire within 30 days.
- A test skipped because only unclassified objects are affected (`MP.EOPS.1003`) lists these objects with the
  number of their findings, and a failed test lists its unclassified objects apart. A test that doesn't apply
  (for example `MP.EOPS.3012` when `MP.EOPS.3004` reports all roles) shows the reason of EntraOps instead of
  only Maester's "does not apply to this tenant".
- No connection, permission or module is needed; Low risk.
