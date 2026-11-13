**Fails when:** A user or service principal that is not Control Plane (unclassified objects count as Tier 2) reaches a Control Plane service through a role assignment, directly or through a group. The object is protected for its own, lower tier, so whoever compromises it gets Control Plane access. Each result is one role assignment of the object (at its scope, directly or through the group in TransitiveBy) with the Control Plane services of its classification (Services in the evidence). Delegated permissions are reported by EO.5005: the application acts within the rights of the signed-in user. Service principals of Microsoft first-party applications are not reported; the Tier Breach Analyzer still shows their paths. Eligible assignments count (PimAssignmentType in the evidence); a PIM activation is not reported apart from its eligible assignment.

EntraOps evaluates this rule as EO.1001 (TierBreach.tier0Breach). The EntraOps reports show the same result as the finding 'Role assignment of a lower-tier object reaches a Control Plane service'.

#### Remediation action

1. Open the assignment in the Tier Breach Analyzer and check what causes it (direct, or the group in TransitiveBy).
2. If the access is not needed, remove the role assignment or group membership, or use a role or scope without Control Plane actions.
3. If it is needed, classify the object as Control Plane and protect it accordingly: cloud-only account, phishing-resistant authentication, PAW and restricted management.

| Implementation effort | User impact |
| --- | --- |
| Medium: Each result is one assignment or membership, but reducing the scope or reclassifying the object needs the owner of the access. | Medium: Administrators lose access they use today, or have to use a Control Plane account with stricter controls. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Enterprise access model](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-access-model)
- [Secure access practices for administrators in Microsoft Entra ID](https://learn.microsoft.com/entra/identity/role-based-access-control/security-planning)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
