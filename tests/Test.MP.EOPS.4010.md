**Reported when:** The privileged object belongs to another tenant, as its origin (OriginType and OriginTenantId of the Privileged EAM export, EntraOps 1.2.0 or later) names it: a guest invited from another tenant or an external user (also a B2B member user with an #EXT# user principal name), a user or group synchronized from another tenant (cross-tenant synchronization, also without #EXT#), the service principal of an application of another organization (Microsoft applications are not reported), or an object of another tenant with access through Tenant Governance (a group or member of the governing tenant, a remote group). Its credentials and lifecycle are controlled outside this tenant. Guests with privileged access are also reported by EO.4002, applications of other organizations with Control Plane access by EO.5001.

EntraOps evaluates this rule as EO.4010 (PrivilegedAssets.foreign). The EntraOps reports show the same result as the finding 'Outside home tenant'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

Check whether the privileges are still needed and who controls the object in its home tenant. Remove the privileges if they are not needed, or use an object of this tenant.

| Implementation effort | User impact |
| --- | --- |
| Low: A review per object, and removal if not needed. | Low: Only the external object loses access. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4010) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Properties of a B2B guest user](https://learn.microsoft.com/entra/external-id/user-properties)
- [Cross-tenant access settings for B2B collaboration](https://learn.microsoft.com/entra/external-id/cross-tenant-access-settings-b2b-collaboration)
- [EntraOps Tenant Governance](https://www.entraops.com/docs/tenant-governance/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
