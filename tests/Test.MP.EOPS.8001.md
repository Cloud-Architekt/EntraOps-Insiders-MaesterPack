**Reported when:** A role assignment classified as Control Plane exists in the newest Privileged EAM snapshot of the Privilege History, but not in the previous snapshot. PIM activations are not counted: they are temporary instances of eligible assignments. A role that was reclassified to Control Plane shows as new access. Both snapshots need objects with the role type of their assignments (Privilege History data of EntraOps 1.2.0 or later): the Privilege History keeps the objects of a limited number of snapshots. Delegated permissions are not counted here: EO.8003 reports new delegated Control and Management Plane permissions.

EntraOps evaluates this rule as EO.8001 (PrivilegeHistory.newControlPlaneAccess). The EntraOps reports show the same result as the finding 'New Control Plane access'. The check asks for a review, not a fix: its findings are reported as Investigate, not as Failed.

#### Remediation action

Check in the Privilege History and EAM Dashboard reports that the new Control Plane access was requested and approved, and remove it if not.

| Implementation effort | User impact |
| --- | --- |
| Low: A review of each new assignment. | Low: Only unexpected access is removed. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.8001) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [View audit history for Microsoft Entra roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-use-audit-log)
- [Microsoft Entra audit logs](https://learn.microsoft.com/entra/identity/monitoring-health/concept-audit-logs)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
