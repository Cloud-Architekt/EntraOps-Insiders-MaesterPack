**Fails when:** The PIM setting of a Control or Management Plane role does not notify administrators when the role is activated, or assigned as eligible or active: the default recipients are turned off and there are no additional recipients. Misuse of the role then goes unnoticed until someone reviews the audit log. Roles whose snapshot has no notification settings are not evaluated. The PIM settings of Microsoft Entra roles are evaluated; those of Azure roles and PIM for Groups are not.

EntraOps evaluates this rule as EO.3014 (TenantGovernance.privilegedRoleAlert). The EntraOps reports show the same result as the finding 'Privileged role without administrator alerts'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Notification, turn on the default recipients of the 'Role activation alert' and 'Role assignment alert' notifications, or add the mailbox of the security operations team as additional recipient.

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per role. | Low: No change for administrators; the recipients get notification emails. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3014) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Email notifications in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-email-notifications)
- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
