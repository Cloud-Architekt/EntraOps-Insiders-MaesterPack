**Fails when:** A Control or Management Plane role can be activated without multifactor authentication ('Azure MFA' in the role setting, Graph rule Enablement_EndUser_Assignment) and without an authentication context. The activation then relies on the existing session: a stolen session or token can activate the role. The MFA option only requires an MFA claim in the existing token; only an authentication context with a Conditional Access policy can require a fresh, phishing-resistant sign-in. Roles that require an authentication context are not reported. The tier of a role is the most privileged of its classification and of its current assignments, as the setting applies to every assignment of the role at any scope; only a role definition overwrite of the tenant can lower it. The PIM settings of Microsoft Entra roles are evaluated; those of Azure roles and PIM for Groups are not.

EntraOps evaluates this rule as EO.3006 (PimRequestFlow.noMfaActivation). The EntraOps reports show the same result as the finding 'Privileged role can be activated without MFA'.

#### Remediation action

In Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role > Activation, require a Conditional Access authentication context whose policy requires phishing-resistant authentication (preferred), or require multifactor authentication ('Azure MFA').

| Implementation effort | User impact |
| --- | --- |
| Low: One setting per role. | Low: Administrators authenticate again when they activate the role. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3006) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Conditional Access: authentication context](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-cloud-apps#authentication-context)
- [Require phishing-resistant MFA for administrators](https://learn.microsoft.com/entra/identity/conditional-access/policy-admin-phish-resistant-mfa)
- [Overview of PIM rules (unifiedRoleManagementPolicy)](https://learn.microsoft.com/graph/identity-governance-pim-rules-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
