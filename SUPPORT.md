# Support Policy

The EntraOps Maester Pack is provided under the MIT License and distributed internally: only people with access
to this private repository can install it. It is maintained together with EntraOps on a best-effort basis.

The project does not provide a service-level agreement, guaranteed response time, guaranteed remediation
schedule, or commercial support commitment. Operators remain responsible for evaluating the pack, EntraOps and
the results they report in their own tenant.

## Support

Search existing issues before opening a new one, and open it where the problem is:

| Problem | Where |
| --- | --- |
| Installing or running the pack, finding `findings.json`, its settings, how a result is shown in Maester | [Issues of this repository](https://github.com/Cloud-Architekt/EntraOps-Insiders-MaesterPack/issues) |
| The result of a check: a finding you consider wrong, a missing check or a threshold | [Issues of this repository](https://github.com/Cloud-Architekt/EntraOps-Insiders-MaesterPack/issues) as well: EntraOps evaluates the checks, and the maintainers take it to EntraOps. Don't report results of this internal version in the public EntraOps repository. |
| Maester itself: `Install-MtPack`, `Invoke-Maester` or the Maester report | [Maester](https://github.com/maester365/maester/issues), without details of this internal pack or your tenant |

Include the pack version, the EntraOps version that wrote `findings.json`, the Maester and PowerShell versions,
the sanitized test result and the steps to reproduce the behavior.

## Security Reports

Do not report vulnerabilities in GitHub issues. Follow [SECURITY.md](./SECURITY.md) instead.

## Microsoft and Other Services

For support for Microsoft Entra, Microsoft Graph, GitHub Actions, Azure DevOps, or other third-party services,
use the support channels offered by the applicable provider.
