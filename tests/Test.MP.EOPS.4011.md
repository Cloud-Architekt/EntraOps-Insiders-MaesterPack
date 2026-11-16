**Fails when:** A user or group that another tenant manages holds Control Plane access: a user or group of cross-tenant synchronization, an external member (#EXT# with userType Member), or a group or member of another tenant with access through Tenant Governance (for example a remote group). The other tenant controls its credentials, authentication, membership and lifecycle, so a compromise of that tenant gives Control Plane access to this tenant, and controls of this tenant such as restricted management or Conditional Access may not apply. The principals of the managing tenant (ManagingTenantId of EntraOpsConfig.json, the governing tenant of Tenant Governance) pass: their access is the design of the relationship, and a note names them. Guests are reported by EO.4002, service principals of applications of other organizations by EO.5001, and every role assignment of a principal of another tenant is listed by EO.4010. The origin of synchronized and governed objects is exported since EntraOps 1.2.0; older exports recognize only external users and objects of another tenant.

EntraOps evaluates this rule as EO.4011 (PrivilegedEAM.foreignPrincipalControlPlane). The EntraOps reports show the same result as the finding 'Privileged principal managed by another tenant'.

#### Remediation action

1. Check who manages the principal in its tenant and why it needs Control Plane access in this tenant.
2. Move the access to a cloud-only account of this tenant that is classified and protected for the Control Plane, or to a role-assignable group of this tenant, and remove it from the principal of the other tenant.
3. If the other tenant governs this tenant by design (Tenant Governance), set ManagingTenantId and ManagingTenantName in EntraOpsConfig.json to the governing tenant, so its principals are accepted; protect the governing tenant like this tenant's Control Plane.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs an account or group of this tenant and the move of the role assignments; or one setting for the governing tenant. | Medium: The administrators sign in with an account of this tenant instead of their account of the other tenant. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4011) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Cross-tenant synchronization](https://learn.microsoft.com/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview)
- [Properties of a B2B guest user](https://learn.microsoft.com/entra/external-id/user-properties)
- [Secure access practices for administrators in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/security-planning)
- [EntraOps Tenant Governance](https://www.entraops.com/docs/tenant-governance/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
