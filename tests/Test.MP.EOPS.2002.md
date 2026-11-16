**Fails when:** The role assignment has no tier classification, so its privileges are missing in the tier analysis (tier breaches and the required tier of the object). Usually the classification does not know the role, permission or its actions, for example a new built-in role, a custom role or an API permission of a third-party application. The OpenID Connect sign-in scopes openid, profile, email and offline_access and user_impersonation are not reported: they grant no privileges of their own.

EntraOps evaluates this rule as EO.2002 (PrivilegedEAM.unclassifiedAssignment). The EntraOps reports show the same result as the finding 'Role assignment without tier classification'.

#### Remediation action

1. Look up the role or permission in the Classification Explorer.
2. Add it, or its actions, to the classification: a classification template, or an overwrite file such as Classification_RoleActionOverwrites.json or Classification_ApiPermissionOverwrites.json.
3. Run the Privileged EAM collection again.

| Implementation effort | User impact |
| --- | --- |
| Low: One classification entry covers every assignment of the role or permission. | Low: No change of access; only the analysis changes. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.2002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Microsoft Entra built-in roles](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
