**Fails when:** The identity parent of this agent (its agent identity blueprint, or the agent identity of an agent user) is classified at a lower tier. Whoever controls the parent, for example through its owners or credentials, can act as this agent, so its privileges are only as protected as the parent. A parent that is not a privileged object of the export counts as Tier 2. The required tier of the agent counts its role assignments without delegated permissions.

EntraOps evaluates this rule as EO.1007 (PrivilegedAssets.parentLowerTier). The EntraOps reports show the same result as the finding 'Identity parent with lower tier'.

#### Remediation action

1. Classify the identity parent at the tier of this agent, and restrict its owners and credentials accordingly.
2. Or reduce the privileges of this agent to the tier of its parent.

| Implementation effort | User impact |
| --- | --- |
| Low: Usually a classification change and a review of the parent's owners. | Low: Owners of the parent may lose management access. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.1007) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Microsoft Entra Agent ID](https://learn.microsoft.com/entra/agent-id/)
- [Assign custom security attributes to applications](https://learn.microsoft.com/entra/identity/enterprise-apps/custom-security-attributes-apps)
- [EntraOps classification and object tiers](https://www.entraops.com/docs/core/index.html)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
