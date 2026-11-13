**Reported when:** An application has a delegated permission classified as Control Plane (for example Directory.ReadWrite.All). When a privileged user signs in, the application acts with this permission within the user's privileges, so the application, its credentials and its owners become a path to the user's Control Plane access. Microsoft first-party applications (for example Azure CLI and Azure PowerShell) are not reported, except Microsoft Graph Command Line Tools, Graph Explorer, Microsoft Intune PowerShell, SharePoint Online Web Client Extensibility, Microsoft Developer Sample Data Packs, Azure AD Assessment and M365 Lighthouse API: their delegated permissions exist only by consent of this tenant, which can revoke them. Each grant is one result, named with its consent: a grant for all users (admin consent) and the grant of one user for the same permission are two results.

EntraOps evaluates this rule as EO.5005 (PrivilegedEAM.delegatedControlPlanePermission). The EntraOps reports show the same result as the finding 'Delegated Control Plane permission'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

Review the consent of the application: revoke delegated permissions that are not needed (admin consent grants them for every user who signs in), grant consent only for the users who need the application (oAuth2PermissionGrant with consentType Principal) instead of all users (AllPrincipals), and restrict who can manage the application.

| Implementation effort | User impact |
| --- | --- |
| Low: Revoking a consent grant is one change per permission. | Medium: Features of the application that use the permission stop working. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.5005) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Permissions and consent in the Microsoft identity platform](https://learn.microsoft.com/entra/identity-platform/permissions-consent-overview)
- [Review and revoke permissions granted to applications](https://learn.microsoft.com/entra/identity/enterprise-apps/manage-application-permissions)
- [oAuth2PermissionGrant resource (consentType)](https://learn.microsoft.com/graph/api/resources/oauth2permissiongrant)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
