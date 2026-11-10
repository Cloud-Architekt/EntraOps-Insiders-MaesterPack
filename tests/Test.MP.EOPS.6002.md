**Fails when:** An assignment policy grants a Control or Management Plane resource and accepts requests from all directory members, all users including guests, all external users, or the users of all (configured or existing) connected organizations. Every account in that scope can request privileged access, so approval is the only barrier. Policies that do not accept requests are not reported.

EntraOps evaluates this rule as EO.6002 (AccessPackageFlow.broadRequestor). The EntraOps reports show the same result as the finding 'Broad requestor scope for privileged access package resource'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Entitlement management > Access packages > the package > Policies > Requests, limit who can request access to specific users or groups of the resource's tier.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per policy. | Low: Users outside the selected groups can no longer request the access package. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.6002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Change request settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-request-policy)
- [accessPackageAssignmentPolicy resource](https://learn.microsoft.com/graph/api/resources/accesspackageassignmentpolicy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
