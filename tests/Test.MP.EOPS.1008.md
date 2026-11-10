**Fails when:** Activation of this Control or Management Plane role requires approval, but at least one approver is classified at a lower tier than the role. The approver's own classification counts, not the tier of its access: an approver with access above its classification is not protected for that access, so it does not count as adequately protected. A group approver counts as its least protected member. A compromised lower-tier approver can approve activations of the more privileged role, which defeats approval as a control. Management and Workload Plane are both Tier 1, so they are no lower tier of each other.

EntraOps evaluates this rule as EO.1008 (PimRequestFlow.approverLowerTier). The EntraOps reports show the same result as the finding 'Activation approver with lower tier'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Activation, replace the approvers with users or a role-assignable group classified at the tier of the role or above.

| Implementation effort | User impact |
| --- | --- |
| Low: One change of the approvers in the PIM role setting. | Low: Other people approve the activations; the activation itself does not change. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1008) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Approve or deny requests for Microsoft Entra roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-approval-workflow)
- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
