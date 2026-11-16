**Fails when:** Activation of a Control Plane role does not require a Conditional Access authentication context, so it cannot enforce controls beyond MFA: phishing-resistant authentication, a compliant privileged access workstation or a fresh sign-in. Whether the required context is selected is checked by EO.3011. The tier of a role is the most privileged of its classification and of its current assignments, as the setting applies to every assignment of the role at any scope; only a role definition overwrite of the tenant can lower it. The PIM settings of Microsoft Entra roles are evaluated; those of Azure roles and PIM for Groups are not.

EntraOps evaluates this rule as EO.3009 (TenantGovernance.controlPlaneActivationAuthContext). The EntraOps reports show the same result as the finding 'Control Plane role activation without authentication context'.

#### Remediation action

1. Create an authentication context (Conditional Access > Authentication contexts).
2. Target it with a Conditional Access policy that requires a phishing-resistant authentication strength, a compliant device and sign-in frequency 'Every time'.
3. Select the context on activation in Microsoft Entra admin center > ID Governance > Privileged Identity Management > Microsoft Entra roles > Settings > the role.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs an authentication context and a Conditional Access policy once, then one setting per role. | Medium: Activations need phishing-resistant authentication on a compliant device. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3009) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Conditional Access: authentication context](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-cloud-apps#authentication-context)
- [Require phishing-resistant MFA for administrators](https://learn.microsoft.com/entra/identity/conditional-access/policy-admin-phish-resistant-mfa)
- [Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
