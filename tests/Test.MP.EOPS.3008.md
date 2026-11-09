Active assignments of a Control or Management Plane role can be created without multifactor authentication at assignment time ('Require Multi-Factor Authentication on active assignment' is off, Graph rule Enablement_Admin_Assignment). A hijacked administrator session can grant active access without authenticating again.

EntraOps evaluates this rule as EO.3008 (PimRequestFlow.noMfaActiveAssign). The EntraOps reports show the same result as the finding 'Privileged role can be assigned as active without MFA'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Assignment, turn on 'Require Multi-Factor Authentication on active assignment'.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per role. | Low: Only administrators who create active assignments authenticate again. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3008) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [Use PIM APIs to update rules](https://learn.microsoft.com/graph/how-to-pim-update-rules)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
