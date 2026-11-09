function Get-EntraOpsPackFindingSet {
    <#
    .SYNOPSIS
    Reads the EntraOps finding results (findings.json) that the tests of this pack report.

    .DESCRIPTION
    The results are written by EntraOps (Invoke-EntraOpsAssessment or New-EntraOpsReportingData) to
    Reports/Findings/data of the EntraOps working folder, which the EntraOps reporting pipelines publish in
    the EntraOps-Reporting artifact (Findings/data). The setting EntraOps.FindingsPath points to
    findings.json or to the folder that holds it. Without the setting, the first of these folders that has
    findings.json is used: <ENTRAOPS_ROOT>/Reports/Findings/data, <home>/EntraOps/Reports/Findings/data (the
    working folder of a module-only installation) and ./Reports/Findings/data. The file is read once and
    reused by all tests of the run while it does not change.

    Skips the calling test, with the reason, when the file is missing, has an unknown schema, belongs to
    another tenant than the Microsoft Graph connection, or is older than EntraOps.MaxFindingsAgeDays (default
    7 days, 0 turns the check off), and when that setting is not a number of days.
    #>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    param()

    $howTo = 'Run Invoke-EntraOpsAssessment (without EntraOps in place) or New-EntraOpsReportingData (in your EntraOps repository), which save it to Reports/Findings/data of the EntraOps working folder'
    $path = [string](Get-MtSetting -Name 'EntraOps.FindingsPath' -Default '')
    if ([string]::IsNullOrWhiteSpace($path)) {
        # The default locations of EntraOps: its working folder (ENTRAOPS_ROOT, or <home>/EntraOps for a module-only
        # installation) and the current folder (a clone of the EntraOps repository).
        $defaultFolders = @(
            if (-not [string]::IsNullOrWhiteSpace($env:ENTRAOPS_ROOT)) { Join-Path -Path $env:ENTRAOPS_ROOT -ChildPath 'Reports/Findings/data' }
            if (-not [string]::IsNullOrWhiteSpace($HOME)) { Join-Path -Path $HOME -ChildPath 'EntraOps/Reports/Findings/data' }
            Join-Path -Path (Get-Location -PSProvider FileSystem).ProviderPath -ChildPath 'Reports/Findings/data'
        )
        $path = @($defaultFolders | Where-Object { Test-Path -LiteralPath (Join-Path -Path $_ -ChildPath 'findings.json') -PathType Leaf }) | Select-Object -First 1
        if (-not $path) {
            Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "No EntraOps finding results (findings.json) were found in $($defaultFolders -join ', '). $howTo, or set EntraOps.FindingsPath in maester-config.json to the file or its folder, for example the Findings/data folder of the EntraOps-Reporting artifact."
            return
        }
    }
    if (Test-Path -LiteralPath $path -PathType Container) { $path = Join-Path -Path $path -ChildPath 'findings.json' }
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "No EntraOps finding results were found at $path (EntraOps.FindingsPath). $howTo, or correct the setting."
        return
    }

    $file = Get-Item -LiteralPath $path
    $cacheKey = '{0}|{1}' -f $file.FullName, $file.LastWriteTimeUtc.Ticks
    if ($script:EntraOpsPackFindingCache -and $script:EntraOpsPackFindingCache.Key -eq $cacheKey) {
        $findingSet = $script:EntraOpsPackFindingCache.Value
    } else {
        $findingSet = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
        $script:EntraOpsPackFindingCache = @{ Key = $cacheKey; Value = $findingSet }
    }

    if ("$($findingSet.SchemaVersion)" -notmatch '^1\.') {
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "The EntraOps finding results at $path have schema version '$($findingSet.SchemaVersion)', which this version of the pack does not read. Update the EntraOps Maester Pack."
        return
    }

    $context = Get-MgContext
    if ($context -and $context.TenantId -and $findingSet.TenantId -and $findingSet.TenantId -ne $context.TenantId) {
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "The EntraOps finding results at $path are for tenant $($findingSet.TenantId), but Maester is connected to tenant $($context.TenantId)."
        return
    }

    $maxAgeSetting = Get-MtSetting -Name 'EntraOps.MaxFindingsAgeDays' -Default 7
    $maxAgeDays = 0
    if (-not [int]::TryParse("$maxAgeSetting", [System.Globalization.NumberStyles]::Integer, [cultureinfo]::InvariantCulture, [ref]$maxAgeDays) -or $maxAgeDays -lt 0) {
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "The setting EntraOps.MaxFindingsAgeDays in maester-config.json is '$maxAgeSetting', not a number of days. Set it to the maximum age of the EntraOps finding results in days, or to 0 to turn the check off."
        return
    }
    # ConvertFrom-Json reads the ISO date as a DateTime already; text is parsed invariantly, never in the current culture.
    $generatedAt = [datetime]::MinValue
    $hasDate = if ($findingSet.GeneratedAt -is [datetime]) { $generatedAt = $findingSet.GeneratedAt; $true }
    else {
        [datetime]::TryParse([string]$findingSet.GeneratedAt, [cultureinfo]::InvariantCulture,
            [System.Globalization.DateTimeStyles]::AdjustToUniversal -bor [System.Globalization.DateTimeStyles]::AssumeUniversal, [ref]$generatedAt)
    }
    if ($maxAgeDays -gt 0 -and $hasDate -and $generatedAt.ToUniversalTime() -lt [datetime]::UtcNow.AddDays(-$maxAgeDays)) {
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "The EntraOps finding results at $path were written on $($generatedAt.ToString('yyyy-MM-dd')), more than $maxAgeDays days ago. Run Invoke-EntraOpsAssessment or New-EntraOpsReportingData again, or raise the EntraOps.MaxFindingsAgeDays setting."
        return
    }

    $findingSet | Add-Member -NotePropertyName GeneratedText -NotePropertyValue $(if ($hasDate) { $generatedAt.ToUniversalTime().ToString('yyyy-MM-dd HH:mm', [cultureinfo]::InvariantCulture) + ' UTC' } else { [string]$findingSet.GeneratedAt }) -Force
    $findingSet
}

