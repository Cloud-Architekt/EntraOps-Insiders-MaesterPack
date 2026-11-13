**Fails when:** Activations of a Control Plane role can last longer than the configured maximum (Findings.ControlPlaneActivationMaxHours, default 4 hours; the PIM default is 8 hours). The longer an activation lasts, the longer a stolen session or token holds Control Plane access. The tier of a role is the most privileged of its classification and of its current assignments, as the setting applies to every assignment of the role at any scope; only a role definition overwrite of the tenant can lower it. The PIM settings of Microsoft Entra roles are evaluated; those of Azure roles and PIM for Groups are not.

EntraOps evaluates this rule as EO.3013 (TenantGovernance.controlPlaneActivationDuration). The EntraOps reports show the same result as the finding 'Long Control Plane role activation'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Activation, reduce 'Activation maximum duration (hours)' to the configured maximum or less.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per role. | Low: Long tasks need a second activation. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3013) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [Use PIM APIs to update rules](https://learn.microsoft.com/graph/how-to-pim-update-rules)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
