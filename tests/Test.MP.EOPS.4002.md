**Fails when:** A guest user holds Control or Management Plane access. The guest's home organization controls the authentication, credentials and lifecycle of the account, and controls of this tenant such as device compliance apply only when the cross-tenant access settings trust the home tenant. External users with a member account (userType Member) are not reported (EO.4011 reports those with Control Plane access). Principals of the managing tenant (ManagingTenantId of EntraOpsConfig.json, the governing tenant of Tenant Governance) are informational only: they pass, a note names them, and EO.4010 lists their role assignments.

EntraOps evaluates this rule as EO.4002 (PrivilegedEAM.guestPrivileged). The EntraOps reports show the same result as the finding 'Guest user with privileged access'.

#### Remediation action

Remove the access, or give the person a member account of this tenant that is classified and protected for its tier.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs a member account and the move of the role assignments. | Medium: The person signs in with a separate account of this tenant. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Properties of a B2B guest user](https://learn.microsoft.com/entra/external-id/user-properties)
- [Cross-tenant access settings for B2B collaboration](https://learn.microsoft.com/entra/external-id/cross-tenant-access-settings-b2b-collaboration)
- [Secure access practices for administrators in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/security-planning)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
