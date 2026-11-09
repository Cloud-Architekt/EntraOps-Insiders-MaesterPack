# EntraOps Maester Pack

![EntraOps – Privileged access findings for Maester](assets/banner.png)

Shows the [EntraOps](https://github.com/Cloud-Architekt/EntraOps) findings on privileged access as
[Maester](https://maester.dev) tests: Enterprise Access Model tier breaches, standing access, account
protection, workload and agent identities, PIM activation and approval, access packages, access drift from
access packages (Access Guardian) and changes between snapshots.

EntraOps evaluates its finding rules and saves the results to `findings.json` (`Invoke-EntraOpsAssessment` or
`New-EntraOpsReportingData`). This pack reads that file and reports one Maester test per rule:
`MP.EOPS.<n>` for the EntraOps rule `EO.<n>`. The EntraOps reports use the same evaluation, so Maester and the
reports show the same results. The pack evaluates nothing itself and needs no connection, no permission and no
module (`Test-MtPack`: Low risk).

> [!NOTE]
> Maester Packs need Maester 3.0 or later.

<!-- insiders:start -->
> [!IMPORTANT]
> **Insiders preview.** This private repository tests the pack before it is published as EntraOps-MaesterPack.
> Until then:
>
> - EntraOps 1.2.0 is not on the PowerShell Gallery yet (it has 1.1.0, without findings). Import the module from
>   a clone of the EntraOps Insiders repository: `Import-Module ./EntraOps/EntraOps.psd1`.
> - Maester 3.0 is a prerelease: `Install-PSResource -Name Maester -Prerelease -Repository PSGallery -Scope CurrentUser`.
>   The checks of this repository use 3.0.0-rc67; the pack's menu in the report needs 3.0.0-rc56 or later.
> - The repository is private and has no release yet. Install the pack from `main` with a GitHub token that can
>   read it, or from a local clone:
>
>   ```powershell
>   $env:GH_TOKEN = gh auth token
>   Install-MtPack Cloud-Architekt/EntraOps-Insiders-MaesterPack@main -IncludeRecent
>   # Or from a clone of this repository
>   Install-MtPack ./EntraOps-Insiders-MaesterPack
>   ```
>
> - The links to the EntraOps rule catalog, the build script and the EntraOps documentation of findings work
>   once EntraOps 1.2.0 is published.
> - **Sync from EntraOps** generates the pack from the EntraOps Insiders repository with the Actions variable
>   `ENTRAOPS_REPOSITORY` = `Cloud-Architekt/entraops-insiders` and the secret `ENTRAOPS_TOKEN` (a fine-grained
>   token with read access to its contents), and points the links to this repository itself.
> - The build in EntraOps writes the links of the published repository and needs `-OutputPath` for this folder.
>   After a local build, point the links to this repository again; before publishing, point them to the
>   published repository and remove these notes:
>
>   ```powershell
>   ../entraops-insiders/Integrations/Maester/Build-EntraOpsMaesterPack.ps1 -OutputPath .
>   . ./tools/Set-EntraOpsPackRepository.ps1
>   Set-EntraOpsPackRepository -Name EntraOps-Insiders-MaesterPack
>   # Before publishing
>   Set-EntraOpsPackRepository -Name EntraOps-MaesterPack -RemoveInsidersSection
>   ```
<!-- insiders:end -->

## Checks

57 tests in eight categories. The first digit of the ID is the category, which is also a tag of the test
(`Invoke-Maester -Pack EOPS -Tag 'Just-in-time access'`).

| IDs | Category | Checks |
| --- | --- | --- |
| `MP.EOPS.1xxx` | Tier boundaries | Lower tiers that control objects, services or access of a more privileged tier |
| `MP.EOPS.2xxx` | Classification | Objects, role assignments and approvers without a tier; custom roles to review |
| `MP.EOPS.3xxx` | Just-in-time access | Standing access and the PIM settings of eligible assignments and activations |
| `MP.EOPS.4xxx` | Account protection | Restricted management, cloud-only and member accounts, PAW, Conditional Access |
| `MP.EOPS.5xxx` | Workload and agent identities | Service principals, applications and agents with privileged access |
| `MP.EOPS.6xxx` | Access governance | Access packages: approval, requestor scope, expiration, access reviews and access drift (Access Guardian) |
| `MP.EOPS.7xxx` | Ownership and delegation | Owners of privileged objects, role assignment delegation, nested groups, administrative units |
| `MP.EOPS.8xxx` | Drift | Changes of privileged access between Privileged EAM snapshots |

[TESTS.md](TESTS.md) lists every test with its severity and category. Each test has its description and
remediation in [tests](tests) (`Test.MP.EOPS.<n>.md`). In EntraOps,
`Get-EntraOpsFindingRule` lists the rules with their Maester test ID.

## Prerequisites

- PowerShell 7.4 or later and Maester 3.0 or later.
- EntraOps 1.2.0 or later, and its finding results (`findings.json`) of the tenant.

## Usage

### 1. Get the EntraOps finding results

Without EntraOps in place, run a complete assessment with one cmdlet. It signs in interactively, classifies the
privileged access, captures a Tenant Governance snapshot when the tenant is prepared for it, generates the reports
and saves the results to `Reports/Findings/data/findings.json` of the EntraOps working folder:

```powershell
Install-PSResource -Name EntraOps -Repository PSGallery -Scope CurrentUser
Invoke-EntraOpsAssessment -TenantName 'contoso.onmicrosoft.com'
```

With an EntraOps repository, the EntraOps report generation (`New-EntraOpsReportingData`, also run by `Invoke-EntraOpsReportingGeneration`
and the EntraOps reporting pipelines of GitHub and Azure DevOps) evaluates all rules after the report data and
saves the results to `Reports/Findings/data/findings.json`. The pipelines publish them with the reports in the
`EntraOps-Reporting` artifact: download the artifact and use its `Findings/data` folder.

The rules of the PIM Request Flow, Access Package Flow, Tenant Governance and Privilege History areas evaluate
the generated report data, like the reports. `Invoke-EntraOpsFindingEvaluation | Save-EntraOpsFindingJson`
alone (without `New-EntraOpsReportingData`) skips these rules with the reason.

### 2. Install the pack

```powershell
Install-MtPack Cloud-Architekt/EntraOps-Insiders-MaesterPack
```

Maester shows what the pack can reach (nothing) and installs the newest release that is older than the install
cooldown (72 hours). Commit `maester-config.json` and `maester-packs.lock.json`, and run `Restore-MtPack` in
pipelines.

### 3. Run the pack

```powershell
# Only this pack: no connection needed
Invoke-Maester -Pack EOPS -SkipBuiltIn -SkipGraphConnect
# Maester's tests and this pack
Invoke-Maester -Pack EOPS
```

Without a setting, the pack reads `Reports/Findings/data/findings.json` of the EntraOps working folder: of
`ENTRAOPS_ROOT`, of `<home>/EntraOps` (the working folder of `Invoke-EntraOpsAssessment` after a module
installation) or of the current folder (a clone of your EntraOps repository), the first one that has the file.
For another location, for example the downloaded `EntraOps-Reporting` artifact, set the folder or the file in
`maester-config.json` (see [maester-config.example.json](maester-config.example.json)):

```json
{
  "GlobalSettings": {
    "EntraOps.FindingsPath": "./EntraOps-Reporting/Findings/data",
    "EntraOps.MaxFindingsAgeDays": 7
  }
}
```

| Setting | Default | Description |
| --- | --- | --- |
| `EntraOps.FindingsPath` | the working folder (see above) | `findings.json`, or the folder that holds it. A relative path is relative to the current folder. |
| `EntraOps.MaxFindingsAgeDays` | `7` | Skip the tests when the results are older. `0` turns the check off. |

When Microsoft Graph is connected (by Maester or earlier in the PowerShell session), the pack skips results of
another tenant. With `-SkipGraphConnect` it cannot compare the tenant: each result names the tenant and the date
of the EntraOps results, so check them.

In the Maester report, the pack's page lists all results, the tests not met and the tests not evaluated, and
has this guide (**Set up**: Get started, Connect, Run).

## Settings of the rules

The pack reports the results as EntraOps evaluated them. The `Findings` section of `EntraOpsConfig.json`
excludes rules and sets their thresholds (for example the maximum activation duration of Control Plane roles);
see [Findings settings](https://www.entraops.com/docs/reportings/index.html#findings) in the EntraOps
documentation. The tests of excluded rules are skipped.

To dismiss a single finding (a false positive) or accept its risk until a date, without excluding the whole
rule, add an exception to the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default
`./Classification/FindingExceptions.json`). The Findings view of the EntraOps Privileged Assets report adds
exceptions (*Accept* at an affected object of a check) and exports the file; save it in the EntraOps folder
and run the evaluation again. Dismissed findings (false positives) pass a test. Risk-accepted findings don't
fail it either, but the control is not met: a test with risk-accepted findings and no open one is skipped, and
the reason lists the accepted risks with their expiry date and reference. Expired exceptions report their
findings again. See
[Finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions).

## Results

| Result | When |
| --- | --- |
| Passed | EntraOps evaluated the rule and found no affected object, or only findings dismissed as false positives (the result names their number). |
| Failed | EntraOps found at least one affected object that is not dismissed or risk accepted. The result lists the first 50 and names the accepted findings apart. |
| Skipped | The findings of the rule are risk accepted in EntraOps and none is open (the reason lists the accepted risks). Or the rule is excluded or deprecated in EntraOps, had nothing to evaluate or its data was missing; the results are missing, belong to another tenant, are too old or have an unknown schema; or the results were written by an EntraOps version without the rule. |
| Error | EntraOps could not evaluate the rule (status `Error` in `findings.json`). The result shows the reason; run the EntraOps evaluation again. |

## Relation to the tests that ship with Maester

Some tests of Maester cover related topics, for example `MT.1025`–`MT.1031` (Control Plane role assignments),
`MT.1077`/`MT.1078` (owners of privileged applications), `MT.1207`/`MT.1209`/`MT.1210` (agent identities),
`CISA.MS.AAD.7.x` and `CIS.M365.5.3.x` (privileged roles and PIM). They query the tenant when Maester runs. The
tests of this pack report the EntraOps evaluation instead: the tenant's own Enterprise Access Model
classification (including custom classifications and tenant overwrites) and the same results as the EntraOps
reports.

## Maintaining the pack

The tests (`tests/Test.MP.EOPS.*`), the helpers, `maester-pack.json` and `entraops-source.json` are generated
by [Build-EntraOpsMaesterPack.ps1](https://github.com/Cloud-Architekt/EntraOps/blob/main/Integrations/Maester/Build-EntraOpsMaesterPack.ps1)
from the EntraOps rule catalog: a native Maester test takes its ID, title and severity from constants. Change the
rules and the helper template in EntraOps, not here. This repository maintains the guide
(`maester-pack.guide.json`), the banner, the documentation, the changelog and the workflows.

| Path | Maintained by |
| --- | --- |
| `maester-pack.json`, `entraops-source.json`, `tests/`, `helpers/` | Generated from EntraOps |
| `maester-pack.guide.json`, `assets/`, `README.md`, `TESTS.md`, `CHANGELOG.md`, `maester-config.example.json` | This repository |
| `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `SUPPORT.md`, `PRIVACY.md` | This repository: the community files |
| `ci/` | The checks of the pack (`ci/PackChecks.ps1`) and synthetic results (`ci/fixtures/findings.json`) |
| `tools/` | `Set-EntraOpsPackRepository.ps1`: points the links of the pack to another repository |
| `.github/` | Workflows, ruleset and templates (issues, pull requests, code owners, Dependabot) |

The whole repository is the pack, so every `.ps1` file may contain function definitions only; Maester refuses
the pack otherwise. That is why the checks are a function (`Invoke-EntraOpsPackCheck`).

### Versions and releases

The pack has the version of the EntraOps PowerShell module it is generated from (`Version` in
`maester-pack.json` and in `entraops-source.json`), and its releases are tagged `v<Version>`. A change of the
pack alone (for example of the guide) is released with the next EntraOps version.

1. In EntraOps: raise `ModuleVersion` of `EntraOps.psd1`, record the rules of the release in
   `FindingRules.lock.json` (`./Integrations/Maester/Build-EntraOpsMaesterPack.ps1 -Release`) and merge it.
2. Here: run **Sync from EntraOps** (`.github/workflows/sync-from-entraops.yml`) for the EntraOps tag or
   commit. It generates the pack, points its links to this repository, opens a pull request with the changes
   and starts the checks on it.
3. Add the changes to the version's section of `CHANGELOG.md` (`## <Version>`) and merge the pull request.
   **Release** (`.github/workflows/release.yml`) checks the merge, tags the commit `v<Version>` and publishes the
   release with the changelog section as its notes. It refuses a pack generated from local EntraOps changes
   (`LocalChanges` in `entraops-source.json`) and a pack whose links point to another repository.
4. Maester users get the release after the install cooldown (72 hours); the Maester Packs index lists it
   automatically once the pack is published.

Test IDs never change once released, because Maester refuses an update of a pack whose tests change their
meaning. EntraOps adds new rules at the end of their category and keeps a rule that is no longer needed with
`Lifecycle` `Deprecated`. The build refuses to change or remove a test that exists in this repository. Never
change the `Guid`, `Id` or `Code` of the manifest.

### Checks

`.github/workflows/check-pack.yml` runs the checks on every pull request and, through **Release**, on every push
to `main`, with the pinned Maester and Pester versions (`MAESTER_VERSION`, `PESTER_VERSION`; Dependabot updates
only the actions). They need no tenant connection: `Test-MtPack` (the checks of `Install-MtPack` and
of the Maester Packs index; the pack must stay valid and Low risk), the metadata of every test, and every test
against the synthetic results in `ci/fixtures/findings.json`. Locally:

```powershell
Invoke-Pester -Container (New-PesterContainer -ScriptBlock { . ./ci/PackChecks.ps1; Invoke-EntraOpsPackCheck })
```

To generate the pack locally from an EntraOps clone next to this repository:

```powershell
../EntraOps/Integrations/Maester/Build-EntraOpsMaesterPack.ps1
```

### Repository settings

- Public repository with the MIT license.
- Release immutability on (Settings › General › Releases), so the install cooldown counts from the publication.
- The ruleset in `.github/rulesets/main.json` (import it under Settings › Rules › Rulesets): pull requests and
  the `check` status are required on `main`.
- Actions › General: "Allow GitHub Actions to create and approve pull requests" on, for **Sync from EntraOps**.
- Actions variable `PACK_RELEASES` = `true` once the first version is ready to be released.
- Optional, for another EntraOps repository than `Cloud-Architekt/EntraOps`: the Actions variable
  `ENTRAOPS_REPOSITORY` and, for a private one, the secret `ENTRAOPS_TOKEN` with read access to its contents.

### Publish to the Maester Packs index

After the first release: sign in to [packs.maester.cloud](https://packs.maester.cloud/publish) with GitHub as an
admin of this repository, choose the repository, press **Check** and **Publish**. This registers the pack's
Guid and code (`EOPS`) to `Cloud-Architekt`; the index lists the pack within about ten minutes after its checks
and security scan pass. If a version is not listed, `https://packs.maester.cloud/status/Cloud-Architekt/EntraOps-Insiders-MaesterPack`
gives the reason.

## License

[MIT](LICENSE)
