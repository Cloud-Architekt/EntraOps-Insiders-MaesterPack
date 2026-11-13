# EntraOps Maester Pack – Test overview

All tests in [`tests/`](tests/). Severity and title come from each test's `[MaesterTest]` attribute; the category is its EntraOps tag.

## Summary

**58 tests**

| Severity | Tests |
|---|---|
| Critical | 1 |
| High | 23 |
| Medium | 26 |
| Low | 1 |
| Info | 7 |

| Category | Tests |
|---|---|
| Tier boundaries | 10 |
| Classification | 5 |
| Just-in-time access | 14 |
| Account protection | 10 |
| Workload and agent identities | 5 |
| Access governance | 6 |
| Ownership and delegation | 5 |
| Drift | 3 |

## Tests

| Id | Name | Severity | Category |
|---|---|---|---|
| [MP.EOPS.1001](tests/Test.MP.EOPS.1001.md) | No object below Control Plane has access to a Control Plane service. | Critical | Tier boundaries |
| [MP.EOPS.1002](tests/Test.MP.EOPS.1002.md) | Privileged objects are classified at the tier of their role assignments. | High | Tier boundaries |
| [MP.EOPS.1003](tests/Test.MP.EOPS.1003.md) | No object below Management Plane has access to a Management Plane service. | High | Tier boundaries |
| [MP.EOPS.1004](tests/Test.MP.EOPS.1004.md) | Privileged objects have no owners of a lower tier. | High | Tier boundaries |
| [MP.EOPS.1005](tests/Test.MP.EOPS.1005.md) | Privileged objects do not own objects of a more privileged tier. | High | Tier boundaries |
| [MP.EOPS.1006](tests/Test.MP.EOPS.1006.md) | Administrative-unit-scoped roles do not manage objects of a more privileged tier. | High | Tier boundaries |
| [MP.EOPS.1007](tests/Test.MP.EOPS.1007.md) | Agent identities have no identity parent of a lower tier. | Medium | Tier boundaries |
| [MP.EOPS.1008](tests/Test.MP.EOPS.1008.md) | PIM activation approvers are classified at the tier of the role. | Medium | Tier boundaries |
| [MP.EOPS.1009](tests/Test.MP.EOPS.1009.md) | Access package approvers are classified at the tier of the granted resources. | Medium | Tier boundaries |
| [MP.EOPS.1010](tests/Test.MP.EOPS.1010.md) | Access package approvers are classified at the tier of the assigned principals. | Medium | Tier boundaries |
| [MP.EOPS.2001](tests/Test.MP.EOPS.2001.md) | Privileged objects are classified in a tier of the Enterprise Access Model. | Medium | Classification |
| [MP.EOPS.2002](tests/Test.MP.EOPS.2002.md) | Privileged role assignments are classified in a tier of the Enterprise Access Model. | Medium | Classification |
| [MP.EOPS.2003](tests/Test.MP.EOPS.2003.md) | PIM activation approvers can be resolved against the Privileged EAM data. | Medium | Classification |
| [MP.EOPS.2004](tests/Test.MP.EOPS.2004.md) | Custom roles with Control Plane permissions should be investigated. | Info | Classification |
| [MP.EOPS.2005](tests/Test.MP.EOPS.2005.md) | Access package target groups without role assignments have a declared tier. | Info | Classification |
| [MP.EOPS.3001](tests/Test.MP.EOPS.3001.md) | Control Plane roles of Entra ID and Azure are assigned to users only as eligible. | High | Just-in-time access |
| [MP.EOPS.3002](tests/Test.MP.EOPS.3002.md) | Memberships in groups with Control Plane access are eligible. | High | Just-in-time access |
| [MP.EOPS.3003](tests/Test.MP.EOPS.3003.md) | No Control or Management Plane Azure role is assigned permanently at the root scope. | High | Just-in-time access |
| [MP.EOPS.3004](tests/Test.MP.EOPS.3004.md) | No permanent eligible assignment is allowed for Control and Management Plane roles. | Medium | Just-in-time access |
| [MP.EOPS.3005](tests/Test.MP.EOPS.3005.md) | No permanent active assignment is allowed for Control and Management Plane roles. | Medium | Just-in-time access |
| [MP.EOPS.3006](tests/Test.MP.EOPS.3006.md) | Activation of Control and Management Plane roles requires MFA or an authentication context. | High | Just-in-time access |
| [MP.EOPS.3007](tests/Test.MP.EOPS.3007.md) | Activation of Control and Management Plane roles requires approval. | High | Just-in-time access |
| [MP.EOPS.3008](tests/Test.MP.EOPS.3008.md) | Active assignments of Control and Management Plane roles require MFA. | Medium | Just-in-time access |
| [MP.EOPS.3009](tests/Test.MP.EOPS.3009.md) | Activations of Control Plane roles require an authentication context. | Medium | Just-in-time access |
| [MP.EOPS.3010](tests/Test.MP.EOPS.3010.md) | PIM role settings with approvers require approval to activate. | Medium | Just-in-time access |
| [MP.EOPS.3011](tests/Test.MP.EOPS.3011.md) | PIM role settings that require an authentication context have one configured. | Medium | Just-in-time access |
| [MP.EOPS.3012](tests/Test.MP.EOPS.3012.md) | Eligible assignments of Control and Management Plane roles expire within the configured maximum duration. | Medium | Just-in-time access |
| [MP.EOPS.3013](tests/Test.MP.EOPS.3013.md) | Activations of Control Plane roles are limited to the configured maximum duration. | Medium | Just-in-time access |
| [MP.EOPS.3014](tests/Test.MP.EOPS.3014.md) | Assignments and activations of Control and Management Plane roles alert administrators. | Medium | Just-in-time access |
| [MP.EOPS.4001](tests/Test.MP.EOPS.4001.md) | No Control Plane object is synchronized from Active Directory. | High | Account protection |
| [MP.EOPS.4002](tests/Test.MP.EOPS.4002.md) | No guest user has Control or Management Plane access. | High | Account protection |
| [MP.EOPS.4003](tests/Test.MP.EOPS.4003.md) | Conditional Access policies do not exclude Control Plane users, groups or roles. | High | Account protection |
| [MP.EOPS.4004](tests/Test.MP.EOPS.4004.md) | Groups with Control or Management Plane access are role-assignable or protected by a restricted management administrative unit. | High | Account protection |
| [MP.EOPS.4005](tests/Test.MP.EOPS.4005.md) | Control, Management and Workload Plane users and groups are protected by restricted management. | Medium | Account protection |
| [MP.EOPS.4006](tests/Test.MP.EOPS.4006.md) | No Management Plane object is synchronized from Active Directory. | Medium | Account protection |
| [MP.EOPS.4007](tests/Test.MP.EOPS.4007.md) | Control, Management and Workload Plane users own no devices other than their privileged access workstation. | Medium | Account protection |
| [MP.EOPS.4008](tests/Test.MP.EOPS.4008.md) | Control Plane users have an associated privileged access workstation. | Medium | Account protection |
| [MP.EOPS.4009](tests/Test.MP.EOPS.4009.md) | Control, Management and Workload Plane users are linked to a work account. | Low | Account protection |
| [MP.EOPS.4010](tests/Test.MP.EOPS.4010.md) | Privileged objects from other tenants should be investigated. | Info | Account protection |
| [MP.EOPS.5001](tests/Test.MP.EOPS.5001.md) | No service principal of another tenant has Control Plane access. | High | Workload and agent identities |
| [MP.EOPS.5002](tests/Test.MP.EOPS.5002.md) | Agent identities have no Control or Management Plane access. | High | Workload and agent identities |
| [MP.EOPS.5003](tests/Test.MP.EOPS.5003.md) | Agent identities and agent users have a sponsor. | Medium | Workload and agent identities |
| [MP.EOPS.5004](tests/Test.MP.EOPS.5004.md) | Workload identities with Control Plane access should be investigated. | Info | Workload and agent identities |
| [MP.EOPS.5005](tests/Test.MP.EOPS.5005.md) | Delegated permissions classified as Control Plane should be investigated. | Info | Workload and agent identities |
| [MP.EOPS.6001](tests/Test.MP.EOPS.6001.md) | Access package assignment policies for Control and Management Plane resources require approval. | High | Access governance |
| [MP.EOPS.6002](tests/Test.MP.EOPS.6002.md) | Access package assignment policies for Control and Management Plane resources cannot be requested by all users. | High | Access governance |
| [MP.EOPS.6003](tests/Test.MP.EOPS.6003.md) | Control and Management Plane access package resources have no members outside their access packages. | High | Access governance |
| [MP.EOPS.6004](tests/Test.MP.EOPS.6004.md) | Access package assignments of Control and Management Plane resources are applied to their resources. | Medium | Access governance |
| [MP.EOPS.6005](tests/Test.MP.EOPS.6005.md) | Access package assignment policies for Control and Management Plane resources let assignments expire. | Medium | Access governance |
| [MP.EOPS.6006](tests/Test.MP.EOPS.6006.md) | Access package assignment policies for Control and Management Plane resources have access reviews. | Medium | Access governance |
| [MP.EOPS.7001](tests/Test.MP.EOPS.7001.md) | Service principals and applications with Control or Management Plane access have no owners. | High | Ownership and delegation |
| [MP.EOPS.7002](tests/Test.MP.EOPS.7002.md) | Groups with Control or Management Plane access have no owners. | High | Ownership and delegation |
| [MP.EOPS.7003](tests/Test.MP.EOPS.7003.md) | User Access Administrator and Role Based Access Control Administrator assignments are constrained by conditions. | High | Ownership and delegation |
| [MP.EOPS.7004](tests/Test.MP.EOPS.7004.md) | Control Plane access is not granted through nested groups. | Medium | Ownership and delegation |
| [MP.EOPS.7005](tests/Test.MP.EOPS.7005.md) | Administrative units with privileged members have no dynamic membership. | Medium | Ownership and delegation |
| [MP.EOPS.8001](tests/Test.MP.EOPS.8001.md) | New Control Plane access since the previous snapshot should be investigated. | Info | Drift |
| [MP.EOPS.8002](tests/Test.MP.EOPS.8002.md) | No new tier breach since the previous snapshot. | High | Drift |
| [MP.EOPS.8003](tests/Test.MP.EOPS.8003.md) | New delegated Control or Management Plane permissions since the previous snapshot should be investigated. | Info | Drift |
