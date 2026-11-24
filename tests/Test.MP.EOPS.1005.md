**Fails when:** This object owns another object that needs a more privileged tier (by its own tier or its role assignments). Through the ownership it can take over the owned object and its privileges, so it effectively belongs to the more privileged tier. The owned object is reported by EO.1004. The required tiers count role assignments without delegated permissions.

EntraOps evaluates this rule as EO.1005 (PrivilegedAssets.ownsHigherTier). The EntraOps reports show the same result as the finding 'Owns higher-tier object'.

#### Remediation action

1. Remove this object from the owners of the more privileged object (RelatedObjectIds).
2. If the ownership is needed, classify this object at the tier of the owned object and protect it accordingly.

| Implementation effort | User impact |
| --- | --- |
| Low: Removing an owner is a single change per object. | Low: The owner loses self-service management of the more privileged object. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1005) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Assign owners of an enterprise application](https://learn.microsoft.com/entra/identity/enterprise-apps/assign-app-owners)
- [Manage groups in Microsoft Entra ID](https://learn.microsoft.com/entra/fundamentals/how-to-manage-groups)
- [Assign Microsoft Entra roles at different scopes](https://learn.microsoft.com/entra/identity/role-based-access-control/assign-roles-different-scopes)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
