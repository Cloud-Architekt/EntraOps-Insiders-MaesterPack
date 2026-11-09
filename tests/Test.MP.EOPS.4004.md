A group with Control or Management Plane access is neither role-assignable nor a member of a restricted management administrative unit. Group owners and administrators who can manage groups (for example Groups Administrator or User Administrator) can then change its members and take over its access.

EntraOps evaluates this rule as EO.4004 (PrivilegedEAM.unprotectedPrivilegedGroup). The EntraOps reports show the same result as the finding 'Privileged group without restricted management'.

#### Remediation action

Use a role-assignable group (role-assignable can only be set when the group is created) and move the role assignments to it, or add the group to a restricted management administrative unit.

| Implementation effort | User impact |
| --- | --- |
| Medium: A role-assignable group has to be created and the assignments moved to it. | Low: Only administrators who manage the group's members are affected. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Use Microsoft Entra groups to manage role assignments](https://learn.microsoft.com/entra/identity/role-based-access-control/groups-concept)
- [Create a role-assignable group](https://learn.microsoft.com/entra/identity/role-based-access-control/groups-create-eligible)
- [Restricted management administrative units](https://learn.microsoft.com/entra/identity/role-based-access-control/admin-units-restricted-management)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