function Get-EntraOpsPackAcceptedFinding {
    <#
    .SYNOPSIS
    Splits the instances a rule accepted by EntraOps finding exceptions into risk-accepted and dismissed ones.

    .DESCRIPTION
    RiskAcceptedCount counts the risk-accepted instances and RiskAccepted names them (object, expiry date and
    reference; the first MaxNames), DismissedCount counts the dismissed ones. Accepted instances without their exception in findings.json
    count as risk accepted, so they never pass the test.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $Rule,

        [int] $MaxNames = 10
    )

    $results = @($Rule.AcceptedResults | Where-Object { $null -ne $_ })
    $dismissed = @($results | Where-Object { "$($_.Exception.State)" -eq 'Dismissed' }).Count
    $risks = @($results | Where-Object { "$($_.Exception.State)" -ne 'Dismissed' } | ForEach-Object {
            $name = if ($_.Instance.DisplayName) { $_.Instance.DisplayName } elseif ($_.Instance.ObjectId) { $_.Instance.ObjectId } else { $_.Instance.Id }
            $details = @($(if ($_.Exception.ExpiresOn) { "until $($_.Exception.ExpiresOn)" }), $_.Exception.Reference) | Where-Object { $_ }
            # Names and references come from the tenant and the exceptions file: safe for the Markdown of the result.
            ConvertTo-EntraOpsPackMarkdownCell "$name$(if ($details) { " ($($details -join ', '))" })"
        })
    # Accepted instances that findings.json counts but doesn't list (no exception details).
    $unlisted = [Math]::Max(0, [int]$Rule.AcceptedCount - $results.Count)
    $names = [System.Collections.Generic.List[string]]::new()
    foreach ($risk in @($risks | Select-Object -First $MaxNames)) { $names.Add($risk) }
    $more = $risks.Count - $names.Count + $unlisted
    if ($more -gt 0) { $names.Add("$more more") }
    [pscustomobject]@{
        RiskAcceptedCount = $risks.Count + $unlisted
        RiskAccepted      = $(if ($names.Count) { @($names) } else { @() })
        DismissedCount    = $dismissed
    }
}

