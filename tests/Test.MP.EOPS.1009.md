The assignment policy requires approval, but its most privileged approver is classified at a lower tier than the most privileged resource of the access package. Any approver of a stage can approve, so a stage counts as its least privileged approver, and the approval of several stages as its strongest stage. Approvers count with their own classification, not the tier of their access, and a group approver as its least protected member (members without privileged access as User Access). A compromised lower-tier approver can grant access to the more privileged resource. Approvers that could not be resolved against the Privileged EAM data (for example the requestor's manager, or users without privileged access) and escalation approvers are not compared. Management and Workload Plane are both Tier 1, so they are no lower tier of each other. Policies with approval but without a resolved approver are not evaluated; the reason of the rule names their number.

EntraOps evaluates this rule as EO.1009 (AccessPackageFlow.approverLowerTier). The EntraOps reports show the same result as the finding 'Access package approver with lower tier'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Entitlement management > Access packages > the package > Policies, select approvers and fallback approvers classified at the tier of the resource, or move the privileged resource to a separate access package with approvers of its tier.

| Implementation effort | User impact |
| --- | --- |
| Low: One change of the approvers in the assignment policy. | Low: Other people approve the requests; requestors are not affected. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1009) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Change approval settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-approval-policy)
- [accessPackageAssignmentPolicy resource](https://learn.microsoft.com/graph/api/resources/accesspackageassignmentpolicy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
