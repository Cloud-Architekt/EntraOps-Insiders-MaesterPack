A member user that is, or holds role assignments of, Tier 0 or 1 (Control, Management or Workload Plane) is not linked to the regular work account of its owner (by default the custom security attribute associatedWorkAccount; without it, the Privileged EAM collection also uses the identity info of Microsoft Defender XDR when XDR hunting is enabled). Without the link, leaver processes and investigations cannot connect the privileged account to a person.

EntraOps evaluates this rule as EO.4009 (PrivilegedAssets.workAccountMissing). The EntraOps reports show the same result as the finding 'No associated work account'.

#### Remediation action

Set the associatedWorkAccount attribute of the privileged account to the owner's regular work account, preferably by the provisioning process of privileged accounts.

| Implementation effort | User impact |
| --- | --- |
| Low: One attribute value per privileged account. | Low: No change for the user. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.4009) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Assign custom security attributes to users](https://learn.microsoft.com/entra/identity/users/users-custom-security-attributes)
- [Lifecycle workflows (joiner, mover, leaver)](https://learn.microsoft.com/entra/id-governance/what-are-lifecycle-workflows)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
