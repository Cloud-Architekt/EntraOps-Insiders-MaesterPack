**Reported when:** A delegated permission classified as Control or Management Plane exists in the newest Privileged EAM snapshot of the Privilege History, but not in the previous snapshot: an administrator or a user consented to it, for example Directory.ReadWrite.All or Mail.Read for a new application. The application acts within the rights of the signed-in user, so it is no tier breach (EO.1001 to EO.1003, EO.8002), but whoever controls the application (its owners, credentials or redirect URIs) can obtain tokens of the users who sign in to it, and illicit consent grants are a common phishing technique. A new scope of an existing grant counts as new. Service principals of Microsoft first-party applications are not reported, except the Microsoft clients whose delegated permissions the tenant grants by consent (Microsoft Graph Command Line Tools, Graph Explorer). Both snapshots need objects with the role type of their assignments (Privilege History data of EntraOps 1.2.0 or later).

EntraOps evaluates this rule as EO.8003 (PrivilegeHistory.newDelegatedPrivilegedPermission). The EntraOps reports show the same result as the finding 'New delegated privileged permission'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

1. Find who consented and when in the Microsoft Entra audit logs (activity 'Consent to application').
2. If the permission is not needed, revoke it in Microsoft Entra admin center > Enterprise applications > the application > Permissions, or remove the delegated permission grant with Microsoft Graph PowerShell (Remove-MgOauth2PermissionGrant).
3. Restrict user consent to permissions classified as low impact from verified publishers, and use the admin consent workflow, so privileged permissions need an administrator's review.

| Implementation effort | User impact |
| --- | --- |
| Low: A review of each new consent. | Low: Users of the application consent again, or request admin consent, if a needed grant is revoked. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.8003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Detect and remediate illicit consent grants](https://learn.microsoft.com/defender-office-365/detect-and-remediate-illicit-consent-grants)
- [Configure how users consent to applications](https://learn.microsoft.com/entra/identity/enterprise-apps/configure-user-consent)
- [Configure the admin consent workflow](https://learn.microsoft.com/entra/identity/enterprise-apps/configure-admin-consent-workflow)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
