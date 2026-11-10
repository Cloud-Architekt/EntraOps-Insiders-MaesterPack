**Fails when:** An assignment policy that accepts requests grants a Control or Management Plane resource without approval, so every allowed requestor gets the privileged access on request. Policies that only administrators can assign are not reported.

EntraOps evaluates this rule as EO.6001 (AccessPackageFlow.noApproval). The EntraOps reports show the same result as the finding 'No approval for privileged access package resource'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Entitlement management > Access packages > the package > Policies > Requests, turn on 'Require approval' with approvers of the resource's tier, and require a justification.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per policy, plus approvers who are available when needed. | Medium: Requests wait for approval. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.6001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Change approval settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-approval-policy)
- [Change request settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-request-policy)
- [accessPackageAssignmentPolicy resource](https://learn.microsoft.com/graph/api/resources/accesspackageassignmentpolicy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
