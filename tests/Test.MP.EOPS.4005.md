**Fails when:** A user or group that is, or holds role assignments of, Tier 0 or 1 (Control, Management or Workload Plane) is not protected by restricted management (a directory role, a role-assignable group or a restricted management administrative unit). Helpdesk, user and group administrators can then reset its credentials or change its members. A directory role protects its holder, also when it is eligible only or scoped to an administrative unit, except the roles whose holders Helpdesk, Password, Authentication or User Administrators can still manage: Directory Readers, Guest Inviter, Password Administrator, Helpdesk Administrator, Message Center Reader, Reports Reader, User Experience Success Manager, Usage Summary Reports Reader, Authentication Administrator, Groups Administrator and User Administrator. A role-assignable group in a restricted management administrative unit ('Conflict' in the Privileged Assets report) is protected by the group and not reported. A group with Control or Management Plane access is reported by EO.4004 instead; this rule reports such groups only when they are privileged by their classification. Objects of another tenant with access through Tenant Governance are managed in their tenant and not reported.

EntraOps evaluates this rule as EO.4005 (PrivilegedAssets.restrictedManagementGap). The EntraOps reports show the same result as the finding 'Restricted management not applied'.

#### Remediation action

Add the object to a restricted management administrative unit, or grant its privileges through a role-assignable group.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs a restricted management administrative unit or a role-assignable group. | Low: Helpdesk can no longer manage the object; its tier's administrators do. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4005) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Restricted management administrative units](https://learn.microsoft.com/entra/identity/role-based-access-control/admin-units-restricted-management)
- [Use Microsoft Entra groups to manage role assignments](https://learn.microsoft.com/entra/identity/role-based-access-control/groups-concept)
- [Privileged roles and permissions (who can reset passwords)](https://learn.microsoft.com/entra/identity/role-based-access-control/privileged-roles-permissions#who-can-reset-passwords)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
