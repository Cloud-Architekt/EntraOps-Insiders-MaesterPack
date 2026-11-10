**Fails when:** A user that is Control Plane, or holds Control Plane role assignments, has no associated privileged access workstation (by default the custom security attribute associatedSecureAdminWorkstation). EntraOps cannot tie the account to a PAW, and Conditional Access device filters for PAWs cannot target it.

EntraOps evaluates this rule as EO.4008 (PrivilegedAssets.pawMissing). The EntraOps reports show the same result as the finding 'No associated PAW'.

#### Remediation action

Provide a PAW to the administrator and set its object ID in the associatedSecureAdminWorkstation attribute of the user.

| Implementation effort | User impact |
| --- | --- |
| High: Needs a managed and hardened PAW device per administrator. | Medium: Control Plane tasks are done on a dedicated device. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4008) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Privileged access deployment](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-deployment)
- [Securing devices as part of the privileged access story](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-devices)
- [Assign custom security attributes to users](https://learn.microsoft.com/entra/identity/users/users-custom-security-attributes)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
