**Fails when:** A user that is, or holds role assignments of, Tier 0 or 1 (Control, Management or Workload Plane) is the registered owner of devices that are not its associated privileged access workstation (by default the custom security attribute associatedSecureAdminWorkstation, with the device ID or the object ID of the device). Without an associated PAW, every owned device is reported (and EO.4008 for Control Plane users). The privileged account registered or uses regular devices, where its tokens are exposed to threats of daily work.

EntraOps evaluates this rule as EO.4007 (PrivilegedAssets.deviceNotPaw). The EntraOps reports show the same result as the finding 'Owns non-PAW devices'.

#### Remediation action

1. Remove the privileged account as owner of the device.
2. If the device is a PAW, add its object ID (not the device ID) to the associatedSecureAdminWorkstation attribute of the user.
3. Allow the privileged account only on its PAW, for example with a Conditional Access device filter.

| Implementation effort | User impact |
| --- | --- |
| Low: A device ownership change or an attribute value per user. | Low: The privileged account is used only on its PAW. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4007) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Securing devices as part of the privileged access story](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-devices)
- [Conditional Access: filter for devices](https://learn.microsoft.com/entra/identity/conditional-access/concept-condition-filters-for-devices)
- [Assign custom security attributes to users](https://learn.microsoft.com/entra/identity/users/users-custom-security-attributes)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
