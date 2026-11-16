**Fails when:** A role assignment scoped to an administrative unit is held by an object of a lower tier than privileged members of the unit. Members without restricted management (restricted management administrative unit, role-assignable group or a privileged directory role) can be managed by the holder, for example by resetting a password or changing group members, which gives it control over a more privileged object. Only roles with Control or Management Plane actions are evaluated; the tier of the holder is the more privileged of its own classification and its access. Service principals of Microsoft first-party applications are not reported: Microsoft operates them. The export does not tell which administrative unit restricts a member, so a role scoped to the restricted management administrative unit itself, which can manage its members, is not reported.

EntraOps evaluates this rule as EO.1006 (PrivilegedEAM.auScopeLowerTier). The EntraOps reports show the same result as the finding 'Administrative unit role of a lower tier'.

#### Remediation action

1. Move the privileged members (MemberObjectIds) out of the administrative unit, or into a restricted management administrative unit (restricted management can only be turned on when the unit is created).
2. Or assign the role on this administrative unit only to administrators of the members' tier.
3. Use role-assignable groups for privileged groups.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs a restricted management administrative unit or a new design of the unit's membership. | Low: Administrators of the unit can no longer manage the privileged members; regular members are not affected. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1006) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Restricted management administrative units](https://learn.microsoft.com/entra/identity/role-based-access-control/admin-units-restricted-management)
- [Assign Microsoft Entra roles with administrative unit scope](https://learn.microsoft.com/entra/identity/role-based-access-control/admin-units-assign-roles)
- [Privileged roles and permissions (who can reset passwords)](https://learn.microsoft.com/entra/identity/role-based-access-control/privileged-roles-permissions#who-can-reset-passwords)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
