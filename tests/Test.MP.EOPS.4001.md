An object that is Control Plane, or holds Control Plane role assignments (unclassified objects included), is synchronized from Active Directory. Administrators of Active Directory and of the synchronization server can reset its password or change it, so the on-premises environment becomes part of the Control Plane.

EntraOps evaluates this rule as EO.4001 (PrivilegedAssets.hybridPrivileged). The EntraOps reports show the same result as the finding 'Synchronized Control Plane identity'.

#### Remediation action

Create a cloud-only account or group for the Control Plane privileges, move the role assignments to it, and remove the privileges from the synchronized object.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs a new cloud-only object and the move of its role assignments. | Medium: Administrators use a separate cloud-only account for Control Plane tasks. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Protect Microsoft 365 from on-premises attacks](https://learn.microsoft.com/entra/architecture/protect-m365-from-on-premises-attacks)
- [Secure access practices for administrators in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/security-planning)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
