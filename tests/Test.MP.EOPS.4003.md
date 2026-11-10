**Fails when:** An enabled Conditional Access policy excludes a Control Plane user, a group with Control Plane members or a Control Plane directory role, so its controls do not apply to them. Excluded groups are evaluated with their members; groups that could not be resolved to their members are named in the reason of the result instead of passing silently. Not reported: emergency access accounts (Findings.EmergencyAccessAccounts, or, without the setting and with at least two enabled policies, users excluded from every enabled policy; groups are never taken for emergency access, so configure the group of the emergency access accounts), and exclusions from a block policy of identities or roles that another enabled policy targets (the allow-list of the block policy, for example privileged accounts and admin roles excluded from blocking admin portals for everyone else). When failed policies only exclude the same user or group, the reason of the rule names it: if it is your emergency access account or group, set Findings.EmergencyAccessAccounts.

EntraOps evaluates this rule as EO.4003 (TenantGovernance.conditionalAccessControlPlaneExclusion). The EntraOps reports show the same result as the finding 'Control Plane user, group or role excluded from Conditional Access'.

#### Remediation action

1. Remove the exclusion, or remove the Control Plane users from the excluded group.
2. If the exclusion is intended (persona-based policies), target the excluded users, groups or roles with a dedicated enabled policy with the same or stronger controls.
3. Set Findings.EmergencyAccessAccounts to the emergency access accounts and groups.

| Implementation effort | User impact |
| --- | --- |
| Medium: Exclusions often exist for a reason that needs an alternative policy first. | Medium: The policy's controls start to apply to the excluded users. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Conditional Access: users, groups and workload identities](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-users-groups)
- [Manage emergency access accounts](https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access)
- [Require phishing-resistant MFA for administrators](https://learn.microsoft.com/entra/identity/conditional-access/policy-admin-phish-resistant-mfa)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
