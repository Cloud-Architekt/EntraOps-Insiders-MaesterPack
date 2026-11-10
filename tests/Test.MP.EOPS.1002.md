**Fails when:** A classified object holds role assignments of a more privileged tier than its own object tier, for example a Management Plane account with a Control Plane role. The object is protected for its own tier only, so whoever compromises it gets the access of the higher tier. Unclassified objects are reported by EO.2001. Management and Workload Plane are both Tier 1, so they are no breach of each other. The role assignments are compared without delegated permissions: the application acts within the rights of the signed-in user (EO.5005). Service principals of Microsoft first-party applications are reported as well: their tier is the classification of the tenant.

EntraOps evaluates this rule as EO.1002 (PrivilegedAssets.tierBreach). The EntraOps reports show the same result as the finding 'Object tier below role assignments'.

#### Remediation action

1. Open the object in Privileged Assets and review its role assignments of the higher tier.
2. Remove the assignments that exceed the object tier, or move them to an account of the matching tier.
3. If the access is intended, raise the object tier (custom security attribute, Object Classification File or Alternate Tier Level Attribute) and apply the protection of that tier.

| Implementation effort | User impact |
| --- | --- |
| Medium: Either the assignments move to another account, or the object is reclassified and protected for the higher tier. | Medium: Administrators may need a separate account of the higher tier for these tasks. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Enterprise access model](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-access-model)
- [Custom security attributes in Microsoft Entra ID](https://learn.microsoft.com/entra/fundamentals/custom-security-attributes-overview)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
