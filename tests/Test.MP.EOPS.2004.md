**Reported when:** A custom role of Entra ID or Azure grants permissions classified as Control Plane. Microsoft does not maintain custom roles: whoever can change the role definition can add Control Plane permissions to every assignment of the role at once. Only custom roles with assignments in the export are evaluated; for Azure roles, the tier can come from the scope of the assignment.

EntraOps evaluates this rule as EO.2004 (PrivilegedEAM.customRoleControlPlane). The EntraOps reports show the same result as the finding 'Custom role with Control Plane permissions'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

1. Review the actions of the custom role and remove those that are not needed.
2. Restrict who can change the role definition (Entra ID: Privileged Role Administrator; Azure: Microsoft.Authorization/roleDefinitions/write at its assignable scopes).
3. Use a built-in role if one fits.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs a review of the actions with the users of the role. | Low: Only actions that are removed from the role stop working. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.2004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Create a custom role in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/custom-create)
- [Azure custom roles](https://learn.microsoft.com/azure/role-based-access-control/custom-roles)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
