A service principal of a multi-tenant application of another organization (the tenant of the application, exported since EntraOps 1.2.0; Microsoft applications are not reported) holds Control Plane access. The other organization controls the credentials and code of the application, so a compromise of that vendor gives Control Plane access to this tenant. Delegated permissions do not count as access of the object: the application acts within the rights of the signed-in user (EO.5005 reports delegated Control Plane permissions). Without the tenant of the applications in the export (EntraOps before 1.2.0), the rule is skipped.

EntraOps evaluates this rule as EO.5001 (PrivilegedEAM.foreignWorkloadControlPlane). The EntraOps reports show the same result as the finding 'Workload identity of another tenant with Control Plane access'.

#### Remediation action

1. Remove the Control Plane permissions, or reduce them to the scope the application needs.
2. If the vendor requires them, document the risk, monitor the service principal's sign-ins, ask the vendor to enable app instance property lock on its application (only the home tenant of the application can set it) and review its consent. Conditional Access for workload identities cannot target it: it supports only single-tenant applications of this tenant.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs the vendor's requirements and possibly a change of the integration. | Medium: Features of the application that need the permissions stop working. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.5001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Workload identities](https://learn.microsoft.com/entra/workload-id/workload-identities-overview)
- [App instance property lock](https://learn.microsoft.com/entra/identity-platform/howto-configure-app-instance-property-locks)
- [Conditional Access for workload identities (single-tenant only)](https://learn.microsoft.com/entra/identity/conditional-access/workload-identity)
- [Review and revoke permissions granted to applications](https://learn.microsoft.com/entra/identity/enterprise-apps/manage-application-permissions)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
