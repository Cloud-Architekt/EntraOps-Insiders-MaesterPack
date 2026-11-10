**Fails when:** An agent identity or agent user has no sponsor. Agent identity blueprints and their principals in the tenant are not reported: the sponsors of a blueprint are kept on the blueprint application. The sponsor is the person accountable for the agent's purpose and lifecycle; without one, nobody reviews or ends its access.

EntraOps evaluates this rule as EO.5003 (PrivilegedAssets.sponsorMissing). The EntraOps reports show the same result as the finding 'No sponsor'.

#### Remediation action

Assign a sponsor in the Microsoft Entra admin center (Agent ID) or with Microsoft Graph (sponsors), preferably when the agent is created.

| Implementation effort | User impact |
| --- | --- |
| Low: One sponsor per agent. | Low: No change for the agent or its users. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.5003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Microsoft Entra Agent ID](https://learn.microsoft.com/entra/agent-id/)
- [Assign sponsors of a user (user: sponsors)](https://learn.microsoft.com/graph/api/user-post-sponsors)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
