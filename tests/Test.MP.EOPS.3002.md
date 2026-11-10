**Fails when:** A user holds Control Plane access through a permanent (active) membership of a group whose role assignment is permanent as well, instead of an eligible membership in PIM for Groups or an eligible assignment of the group. The access is standing, and anyone who can manage the group's members can grant it. Permanent members of a group with an eligible role assignment are not reported: they have to activate the role. Neither are members of a group whose role assignment is delegated access of Tenant Governance: the managing tenant grants it, so it cannot be made eligible here.

EntraOps evaluates this rule as EO.3002 (PrivilegedEAM.permanentControlPlaneMembership). The EntraOps reports show the same result as the finding 'Permanent membership in a Control Plane group'.

#### Remediation action

1. Manage the group with PIM for Groups (Privileged Identity Management > Groups).
2. Make the user an eligible member, or make the role assignment of the group eligible in PIM.
3. Remove the active membership.

| Implementation effort | User impact |
| --- | --- |
| Medium: The group needs PIM for Groups, and members move to eligible memberships. | Medium: Members have to activate the membership before each use. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [PIM for Groups](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/concept-pim-for-groups)
- [Assign eligibility for a group in PIM for Groups](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/groups-assign-member-owner)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
