A User Access object (Tier 2) reaches a Management Plane service through a role assignment, directly or through a group. The object is protected like a regular user, but can manage workloads and resources of the Management Plane. Unclassified objects are not reported: their tier is unknown, so the check counts them apart and is skipped when only unclassified objects are affected (classify them, see EO.2001). Each result is one role assignment of the object with the Management Plane services of its classification (Services in the evidence); assignments that also reach a Control Plane service are reported by EO.1001. Delegated permissions and service principals of Microsoft first-party applications are not reported, as in EO.1001. Management and Workload Plane are both Tier 1 for this comparison. Eligible assignments count (PimAssignmentType in the evidence).

EntraOps evaluates this rule as EO.1003 (TierBreach.breach). The EntraOps reports show the same result as the finding 'Role assignment of a lower-tier object reaches a Management Plane service'.

#### Remediation action

1. Open the assignment in the Tier Breach Analyzer and check what causes it (direct, or the group in TransitiveBy).
2. If the access is not needed, remove the role assignment or group membership, or use a role or scope without Management Plane actions.
3. If it is needed, classify the object as Management Plane and protect it accordingly.

| Implementation effort | User impact |
| --- | --- |
| Medium: Each result is one assignment or membership, but reducing the scope or reclassifying the object needs the owner of the access. | Medium: Users lose access they use today, or have to use a Management Plane account with stricter controls. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Enterprise access model](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-access-model)
- [Secure access practices for administrators in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/security-planning)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
