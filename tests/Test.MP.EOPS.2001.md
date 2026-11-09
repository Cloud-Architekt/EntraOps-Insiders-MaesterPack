The privileged object has no object tier: no custom security attribute, no entry in the Object Classification File and no Alternate Tier Level Attribute. The finding rules treat it like Tier 2 (User Access), so tier-based protection such as Conditional Access by tier, restricted management or PAW is not applied, and the tier analysis treats its access as a breach. Service principals of Microsoft first-party applications are not reported: Microsoft operates them.

EntraOps evaluates this rule as EO.2001 (PrivilegedAssets.unclassified). The EntraOps reports show the same result as the finding 'Unclassified object'.

#### Remediation action

1. Decide the tier from the role assignments of the object (AssignmentTierName in the evidence).
2. Set it with the custom security attributes (by default adminTierLevel and adminTierLevelName, both consistently; users and service principals have their own attribute set names in EntraOpsConfig.json), the Object Classification File (also for groups, which have no custom security attributes) or an Alternate Tier Level Attribute. Applications take the tier of their service principal.
3. Apply the protection of that tier.

| Implementation effort | User impact |
| --- | --- |
| Low: Setting the tier is metadata only; applying the tier's protection can take more effort. | Low: No change for the user until tier-based policies apply to the object. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.2001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Add or deactivate custom security attribute definitions](https://learn.microsoft.com/entra/fundamentals/custom-security-attributes-add)
- [Assign custom security attributes to users](https://learn.microsoft.com/entra/identity/users/users-custom-security-attributes)
- [Assign custom security attributes to applications](https://learn.microsoft.com/entra/identity/enterprise-apps/custom-security-attributes-apps)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
