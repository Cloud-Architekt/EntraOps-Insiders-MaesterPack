**Fails when:** An assignment policy of an access package that grants a Control or Management Plane resource has no recurring access review, so nobody confirms that the assigned users still need the privileged access. Target groups without a tier (no role assignment, Alternate Tier Level Attribute or Object Classification File entry) are not evaluated: EO.2005 reports them.

EntraOps evaluates this rule as EO.6006 (TenantGovernance.accessPackageAccessReview). The EntraOps reports show the same result as the finding 'Privileged access package without access review'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Entitlement management > Access packages > the package > Policies > Lifecycle, turn on recurring access reviews with reviewers of the resource's tier (not a self-review), and remove access when reviewers do not respond.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per policy, plus reviewers. | Low: Reviewers confirm access regularly; users without a confirmation lose it. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.6006) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Create an access review of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-reviews-create)
- [Change lifecycle settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-lifecycle-policy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
