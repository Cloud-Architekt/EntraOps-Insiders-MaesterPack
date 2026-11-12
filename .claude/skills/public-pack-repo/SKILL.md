---
name: public-pack-repo
description: Create or sync the public EntraOps Maester Pack repository (Cloud-Architekt/EntraOps-MaesterPack) from this internal repository (Cloud-Architekt/EntraOps-Insiders-MaesterPack). Use when asked to publish the pack, make a public version of it, or bring the public pack repository up to date with this one.
---

# Create or sync the public pack repository

This repository (`Cloud-Architekt/EntraOps-Insiders-MaesterPack`) is the **internal** EntraOps Maester Pack. It is
private, generated from the private EntraOps Insiders repository (`Cloud-Architekt/entraops-insiders`), and installed
only by people with access. The **public** pack lives in a separate repository, `Cloud-Architekt/EntraOps-MaesterPack`,
generated from the public EntraOps repository (`Cloud-Architekt/EntraOps`).

The public repository is never a copy of this one. It has:

- **Generated files** built from a *public* EntraOps tag: `maester-pack.json`, `entraops-source.json`, `tests/`, `helpers/`.
- **Pack-owned files** taken from this repository, with the internal-only parts turned into their public form.
- **None** of the internal-only files listed below.

## Rules

- **Confirm before every outward step**, each time, even if the user asked to "publish": creating the public
  repository, changing its visibility or settings, pushing, merging, creating a release, publishing to the Maester
  Packs index. Show what will happen first. Prefer a pull request in the public repository over pushing to `main`.
- **Never copy tenant data**: `test-results/`, `findings.json`, `Reports/`, `EntraOps-Reporting/`,
  `maester-config.json`, `maester-packs.lock.json`, `.DS_Store`. Only the synthetic `ci/fixtures/findings.json` may be
  copied. Check it for real names, tenant IDs and domains before copying.
- **Never generate the public pack from `entraops-insiders`**, and never from local changes: `entraops-source.json`
  of the public repository must name `https://github.com/Cloud-Architekt/EntraOps`, a released tag and
  `"LocalChanges": false`.
- **Pack identity and test IDs**: keep `Id`, `Guid` and `Code` (`EOPS`) of the manifest as they are; the build
  writes them. A test ID `MP.EOPS.<n>` must mean the same rule in both repositories. The public pack may lack a rule
  that only Insiders has, but must never give its ID another meaning.
- **No internal references in the public repository**: nothing that names `EntraOps-Insiders-MaesterPack`,
  `entraops-insiders`, the internal distribution, `GH_TOKEN` for installs, or Insiders-only features.
- Commit messages and PR bodies follow the attribution rules of the session.

## 1. Check the preconditions

Stop and report if one fails; don't work around it.

| Check | How |
| --- | --- |
| The EntraOps version of the pack is released on the PowerShell Gallery | `Find-PSResource -Name EntraOps -Version <Version> -Repository PSGallery` |
| The public EntraOps repository has its tag, the rule catalog and the Maester build | `gh api repos/Cloud-Architekt/EntraOps/git/ref/tags/<tag>`; `gh api "repos/Cloud-Architekt/EntraOps/contents/EntraOps/Private/Findings/FindingRules.json?ref=<tag>"`; same for `Integrations/Maester/Build-EntraOpsMaesterPack.ps1` |
| The rules of the release are recorded in `FindingRules.lock.json` of that tag | Its rules include every rule of the catalog (`-Release` of the build was run in EntraOps) |
| The EntraOps documentation has the sections the tests link | `(Invoke-WebRequest https://www.entraops.com/docs/data/content.js).Content` contains `{#findings}` and `{#finding-exceptions}` |
| Maester 3.0 is generally available | `Find-PSResource -Name Maester -Repository PSGallery` returns 3.0 or later without `-Prerelease`. Not a hard stop: ask the user whether to publish against a prerelease. |
| The public EntraOps tag has the helper template of this pack | `Integrations/Maester/Template/helpers/EntraOpsFindings.ps1` of the tag matches `helpers/EntraOpsFindings.ps1` here, or the differences are intended (Insiders-only changes) |

Version: `Version` in `maester-pack.json` here. The tag is usually `v<Version>`; ask if unsure.

## 2. Know which file is which

