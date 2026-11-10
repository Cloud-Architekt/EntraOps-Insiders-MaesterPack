**Fails when:** An owner of this privileged object is classified at a lower tier or is unclassified. Owners manage the object without a directory role: they can add credentials to an application or service principal, or change the members of a group, and so use its privileges. The owner becomes a path into the more privileged tier. Owners that are not privileged objects of the export (no role assignment of their own) count as Tier 2, so an owner without privileged access is reported even when it is classified in the tenant: check its classification before you remove it. EO.1005 reports the other side when the owner is a privileged object whose required tier, including its own role assignments, is lower than the owned object's. The required tier of the object counts its role assignments without delegated permissions. Service principals of Microsoft first-party applications are reported as well: their owners in this tenant can still manage the service principal.

EntraOps evaluates this rule as EO.1004 (PrivilegedAssets.ownerLowerTier). The EntraOps reports show the same result as the finding 'Owner with lower tier'.

#### Remediation action

1. Review the owners in the result and the evidence (RelatedObjectNames, RelatedObjectIds).
2. Remove the owners that do not need to manage the object, and manage it with a role of its tier instead (for example Cloud Application Administrator scoped to the application, eligible in PIM).
3. If an owner is needed, use an account classified at the tier of the object.

| Implementation effort | User impact |
| --- | --- |
| Low: Removing an owner is a single change per object. | Low: Former owners lose self-service management and use a scoped role instead. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Assign owners of an enterprise application](https://learn.microsoft.com/entra/identity/enterprise-apps/assign-app-owners)
- [Manage groups in Microsoft Entra ID](https://learn.microsoft.com/entra/fundamentals/how-to-manage-groups)
- [Assign Microsoft Entra roles at different scopes](https://learn.microsoft.com/entra/identity/role-based-access-control/assign-roles-different-scopes)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