function ConvertTo-EntraOpsPackMarkdownCell {
    <#
    .SYNOPSIS
    Makes a value safe for a cell of a Markdown table.
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [AllowNull()]
        [AllowEmptyString()]
        $Value
    )

    ("$Value" -replace '[\r\n]+', ' ' -replace '\|', '\|' -replace '<', '&lt;' -replace '>', '&gt;').Trim()
}

function Test-EntraOpsPackFinding {
    <#
    .SYNOPSIS
    Reports the result of one EntraOps finding rule from findings.json.

    .DESCRIPTION
    Passed when EntraOps evaluated the rule and no instance failed, Failed with a table of the affected
    instances when at least one failed. Instances accepted by a finding exception of EntraOps don't fail the
    test: dismissed instances (false positives) pass it, and a rule without open instances but with
    risk-accepted ones is skipped with the accepted risks as the reason, so they stay visible. Skipped also
    when the rule is excluded or deprecated in EntraOps, had nothing to evaluate, lacked its data (for example
    the report data of the PIM Request Flow rules), or is missing from findings.json (for example results of
    an older EntraOps version). An error when the evaluation of the rule failed in EntraOps (status Error):
    its result is unknown, so the test neither passes nor is skipped.
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        # The EntraOps rule ID, for example EO.1001.
        [Parameter(Mandatory)]
        [string] $RuleId,

        # The most affected instances listed in the result.
        [int] $MaxRows = 50
    )

    $findingSet = Get-EntraOpsPackFindingSet
    if ($null -eq $findingSet) { return }

    $rule = @($findingSet.Rules | Where-Object { $_.RuleId -eq $RuleId }) | Select-Object -First 1
    if ($null -eq $rule) {
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "The EntraOps finding results have no result for rule $RuleId. The rule may be evaluated by a newer EntraOps version than the one that wrote the results."
        return
    }

    # The tenant of the results: Maester compares it only while Microsoft Graph is connected (not with -SkipGraphConnect).
    $tenant = if ($findingSet.TenantName) { [string]$findingSet.TenantName } elseif ($findingSet.TenantId) { [string]$findingSet.TenantId } else { $null }
    $source = "EntraOps $($findingSet.Generator.Version) results of $(if ($tenant) { "$(ConvertTo-EntraOpsPackMarkdownCell $tenant), " })$($findingSet.GeneratedText)"
    # What the reason of the rule is (ReasonCode of EntraOps; results of older versions have none).
    $reasonCode = if ($null -ne $rule.PSObject.Properties['ReasonCode'] -and $rule.ReasonCode) { [string]$rule.ReasonCode } else { $null }
    # The note of a Failed or Passed rule: data it could not evaluate, or a hint how to fix the results.
    $note = if ($rule.Reason -and $rule.Status -in 'Failed', 'Passed') { "Note: $($rule.Reason)" } else { $null }
    switch ([string]$rule.Status) {
        'Excluded' {
            # Excluded in EntraOpsConfig.json (Findings.ExcludedRules), or deprecated in EntraOps (with the reason).
            $why = if ($rule.Reason) { $rule.Reason } else { 'It is excluded in the EntraOps configuration (Findings.ExcludedRules).' }
            Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "EntraOps did not evaluate rule $($RuleId): $why"
            return
        }
        'Error' {
            # Maester reports a thrown error as the result Error with its message (ReasonCode TestError). The result
            # detail recorded first replaces the error record (with the line of this file) in the report.
            $why = if ($rule.Reason) { $rule.Reason } else { 'No reason was recorded.' }
            $message = "EntraOps could not evaluate rule $($RuleId): $why"
            Add-MtTestResultDetail -Result "$message`n`nRun the EntraOps evaluation again (Invoke-EntraOpsAssessment or New-EntraOpsReportingData).`n`n_$($source)_"
            throw $message
        }
        'Skipped' {
            # Nothing in the scope of the rule is not applicable; only unclassified objects affected needs their
            # classification; any other reason is data the rule was missing.
            $notApplicable = $reasonCode -eq 'NotApplicable' -or (-not $reasonCode -and (-not $rule.Reason -or $rule.Reason -match 'in the scope of this rule \(0 evaluated\)'))
            if ($notApplicable) {
                Add-MtTestResultDetail -SkippedBecause NotApplicable
            } elseif ($reasonCode -eq 'Unclassified' -or (-not $reasonCode -and $rule.Reason -like 'Only unclassified objects are affected*')) {
                Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "EntraOps did not report rule $($RuleId): $($rule.Reason)"
            } else {
                Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "EntraOps could not evaluate rule $($RuleId): $($rule.Reason)"
            }
            return
        }
        'Passed' {
            $accepted = Get-EntraOpsPackAcceptedFinding -Rule $rule
            if ($accepted.RiskAcceptedCount -gt 0) {
                # The control is not met, but its risk is accepted: neither a pass nor a failure.
                Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "Risk accepted in EntraOps: $($accepted.RiskAcceptedCount) affected instance(s) of $($rule.EvaluatedCount) evaluated, no open one ($($accepted.RiskAccepted -join '; '))$(if ($accepted.DismissedCount) { "; $($accepted.DismissedCount) more dismissed as false positives" }). Renew or remove the exceptions in the EntraOps Finding Exceptions File."
                return
            }
            $dismissed = if ($accepted.DismissedCount) { " $($accepted.DismissedCount) affected instance(s) are dismissed as false positives in the EntraOps finding exceptions." } else { '' }
            Add-MtTestResultDetail -Result "Well done. EntraOps evaluated $($rule.EvaluatedCount) instance(s) and none is affected.$dismissed$(if ($note) { "`n`n$note" })`n`n_$($source)_"
            return $true
        }
        'Failed' {
            $results = @($rule.Results)
            $lines = [System.Collections.Generic.List[string]]::new()
            $lines.Add("EntraOps found $($rule.FailedCount) affected instance(s) of $($rule.EvaluatedCount) evaluated.")
            $accepted = Get-EntraOpsPackAcceptedFinding -Rule $rule
            if ($accepted.RiskAcceptedCount -gt 0) { $lines.Add("$($accepted.RiskAcceptedCount) more instance(s) are risk accepted in the EntraOps finding exceptions and not listed: $($accepted.RiskAccepted -join '; ').") }
            if ($accepted.DismissedCount -gt 0) { $lines.Add("$($accepted.DismissedCount) more instance(s) are dismissed as false positives in the EntraOps finding exceptions and not listed.") }
            if ([int]$rule.UnclassifiedCount -gt 0) { $lines.Add("$($rule.UnclassifiedCount) more instance(s) of unclassified objects are not listed: classify these objects (EO.2001) to evaluate them.") }
            if ($note) { $lines.Add($note) }
            $lines.Add('')
            $lines.Add('| Object | Type | Details |')
            $lines.Add('| --- | --- | --- |')
            foreach ($result in @($results | Select-Object -First $MaxRows)) {
                $name = if ($result.Instance.DisplayName) { $result.Instance.DisplayName } else { $result.Instance.ObjectId }
                $row = '| {0} | {1} | {2} |' -f (ConvertTo-EntraOpsPackMarkdownCell $name), (ConvertTo-EntraOpsPackMarkdownCell $result.Instance.ObjectType), (ConvertTo-EntraOpsPackMarkdownCell $result.Message)
                $lines.Add($row)
            }
            if ($results.Count -gt $MaxRows) { $lines.Add(''); $lines.Add("... and $($results.Count - $MaxRows) more. The EntraOps reports list all of them.") }
            $lines.Add('')
            $lines.Add("_$($source)_")
            Add-MtTestResultDetail -Result ($lines -join "`n")
            return $false
        }
        default {
            Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "Rule $RuleId has the status '$($rule.Status)', which this version of the pack does not know."
            return
        }
    }
}
