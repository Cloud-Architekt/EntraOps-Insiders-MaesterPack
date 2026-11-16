**Fails when:** The access drift report of Microsoft Entra ID Governance (Access Guardian, preview) shows active access package assignments whose membership or application role assignment of a Control or Management Plane group or application is missing. The access was removed outside of the access package, or provisioning failed. Target groups without a tier (no role assignment, Alternate Tier Level Attribute or Object Classification File entry) are not evaluated: EO.2005 reports them. The message names the date of the access drift report, which Microsoft Graph generates on its own schedule and can be days older than the evaluation.

EntraOps evaluates this rule as EO.6004 (AccessPackageFlow.missingAccess). The EntraOps reports show the same result as the finding 'Missing access on privileged access package resource'.

#### Remediation action

Reprocess the assignments in the access drift report of Microsoft Entra ID Governance (Access Guardian, preview), and find out why the access was removed outside of the access package.

| Implementation effort | User impact |
| --- | --- |
| Low: Reprocessing the assignment is one action. | Low: Assigned users get the access they requested back. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.6004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Entitlement management overview](https://learn.microsoft.com/entra/id-governance/entitlement-management-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
