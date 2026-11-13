**Fails when:** A user holds a Control Plane role of Entra ID or Azure through a permanent (active) direct assignment instead of an eligible assignment in Privileged Identity Management. Standing access is usable at any time without activation, MFA, approval or justification, and is the main target of credential and token theft. PIM activations and time-bound active assignments are not reported, nor is delegated access of Tenant Governance (granted by the managing tenant). Emergency access accounts of Findings.EmergencyAccessAccounts (object ID or user principal name of the account; display names and groups in the setting don't exclude anyone here) are expected here and not reported; the reason of the rule names them.

EntraOps evaluates this rule as EO.3001 (PrivilegedEAM.permanentControlPlaneAssignment). The EntraOps reports show the same result as the finding 'Permanent Control Plane role assignment'.

#### Remediation action

1. Create an eligible assignment for the user in PIM (Microsoft Entra roles or Azure resources).
2. Remove the active assignment.
3. Keep permanent assignments only for monitored emergency access accounts.

| Implementation effort | User impact |
| --- | --- |
| Low: Converting an assignment to eligible is one change per assignment. | Medium: The administrator has to activate the role before each use. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Assign Microsoft Entra roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user)
- [Assign Azure resource roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-resource-roles-assign-roles)
- [Manage emergency access accounts](https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
