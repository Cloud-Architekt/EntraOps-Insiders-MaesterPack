**Fails when:** A service principal or application with Control or Management Plane access has owners. Owners can add credentials and act as the workload identity at any time, without a directory role, PIM activation or approval: standing access to its privileges. Service principals of Microsoft first-party applications are not reported. Delegated permissions do not count as access of the object: the application acts within the rights of the signed-in user (EO.5005 reports delegated Control Plane permissions).

EntraOps evaluates this rule as EO.7001 (PrivilegedEAM.privilegedWorkloadOwner). The EntraOps reports show the same result as the finding 'Owner of a privileged workload identity'.

#### Remediation action

Remove the owners. Manage the application with roles of its tier, for example Cloud Application Administrator scoped to the application and eligible in PIM, and restrict credentials with an app management policy.

| Implementation effort | User impact |
| --- | --- |
| Low: Removing an owner is a single change. | Low: Former owners use a scoped, eligible role instead. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.7001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Assign owners of an enterprise application](https://learn.microsoft.com/entra/identity/enterprise-apps/assign-app-owners)
- [Assign Microsoft Entra roles at different scopes](https://learn.microsoft.com/entra/identity/role-based-access-control/assign-roles-different-scopes)
- [App management policies (credential restrictions)](https://learn.microsoft.com/graph/api/resources/applicationauthenticationmethodpolicy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
