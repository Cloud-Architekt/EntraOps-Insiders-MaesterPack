**Fails when:** The PIM setting of a Control or Management Plane role allows eligible assignments without expiration (the default of Entra ID roles). Eligibility that never expires is never reconsidered and stays when people change jobs. The tier of a role is the most privileged of its classification and of its current assignments, as the setting applies to every assignment of the role at any scope; only a role definition overwrite of the tenant can lower it. The PIM settings of Microsoft Entra roles are evaluated; those of Azure roles and PIM for Groups are not.

EntraOps evaluates this rule as EO.3004 (PimRequestFlow.permanentEligible). The EntraOps reports show the same result as the finding 'Permanent eligible assignment allowed for privileged role'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Assignment, clear 'Allow permanent eligible assignment' and set 'Expire eligible assignments after' (for example 1 year). Renew needed access with access reviews or access packages.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per role, which can be applied to all roles by script. | Low: Eligibility needs to be renewed when it expires. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3004) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [Use PIM APIs to update rules](https://learn.microsoft.com/graph/how-to-pim-update-rules)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
