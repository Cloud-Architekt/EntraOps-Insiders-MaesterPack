**Fails when:** An agent identity, agent identity blueprint principal or agent user holds Control or Management Plane access. AI agents act autonomously on the content they process, so privileged access exposes the tenant to prompt injection and misuse of the agent. Delegated permissions do not count as access of the object: the application acts within the rights of the signed-in user (EO.5005 reports delegated Control Plane permissions).

EntraOps evaluates this rule as EO.5002 (PrivilegedEAM.agentPrivileged). The EntraOps reports show the same result as the finding 'Agent identity with privileged access'.

#### Remediation action

Remove the privileged access, or replace it with the narrowest permissions the agent needs, scoped to the resources it works on. Assign a sponsor and owners of the agent's tier.

| Implementation effort | User impact |
| --- | --- |
| Medium: Needs the agent's actual permission requirements. | Medium: Agent tasks that need the removed permissions stop working. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.5002) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Microsoft Entra Agent ID](https://learn.microsoft.com/entra/agent-id/)
- [Workload identities](https://learn.microsoft.com/entra/workload-id/workload-identities-overview)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/EntraOps/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
