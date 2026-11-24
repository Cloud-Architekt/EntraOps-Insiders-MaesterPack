**Fails when:** The access drift report of Microsoft Entra ID Governance (Access Guardian, preview) shows members or application role assignments of a Control or Management Plane group or application of an access package without a corresponding access package assignment: privileged access granted outside of governance, without approval, expiration or review. Target groups without a tier (no role assignment, Alternate Tier Level Attribute or Object Classification File entry) are not evaluated: EO.2005 reports them. The message names the date of the access drift report, which Microsoft Graph generates on its own schedule and can be days older than the evaluation.

EntraOps evaluates this rule as EO.6003 (AccessPackageFlow.unauthorizedAccess). The EntraOps reports show the same result as the finding 'Unauthorized access to privileged access package resource'.

#### Remediation action

Review the unauthorized access in the access drift report of Microsoft Entra ID Governance (Access Guardian, preview; examples in the evidence): remove it, or have it requested through the access package.

| Implementation effort | User impact |
| --- | --- |
| Medium: Each unauthorized member needs a decision with the resource owner. | Medium: Members without an access package assignment lose access until they request it. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.6003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Entitlement management overview](https://learn.microsoft.com/entra/id-governance/entitlement-management-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
