# Data Handling and Privacy

The EntraOps Maester Pack is source code that runs in Maester, on the operator's computer or in the pipeline
the operator selects. It does not provide a hosted service and includes no telemetry.

## Data Processed

The pack reads only the EntraOps finding results (`findings.json`). They contain tenant-specific data: the tenant
ID and name, and the display names, object IDs and types of affected objects with the details of each finding
and the references of finding exceptions. This data can be sensitive and may include personal data.

The pack does not call Microsoft Graph or any other service. When Microsoft Graph is already connected, it reads
the tenant ID of the connection only to skip the results of another tenant.

## Where the Data Goes

The test results, including up to 50 affected objects per test and the accepted risks, are written to the
Maester report and its other outputs, which the operator stores or publishes. Treat Maester reports and
`findings.json` as sensitive: don't commit them to public repositories or attach them to issues.

The pack is installed from this private GitHub repository (with a token that can read it) or from a local
folder. Maester sends an anonymous install event only for a pack from a public GitHub repository, so nothing about
this pack is sent to Maester Packs. The token is sent to `api.github.com` only. See the Maester documentation for
details.

This document describes the repository's intended behavior and is not legal advice.
