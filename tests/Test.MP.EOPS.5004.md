A service principal (application, managed identity or agent identity) holds Control Plane access. Workload identities cannot use PIM, so the access is permanent, and whoever controls its credentials, owners or the resource behind a managed identity has the same access. Service principals of Microsoft first-party applications are not reported. Delegated permissions do not count as access of the object: the application acts within the rights of the signed-in user (EO.5005 reports delegated Control Plane permissions).

EntraOps evaluates this rule as EO.5004 (PrivilegedEAM.workloadControlPlane). The EntraOps reports show the same result as the finding 'Workload identity with Control Plane access'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

1. Confirm that the workload needs Control Plane access, and reduce it to the permissions and scopes it needs.
2. Prefer managed identities or federated credentials over secrets.
3. Remove its owners, manage it with roles of its tier, and monitor its sign-ins.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs the workload's actual permission requirements. | Medium: Automation that needs the removed permissions stops working. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.5004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Workload identities](https://learn.microsoft.com/entra/workload-id/workload-identities-overview)
- [App management policies (credential restrictions)](https://learn.microsoft.com/graph/api/resources/applicationauthenticationmethodpolicy)
- [Secure access practices for administrators in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/security-planning)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
