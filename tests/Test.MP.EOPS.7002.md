A group with Control or Management Plane access has owners. Owners can add members, including themselves, at any time without approval or PIM, and so grant the group's privileges.

EntraOps evaluates this rule as EO.7002 (PrivilegedEAM.privilegedGroupOwner). The EntraOps reports show the same result as the finding 'Owner of a privileged group'.

#### Remediation action

Remove the owners, or make the ownership eligible in PIM for Groups with approval on activation.

| Implementation effort | User impact |
| --- | --- |
| Low: Removing an owner is a single change. | Low: Former owners use an eligible, approved ownership instead. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.7002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Assign eligibility for a group in PIM for Groups](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/groups-assign-member-owner)
- [PIM for Groups](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/concept-pim-for-groups)
- [Manage groups in Microsoft Entra ID](https://learn.microsoft.com/entra/fundamentals/how-to-manage-groups)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
