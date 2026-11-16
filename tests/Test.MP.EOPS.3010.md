**Fails when:** Approvers are configured in the PIM setting, but 'Require approval to activate' is off, so the approvers have no effect. Approval was probably intended but is not enforced. Microsoft Graph keeps the approvers of the disabled approval rule, so this is common after approval was turned off. The PIM settings of Microsoft Entra roles are evaluated; those of Azure roles and PIM for Groups are not.

EntraOps evaluates this rule as EO.3010 (PimRequestFlow.approverNotEnforced). The EntraOps reports show the same result as the finding 'Approvers configured but approval not required'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Activation, turn on 'Require approval to activate', or remove the approvers if approval is not intended.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per role. | Medium: With approval turned on, every activation waits for an approver. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3010) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Approve or deny requests for Microsoft Entra roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-approval-workflow)
- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
