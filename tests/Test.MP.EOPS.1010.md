**Fails when:** Principals assigned through this policy have a more privileged tier than the approval of the policy (any approver of a stage can approve, so a stage counts as its least privileged resolved approver, with the approver's own classification and a group as its least protected member), so the approval of their access is weaker than the tier they hold. The tier of a principal is the more privileged of its own classification and its access, as for the tier of an object in the other rules: a principal with Control Plane access is a Control Plane asset, whatever its classification. A single user approver that is not in the Privileged EAM data counts as User Access; approvers that cannot be resolved (the requestor's manager, sponsors, a group that EntraOps does not collect) are not compared. A group approver without members is not compared, never with the tier of its access; fallback approvers are compared and marked '(fallback)'. Management and Workload Plane are both Tier 1, so they are no lower tier of each other. Policies with approval but without a resolved approver are not evaluated; the reason of the rule names them by cause: approver groups without members, policies missing from the live access package data (the snapshot has no approver IDs), and approvers that could not be resolved.

EntraOps evaluates this rule as EO.1010 (AccessPackageFlow.assignedMorePrivileged). The EntraOps reports show the same result as the finding 'Assigned principal more privileged than approver'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Entitlement management > Access packages > the package > Policies, select approvers classified at the tier of the assigned principals, or assign privileged principals through a separate policy with approvers of their tier.

| Implementation effort | User impact |
| --- | --- |
| Low: One change of the approvers, or one additional policy. | Low: Other people approve the requests; requestors are not affected. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1010) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Change approval settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-approval-policy)
- [accessPackageAssignmentPolicy resource](https://learn.microsoft.com/graph/api/resources/accesspackageassignmentpolicy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
