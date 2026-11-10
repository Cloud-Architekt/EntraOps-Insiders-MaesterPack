**Fails when:** An administrative unit with dynamic membership contains Control or Management Plane objects. Whoever can change the attributes of its membership rule (for example the user principal name) can add privileged objects to it or remove them, and so change which administrators manage them.

EntraOps evaluates this rule as EO.7005 (TenantGovernance.dynamicPrivilegedAdministrativeUnit). The EntraOps reports show the same result as the finding 'Dynamic administrative unit with privileged members'.

#### Remediation action

Use assigned membership for administrative units with privileged members, or make sure that only administrators of the members' tier can change the attributes of the membership rule.

| Implementation effort | User impact |
| --- | --- |
| Medium: Membership has to be maintained by assignment or a provisioning process. | Low: No change for the members. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.7005) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Manage dynamic membership rules of administrative units](https://learn.microsoft.com/entra/identity/role-based-access-control/admin-units-members-dynamic)
- [Restricted management administrative units](https://learn.microsoft.com/entra/identity/role-based-access-control/admin-units-restricted-management)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
