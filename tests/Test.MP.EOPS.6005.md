**Fails when:** An assignment policy of an access package that grants a Control or Management Plane resource has no expiration, so its assignments last until someone removes them, even when the person no longer needs the access.

EntraOps evaluates this rule as EO.6005 (TenantGovernance.accessPackageExpiration). The EntraOps reports show the same result as the finding 'Privileged access package without expiration'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Entitlement management > Access packages > the package > Policies > Lifecycle, set an expiration and allow users to request an extension with approval if they need the access longer.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per policy. | Low: Users extend or request the access again when it expires. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.6005) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Change lifecycle settings of an access package](https://learn.microsoft.com/entra/id-governance/entitlement-management-access-package-lifecycle-policy)
- [accessPackageAssignmentPolicy resource](https://learn.microsoft.com/graph/api/resources/accesspackageassignmentpolicy)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
