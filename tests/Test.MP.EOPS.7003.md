An Azure assignment of User Access Administrator or Role Based Access Control Administrator has no condition. Its holder can assign any role, including Owner, to any principal at the scope, including itself, so it is effectively Owner of the scope. Members of a group with the assignment are not reported separately, nor are the service principals of Microsoft first-party applications (for example MS-PIM, which manages PIM for Azure resources).

EntraOps evaluates this rule as EO.7003 (PrivilegedEAM.unconstrainedRoleAssignmentDelegation). The EntraOps reports show the same result as the finding 'Unconstrained Azure role assignment delegation'.

#### Remediation action

Add a condition that constrains the delegation to the roles and principal types the holder needs to assign (under Conditions of the role assignment: 'Allow user to assign all roles except privileged administrator roles Owner, UAA, RBAC (Recommended)', 'Constrain roles', 'Constrain roles and principal types', 'Constrain roles and principals' or 'Allow all except specific roles'), or remove the assignment.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs the roles and principals that the holder delegates. | Low: The holder can only assign the roles and principals of the condition. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.7003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Delegate Azure role assignment management with conditions](https://learn.microsoft.com/azure/role-based-access-control/delegate-role-assignments-overview)
- [Delegate role assignment management with conditions (portal)](https://learn.microsoft.com/azure/role-based-access-control/delegate-role-assignments-portal)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
