Activation of this privileged role requires approval, but an approver could not be resolved against the Privileged EAM data, for example a guest, a user without privileged access or a group that EntraOps does not collect. Its tier cannot be compared with the role, so a lower-tier approver can go unnoticed.

EntraOps evaluates this rule as EO.2003 (PimRequestFlow.approverUnclassified). The EntraOps reports show the same result as the finding 'Activation approver not resolved'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Activation, replace the approver with a classified user or group of the role's tier, or classify the approver (for example in the Object Classification File) so EntraOps can compare it.

| Implementation effort | User impact |
| --- | --- |
| Low: One change of the approvers or one classification entry. | Low: Other people may approve the activations. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.2003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Approve or deny requests for Microsoft Entra roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-approval-workflow)
- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
