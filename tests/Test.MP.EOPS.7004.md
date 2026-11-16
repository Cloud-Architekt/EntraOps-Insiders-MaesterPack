**Fails when:** Control Plane access is granted through a group that is a member of another group. Nesting hides who holds the access, and the owners and administrators of every group in the chain can change it. The export records the chain of groups of PIM for Groups memberships (eligible nested groups); the members of other groups are read transitively, so their nesting is not reported.

EntraOps evaluates this rule as EO.7004 (PrivilegedEAM.nestedControlPlaneGroup). The EntraOps reports show the same result as the finding 'Control Plane access through nested groups'.

#### Remediation action

Grant the access through one role-assignable group with direct eligible members, or remove the nesting.

| Implementation effort | User impact |
| --- | --- |
| Medium: The members of the nested groups move to one group. | Low: Members keep their access through the direct group. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.7004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Use Microsoft Entra groups to manage role assignments](https://learn.microsoft.com/entra/identity/role-based-access-control/groups-concept)
- [PIM for Groups](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/concept-pim-for-groups)
- [Best practices for Azure RBAC](https://learn.microsoft.com/azure/role-based-access-control/best-practices)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
