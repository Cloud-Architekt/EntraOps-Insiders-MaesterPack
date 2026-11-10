**Fails when:** The newest Privileged EAM snapshot of the Privilege History has a tier breach that the previous snapshot does not have: a user or service principal holds a role assignment classified at a more privileged tier than the object. Tier breaches follow EO.1001 and EO.1003: Management and Workload Plane are both Tier 1, delegated permissions (EO.8003) and service principals of Microsoft first-party applications are not counted, and new breaches of unclassified objects (counted as User Access) are counted apart instead of being reported, as their tier is unknown (classify them, EO.2001). PIM activations are not counted: they are temporary instances of eligible assignments (as in EO.8001). Every new breach fails, also when others were removed and the number did not increase. The Privilege History chart counts every tier breach, including delegated permissions and Microsoft applications, so its number can be higher. A new breach can also come from a reclassified object or role. Both snapshots need objects with the role type of their assignments (Privilege History data of EntraOps 1.2.0 or later).

EntraOps evaluates this rule as EO.8002 (PrivilegeHistory.tierBreachIncrease). The EntraOps reports show the same result as the finding 'New tier breach since the previous snapshot'.

#### Remediation action

1. Review the new tier breaches in the affected results, and in the Privilege History and Tier Breach Analyzer reports (EO.1001, EO.1003).
2. Remove the role assignments that are not needed, or move them to an account of the matching tier.
3. If the access is intended, reclassify the object to the tier of the role and protect it accordingly.

| Implementation effort | User impact |
| --- | --- |
| Low: A review of the change between two snapshots. | Low: Depends on the tier breaches that are removed. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.8002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Enterprise access model](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-access-model)
- [View audit history for Microsoft Entra roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-use-audit-log)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
