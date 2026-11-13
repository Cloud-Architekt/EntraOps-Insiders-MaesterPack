**Reported when:** A group that an access package grants membership of has no role assignment EntraOps can classify, and no tier from the Group filters of the Alternate Tier Level Attributes or the Object Classification File (checked in this order, as in Privileged EAM). Such groups often control access outside of role-based access control, for example as Conditional Access exclusion, app assignment or Intune target, so the tier of the access the membership grants is unknown. The access package checks that compare tiers (approval, requestor scope, approver tier, access drift) cannot judge these groups. The tier of the members is not used: their other access is not granted by the access package.

EntraOps evaluates this rule as EO.2005 (AccessPackageFlow.unclassifiedTarget). The EntraOps reports show the same result as the finding 'Access package target group without classification'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

1. Decide which tier the access of the group belongs to (for example Management Plane for a Conditional Access exclusion group of administrators).
2. Add the group to the Object Classification File (ObjectClassificationFile of EntraOpsConfig.json) with the tier and a justification, or classify it with a Group filter of the Alternate Tier Level Attributes (for example by naming convention or administrative unit).
3. Generate the Access Package Flow data again (New-EntraOpsReportingData).

| Implementation effort | User impact |
| --- | --- |
| Low: One entry per group in the Object Classification File, or one Group filter for a naming convention. | Low: None: only the classification in EntraOps changes. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.2005) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Entitlement management overview](https://learn.microsoft.com/entra/id-governance/entitlement-management-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
