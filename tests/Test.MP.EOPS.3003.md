**Fails when:** A Control or Management Plane Azure role is assigned permanently at the root scope (/) or the tenant root management group, so it applies to every management group, subscription and resource. User Access roles such as Reader, the members of a group with the assignment, and Microsoft first-party service principals such as MS-PIM (which manages the PIM assignments of Azure resources) are not reported. PIM activations and time-bound assignments are not reported.

EntraOps evaluates this rule as EO.3003 (PrivilegedEAM.azureRootScopeAssignment). The EntraOps reports show the same result as the finding 'Permanent Azure role assignment at root scope'.

#### Remediation action

1. Assign the role at the lowest management group, subscription or resource group that is needed.
2. For users and groups, make the assignment eligible in PIM for Azure resources.
3. Service principals and managed identities cannot be eligible in PIM: scope their assignment down, and protect their credentials and owners.

| Implementation effort | User impact |
| --- | --- |
| Medium: The required scopes need to be identified before the assignment moves. | Medium: Automation or administrators lose access at scopes that are no longer covered. |

#### Dismiss or accept a finding

A finding that is a false positive, or whose risk is accepted until a date, is an exception in the EntraOps Finding Exceptions File (`Findings.ExceptionsFilePath`, default `./Classification/FindingExceptions.json`). The test doesn't fail for it: with dismissed findings only it passes, and with risk-accepted findings but no open one it is skipped with the accepted risks as the reason, because the control is not met. Add exceptions in the Findings view of the EntraOps Privileged Assets report (*Accept* at an affected object of EO.3003) and export the file to the EntraOps folder; the next EntraOps evaluation applies it.

#### Related links

- [Elevate access to manage all Azure subscriptions and management groups](https://learn.microsoft.com/azure/role-based-access-control/elevate-access-global-admin)
- [Azure management groups](https://learn.microsoft.com/azure/governance/management-groups/overview)
- [Best practices for Azure RBAC](https://learn.microsoft.com/azure/role-based-access-control/best-practices)
- [Assign Azure resource roles in PIM](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-resource-roles-assign-roles)
- [EntraOps findings and Maester Pack](https://www.entraops.com/docs/reportings/index.html#findings)
- [EntraOps finding exceptions](https://www.entraops.com/docs/reportings/index.html#finding-exceptions)
- [EntraOps finding rules](https://github.com/Cloud-Architekt/entraops-insiders/blob/main/EntraOps/Private/Findings/FindingRules.json)

<!--- Results --->
%TestResult%