| Kind | Files | Into the public repository |
| --- | --- | --- |
| Generated | `maester-pack.json`, `entraops-source.json`, `tests/`, `helpers/` | Built from the public EntraOps tag (never copied) |
| Pack-owned, same in both | `assets/`, `LICENSE`, `CODE_OF_CONDUCT.md`, `maester-config.example.json`, `TESTS.md`, `ci/`, `.github/CODEOWNERS`, `.github/dependabot.yml`, `.github/rulesets/`, `.github/workflows/check-pack.yml`, `tools/`, `.gitignore` | Copied as they are (TESTS.md must match the public tests: see step 4) |
| Pack-owned, internal parts | `README.md`, `CHANGELOG.md`, `SECURITY.md`, `SUPPORT.md`, `PRIVACY.md`, `CONTRIBUTING.md`, `maester-pack.guide.json`, `.github/ISSUE_TEMPLATE/*`, `.github/pull_request_template.md`, `.github/workflows/release.yml`, `.github/workflows/sync-from-entraops.yml` | Copied, then turned into the public form (step 3) |
| Internal only | `.claude/` (this skill), `test-results/` and everything `.gitignore` lists | Never copied |

Use `git ls-files` of this repository as the list of files; untracked files are never copied.

**Public wording baseline:** commit `76579f3` of this repository is the last state before the internal distribution.
Its versions of the files in step 3 have the public wording. Use them as the reference, but keep every later change
that is not about the internal distribution (compare with `git diff 76579f3 -- <file>`).

## 3. Turn the internal parts into the public form

First run `Set-EntraOpsPackRepository` (step 4 does this): it points every `Cloud-Architekt/EntraOps-Insiders-MaesterPack`
to `Cloud-Architekt/EntraOps-MaesterPack` and removes the Markdown blocks between `<!-- insiders:start -->` and
`<!-- insiders:end -->`. Then change these parts by hand:

| File | Internal form | Public form |
| --- | --- | --- |
| `README.md` | "Install the pack" needs `GH_TOKEN`; `Restore-MtPack` with a token secret | `Install-MtPack Cloud-Architekt/EntraOps-MaesterPack` without a token; `Restore-MtPack` in pipelines |
| `README.md` | Versions and releases: links into the repository must name a file; EntraOps links only warn; the release stays out of the index | The release refuses links that don't open (Docs page, rule catalog, documentation sections); Maester users get it after the cooldown and the index lists it |
| `README.md` | Repository settings: private repository; `ENTRAOPS_TOKEN` for the Insiders repository | Public repository with the MIT license; no EntraOps token |
| `README.md` | "Maester Packs index": not published | "Publish to the Maester Packs index" (sign in to packs.maester.cloud, Check, Publish; status URL of the public repository) |
| `README.md` | Sync from `entraops-insiders` or `EntraOps` | Sync from the EntraOps tag or commit |
| `CHANGELOG.md` | Bullet "Internal pack: … private GitHub repository …"; Insiders-only tests | Drop the bullet; describe only the tests of the public pack (count, IDs) |
| `SECURITY.md` | Report to the code owners (no private vulnerability reporting) | GitHub security advisories of the public repository (`/security/advisories/new`); EntraOps vulnerabilities to the EntraOps security policy |
| `SUPPORT.md` | All reports in the issues of this repository; "Don't report results of this internal version publicly" | Pack problems here; results of a check in the EntraOps issues; community project |
| `PRIVACY.md` | Installed from a private repository: no install event | Installed from a public repository: Maester sends an anonymous install event unless `MAESTER_DISABLE_TELEMETRY` is `1` |
| `CONTRIBUTING.md` | Contributions from people with access; changes belong in the EntraOps Insiders repository | Contributions welcome; changes belong in EntraOps (`Cloud-Architekt/EntraOps`) |
| `maester-pack.guide.json` | `Support.Tests` is this repository's issues; prerequisite note "Until EntraOps 1.2.0 is on the PowerShell Gallery, import the module from a clone of the EntraOps Insiders repository" | `Support.Tests` is `https://github.com/Cloud-Architekt/EntraOps/issues`; no Insiders note |
| `.github/ISSUE_TEMPLATE/config.yml`, `bug_report.yml`, `feature_request.yml` | Results and new checks reported here; security to the maintainers directly | Contact link "Result of a check" to the EntraOps issues; security through private reporting |
| `.github/pull_request_template.md` | "instead of disclosing them in a pull request or issue" | "instead of disclosing them publicly" |
| `.github/workflows/release.yml` | Links into the repository checked against the checkout; EntraOps links and documentation sections only warn | Every link must open (HTTP 200 for `github.com` and `www.entraops.com`); the documentation sections are required (baseline `76579f3`) |
| `.github/workflows/sync-from-entraops.yml` | Input `source` (`entraops-insiders` default, `EntraOps`); `ENTRAOPS_TOKEN` | Generates from `Cloud-Architekt/EntraOps` only: no `source` input, no token check, `github.token`; branch and title "Sync from EntraOps …" |

The Insiders notes (`<!-- insiders:start -->` … `<!-- insiders:end -->`) are removed by the tool. Check that no
public text was inside them.

## 4. Create the public repository (first time)

1. Check the preconditions (step 1).
2. Confirm with the user, then create the repository: `gh repo create Cloud-Architekt/EntraOps-MaesterPack --public`
   with the description of this one. Clone it into a new folder next to this repository.
3. Copy the files of `git ls-files` of this repository, except the internal-only files (step 2). Copy the generated
   files as well for now; the build replaces them.
4. In the copy, point the links to the public repository and remove the Insiders notes:

   ```powershell
   . ./tools/Set-EntraOpsPackRepository.ps1
   Set-EntraOpsPackRepository -Name EntraOps-MaesterPack -RemoveInsidersSection
   ```

   Run it **before** the build: it finds the current repository through `Homepage` of the copied manifest.
5. Generate the pack from a clone of the public EntraOps repository at the release tag:

   ```powershell
   git clone --branch <tag> --depth 1 https://github.com/Cloud-Architekt/EntraOps ../EntraOps-public
   ../EntraOps-public/Integrations/Maester/Build-EntraOpsMaesterPack.ps1 -OutputPath .
   ```

   Check `entraops-source.json`: public repository, the tag's commit, `"LocalChanges": false`.
6. Turn the internal parts into the public form (step 3).
7. Bring `TESTS.md`, the test counts in `README.md` and `CHANGELOG.md` in line with the generated `tests/`.
8. Verify (step 6).
9. Confirm with the user, then commit and push. Then the repository settings from the public `README.md`:
   - Import the ruleset `.github/rulesets/main.json`.
   - Turn on release immutability.
   - Allow GitHub Actions to create pull requests.
   - Set `PACK_RELEASES` to `true` when the user wants to release.
10. After the first release, and only with the user's confirmation: publish to the Maester Packs index
    (packs.maester.cloud). This registers the `Guid` and code `EOPS` to the public repository.

## 5. Sync the public repository (later)

1. Check the preconditions (step 1) for the new EntraOps tag.
2. In a clone of the public repository, on a new branch:
   - Port the changes of the pack-owned files of this repository since the last sync. Compare file by file
     (`git diff <last synced commit of this repository> -- <file>` here, or the files of both repositories). Skip the
     internal-only parts, and turn new internal wording into the public form (step 3). The PR body of the last sync
     names the commit of this repository it was taken from.
   - Generate the pack: run its **Sync from EntraOps** workflow for the tag, or build locally (step 4, item 5).
3. Update `CHANGELOG.md` (section `## <Version>`) and `TESTS.md`.
4. Verify (step 6).
5. Confirm with the user, then open a pull request in the public repository. Its body names the EntraOps tag and the
   commit of this repository the pack-owned files were taken from.

## 6. Verify before anything leaves this computer

- No internal references. This must find nothing:

  ```powershell
  git grep -n -i -E 'Insiders|entraops-insiders|EntraOps-Insiders-MaesterPack|internal pack|private repository|GH_TOKEN|ENTRAOPS_TOKEN'
  ```

  Every match must be removed. The exceptions are text meant for the public, for example `GH_TOKEN` as a way to
  raise GitHub's rate limit.
- No tenant data: `git grep -n -i -E 'onmicrosoft\.com|cloud-architekt\.net|cloudlab'` finds only `contoso` examples;
  `git ls-files` has no `test-results/`, `findings.json` other than `ci/fixtures/findings.json`, or `.DS_Store`.
- `entraops-source.json`: public EntraOps repository, released tag, `"LocalChanges": false`.
- The checks of the pack pass:

  ```powershell
  Invoke-Pester -Container (New-PesterContainer -ScriptBlock { . ./ci/PackChecks.ps1; Invoke-EntraOpsPackCheck })
  ```

- `Test-MtPack` of a copy with only the files of git: valid, Low risk.
- The links of the tests open (what the release workflow checks): the Docs page of each test exists in the
  public repository after the push, the EntraOps rule catalog and the documentation sections answer 200.
- Pack identity: the internal and the public pack share `Id`, `Guid` and `Code`. Before the first public
  release, test in a separate Maester folder (`$env:MAESTER_PACK_HOME`, project scope) what happens when the
  internal pack is installed and the public one is installed after it. Report the result to the user: they decide
  whether internal users must uninstall the internal pack first.

## Report back

- What was created or changed, with the EntraOps tag and the commit of this repository.
- The results of step 6, including the output of failed checks.
- Every outward step that is still open and needs the user's confirmation.
