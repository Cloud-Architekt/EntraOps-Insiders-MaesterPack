function Invoke-EntraOpsPackCheck {
    <#
    .SYNOPSIS
    Defines the Pester checks of the EntraOps Maester Pack.

    .DESCRIPTION
    The pack is the whole repository, and Maester refuses any .ps1 file with code outside a function, so the
    checks are one function that defines the Pester blocks and their helpers. .github/workflows/check-pack.yml runs them; locally:

        Invoke-Pester -Container (New-PesterContainer -ScriptBlock { . ./ci/PackChecks.ps1; Invoke-EntraOpsPackCheck })

    Maester runs in a separate pwsh process: the version in MAESTER_VERSION when it is set, else the newest
    installed 3.x.
    #>
    [CmdletBinding()]
    param()

    $packRoot = Split-Path -Parent $PSScriptRoot
    $testScripts = @(Get-ChildItem -Path (Join-Path $packRoot 'tests') -Filter 'Test.MP.*.ps1' -File | ForEach-Object { @{ Name = $_.Name; Path = $_.FullName } })
    $packScripts = @(Get-ChildItem -Path $packRoot -Filter '*.ps1' -File -Recurse | ForEach-Object { @{ Name = [System.IO.Path]::GetRelativePath($packRoot, $_.FullName); Path = $_.FullName } })

    Describe 'EntraOps Maester Pack' {
        BeforeAll {
            $script:PackRoot = Split-Path -Parent $PSScriptRoot
            $script:Manifest = Get-Content -LiteralPath (Join-Path $script:PackRoot 'maester-pack.json') -Raw | ConvertFrom-Json
            $script:Source = Get-Content -LiteralPath (Join-Path $script:PackRoot 'entraops-source.json') -Raw | ConvertFrom-Json
            $script:TestCount = @(Get-ChildItem -Path (Join-Path $script:PackRoot 'tests') -Filter 'Test.MP.*.ps1' -File).Count

            # Helpers of the run phase (a separate file would have to be dot-sourced from a computed path, which
            # Maester rates as dynamic code).
            function Invoke-EntraOpsPackMaester {
                <#
                .SYNOPSIS
                Runs a script with the Maester module in a separate pwsh process and returns its output (as JSON).
                #>
                [CmdletBinding()]
                param(
                    [Parameter(Mandatory)]
                    [string] $Script
                )

                $import = if ($env:MAESTER_VERSION) { "Import-Module Maester -RequiredVersion '$(($env:MAESTER_VERSION -split '-')[0])'" } else { 'Import-Module Maester -MinimumVersion 3.0' }
                $file = Join-Path $TestDrive "maester-$([guid]::NewGuid()).ps1"
                Set-Content -LiteralPath $file -Value "`$ErrorActionPreference = 'Stop'`n$import`n$Script | ConvertTo-Json -Depth 6 -Compress"
                $output = pwsh -NoProfile -NonInteractive -File $file
                if ($LASTEXITCODE -ne 0) { throw "Maester failed: $($output -join "`n")" }
                $output | Select-Object -Last 1 | ConvertFrom-Json
            }

            function Invoke-EntraOpsPackTestRun {
                <#
                .SYNOPSIS
                Runs every test of the pack against a copy of ci/fixtures/findings.json written AgeDays ago.

                .DESCRIPTION
                With -DefaultLocation, the copy is written to Reports/Findings/data of an EntraOps working folder and
                EntraOps.FindingsPath is not set: the pack finds it through ENTRAOPS_ROOT or in the current folder.
                #>
                [CmdletBinding()]
                param(
                    [Parameter(Mandatory)]
                    [string] $PackRoot,

                    [int] $AgeDays = 0,

                    [string] $SchemaVersion,

                    [ValidateSet('EntraOpsRoot', 'CurrentFolder')]
                    [string] $DefaultLocation
                )

                $root = Join-Path $TestDrive ([guid]::NewGuid())
                $folder = if ($DefaultLocation) { Join-Path $root 'Reports/Findings/data' } else { $root }
                New-Item -ItemType Directory -Path $folder | Out-Null
                $findings = Get-Content -LiteralPath (Join-Path $PackRoot 'ci/fixtures/findings.json') -Raw | ConvertFrom-Json
                $findings.GeneratedAt = (Get-Date).ToUniversalTime().AddDays(-$AgeDays).ToString('o')
                if ($SchemaVersion) { $findings.SchemaVersion = $SchemaVersion }
                $findings | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $folder 'findings.json')
                $prepare = switch ($DefaultLocation) {
                    'EntraOpsRoot' { "`$env:ENTRAOPS_ROOT = '$root'" }
                    'CurrentFolder' { "`$env:ENTRAOPS_ROOT = `$null; Set-Location -LiteralPath '$root'" }
                    default { '' }
                }
                $config = if ($DefaultLocation) { '[pscustomobject]@{ GlobalSettings = [pscustomobject]@{} }' } else { "[pscustomobject]@{ GlobalSettings = [pscustomobject]@{ 'EntraOps.FindingsPath' = '$folder' } }" }
                # The pack looks in <home>/EntraOps before the current folder: an empty home for the run, so the
                # results of a local EntraOps working folder are not read.
                $previousHome = $env:HOME
                $previousUserProfile = $env:USERPROFILE
                try {
                    if ($DefaultLocation -eq 'CurrentFolder') {
                        $env:HOME = $env:USERPROFILE = (New-Item -ItemType Directory -Path (Join-Path $TestDrive "home-$([guid]::NewGuid())")).FullName
                    }
                    @(Invoke-EntraOpsPackMaester "$prepare`n@(Invoke-MtTest -Path '$PackRoot' -Config ($config) | Select-Object Id, Result, ReasonCode, ReasonDetail, @{ Name = 'TestResult'; Expression = { `$_.ResultDetail.TestResult } })")
                } finally {
                    $env:HOME = $previousHome
                    $env:USERPROFILE = $previousUserProfile
                }
            }
        }

        It 'keeps the identity that Maester requires to stay the same for every release' {
            $script:Manifest.Id | Should -Be 'cloud-architekt.entraops'
            $script:Manifest.Guid | Should -Be '01964975-3423-4c3e-a3a0-b2510e0d6e39'
            $script:Manifest.Code | Should -Be 'EOPS'
            $script:Manifest.Publisher | Should -Be 'Cloud-Architekt'
        }

        It 'reaches nothing: no service, scope, network host or module' {
            foreach ($use in 'Services', 'GraphScopes', 'TenantWrites', 'Network', 'Modules') { @($script:Manifest.Uses.$use).Count | Should -Be 0 -Because "Uses.$use stays empty" }
        }

        It 'has the version of the EntraOps module it was generated from, with release notes' {
            $script:Manifest.Version | Should -Match '^\d+\.\d+\.\d+$'
            $script:Source.Version | Should -Be $script:Manifest.Version
            Get-Content -LiteralPath (Join-Path $script:PackRoot 'CHANGELOG.md') -Raw | Should -Match ('(?m)^## ' + [regex]::Escape($script:Manifest.Version) + '\s*$')
        }

        It 'names its guide and banner' {
            $script:Manifest.Guide | Should -Be 'maester-pack.guide.json'
            $script:Manifest.Banner | Should -Be 'assets/banner.png'
            $guide = Get-Content -LiteralPath (Join-Path $script:PackRoot $script:Manifest.Guide) -Raw | ConvertFrom-Json
            $guide.Run.Commands.Command | Should -Contain "Invoke-Maester -Pack $($script:Manifest.Code) -SkipBuiltIn -SkipGraphConnect"
            # The Maester report shows the guide only on a guide page of the pack's menu.
            @($script:Manifest.Report.Navigation.Items | Where-Object View -eq 'guide').Page | Should -Be @('start', 'connect', 'run') -Because 'the report shows the guide only on the guide pages of Report.Navigation'
            (Get-Item -LiteralPath (Join-Path $script:PackRoot $script:Manifest.Banner)).Length | Should -BeLessOrEqual 1MB
        }

        It '<Name> has its description, author and help link' -ForEach $testScripts {
            $content = Get-Content -LiteralPath $Path -Raw
            $id = $Name -replace '^Test\.(.+)\.ps1$', '$1'
            $content | Should -Match ("Id\s+=\s+'" + [regex]::Escape($id) + "'")
            $content | Should -Match "Author\s+=\s+'Cloud-Architekt'"
            $content | Should -Match ("HelpUrl\s+=\s+'" + [regex]::Escape("$($script:Manifest.Homepage)/blob/main/tests/Test.$id.md") + "'")
            Join-Path (Split-Path -Parent $Path) "Test.$id.md" | Should -Exist
        }

        It '<Name> is listed in TESTS.md with its title, severity and category' -ForEach $testScripts {
            $content = Get-Content -LiteralPath $Path -Raw
            $id = $Name -replace '^Test\.(.+)\.ps1$', '$1'
            $title = [regex]::Match($content, "Title\s+=\s+'((?:[^']|'')*)'").Groups[1].Value -replace "''", "'"
            $severity = [regex]::Match($content, "Severity\s+=\s+'([^']+)'").Groups[1].Value
            $category = [regex]::Match($content, "Tag\s+=\s+\('EntraOps',\s*'([^']+)'\)").Groups[1].Value
            $tests = Get-Content -LiteralPath (Join-Path $script:PackRoot 'TESTS.md') -Raw
            $tests | Should -Match ('(?m)^' + [regex]::Escape("| [$id](tests/Test.$id.md) | $title | $severity | $category |") + '\s*$') -Because 'TESTS.md lists every test as its attributes define it'
        }

        It 'links every file to the repository of the manifest' {
            # A pack that moved repositories (tools/Set-EntraOpsPackRepository.ps1) must not keep a link to the old one.
            $script:Manifest.Homepage | Should -Match '^https://github\.com/Cloud-Architekt/[\w.-]+$'
            $repository = $script:Manifest.Homepage -replace '^https://github\.com/', ''
            $script:Manifest.Support | Should -Be "$($script:Manifest.Homepage)/issues"
            $script:Manifest.SecurityContact | Should -Be "$($script:Manifest.Homepage)/security/policy"
            (Get-Content -LiteralPath (Join-Path $script:PackRoot 'tests/suite.json') -Raw | ConvertFrom-Json).HelpUrlTemplate | Should -Be "$($script:Manifest.Homepage)/blob/main/tests/Test.{Id}.md"
            $files = Get-ChildItem -LiteralPath $script:PackRoot -File -Recurse -Force | Where-Object {
                $_.FullName -notmatch '[\\/]\.git[\\/]' -and $_.Extension -in '.md', '.json', '.ps1', '.yml', '.yaml' -and $_.Name -ne 'Set-EntraOpsPackRepository.ps1'
            }
            foreach ($file in $files) {
                foreach ($link in [regex]::Matches((Get-Content -LiteralPath $file.FullName -Raw), '(?<![\w-])Cloud-Architekt/[\w.-]*MaesterPack(?![\w-])')) {
                    $link.Value | Should -Be $repository -Because "$([System.IO.Path]::GetRelativePath($script:PackRoot, $file.FullName)) links to the pack repository"
                }
            }
        }

        It '<Name> holds only function definitions' -ForEach $packScripts {
            $tokens = $null; $errors = $null
            $ast = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$tokens, [ref]$errors)
            $errors | Should -BeNullOrEmpty
            foreach ($statement in $ast.EndBlock.Statements) {
                $statement | Should -BeOfType ([System.Management.Automation.Language.FunctionDefinitionAst]) -Because 'Maester refuses code outside a function in every .ps1 file of the pack'
            }
        }

        It 'passes the checks of Install-MtPack with Low risk' {
            # A copy without the files git does not publish (.git, Finder's .DS_Store).
            $copy = Join-Path $TestDrive 'pack'
            Copy-Item -LiteralPath $script:PackRoot -Destination $copy -Recurse
            Get-ChildItem -LiteralPath $copy -Recurse -Force -Filter '.DS_Store' | Remove-Item -Force
            Remove-Item -LiteralPath (Join-Path $copy '.git') -Recurse -Force -ErrorAction SilentlyContinue

            $check = Invoke-EntraOpsPackMaester ('$check = Test-MtPack ''{0}''; [pscustomobject]@{{ IsValid = $check.IsValid; Risk = $check.Risk; Errors = @($check.Errors | ForEach-Object {{ $_.Message }}); Warnings = @($check.Warnings | ForEach-Object {{ "$_" }}); Findings = @($check.Findings | ForEach-Object {{ "$($_.Severity) $($_.Code): $($_.Message)" }}) }}' -f $copy)
            $check.IsValid | Should -BeTrue -Because "$($check.Errors -join '; ')"
            $check.Risk | Should -Be 'Low' -Because "$($check.Findings -join '; ')"
            # A warning is a key this Maester ignores, for example a mistyped key of the manifest or of Report.Navigation.
            @($check.Warnings) | Should -BeNullOrEmpty -Because "$($check.Warnings -join '; ')"
        }

        It 'reports the results of findings.json' {
            $findings = Get-Content -LiteralPath (Join-Path $script:PackRoot 'ci/fixtures/findings.json') -Raw | ConvertFrom-Json
            $statusByTest = @{}
            foreach ($rule in $findings.Rules) {
                # A passed rule with risk-accepted findings doesn't meet the control: the test is skipped.
                $riskAccepted = @($rule.AcceptedResults | Where-Object { $_ -and $_.Exception.State -ne 'Dismissed' }).Count -gt 0
                $statusByTest[$rule.MaesterTestId] = if ($rule.Status -eq 'Passed' -and $riskAccepted) { 'RiskAccepted' } else { $rule.Status }
            }

            $results = Invoke-EntraOpsPackTestRun -PackRoot $script:PackRoot
            $results.Count | Should -Be $script:TestCount
            foreach ($result in $results) {
                $expected = switch ($statusByTest[$result.Id]) { 'Failed' { 'Failed' } 'Passed' { 'Passed' } 'Error' { 'Error' } default { 'Skipped' } }
                $result.Result | Should -Be $expected -Because "$($result.Id) has the status '$($statusByTest[$result.Id])' in findings.json"
            }
            @($findings.Rules | Where-Object Status -eq 'Error').Count | Should -BeGreaterThan 0 -Because 'the fixture covers a rule whose evaluation failed'
            @($statusByTest.Values | Where-Object { $_ -eq 'RiskAccepted' }).Count | Should -BeGreaterThan 0 -Because 'the fixture covers a rule that passes only by accepted risks'
            @($results | Where-Object { -not $statusByTest.ContainsKey($_.Id) }).Count | Should -BeGreaterThan 0 -Because 'the fixture leaves out a rule, like results of an EntraOps version without it (MP.EOPS.8002)'
        }

        It 'reports a rule whose evaluation failed in EntraOps as an error with the reason' {
            $findings = Get-Content -LiteralPath (Join-Path $script:PackRoot 'ci/fixtures/findings.json') -Raw | ConvertFrom-Json
            $errorRule = @($findings.Rules | Where-Object Status -eq 'Error')[0]
            $result = @(Invoke-EntraOpsPackTestRun -PackRoot $script:PackRoot | Where-Object Id -eq $errorRule.MaesterTestId)[0]
            $result.Result | Should -Be 'Error'
            $result.ReasonCode | Should -Be 'TestError'
            $result.ReasonDetail | Should -Match ([regex]::Escape($errorRule.Reason))
        }

        It 'reports the reason code and the note of EntraOps and names the tenant of the results' {
            $findings = Get-Content -LiteralPath (Join-Path $script:PackRoot 'ci/fixtures/findings.json') -Raw | ConvertFrom-Json
            $resultById = @{}
            foreach ($result in Invoke-EntraOpsPackTestRun -PackRoot $script:PackRoot) { $resultById[$result.Id] = $result }
            $covered = @{}
            foreach ($rule in $findings.Rules) {
                $result = $resultById[$rule.MaesterTestId]
                $reasonCode = if ($rule.PSObject.Properties['ReasonCode']) { [string]$rule.ReasonCode } else { $null }
                # Results of an EntraOps version without reason codes: a skipped rule with nothing in its scope is still not applicable.
                $case = if ($reasonCode) { $reasonCode } elseif ($rule.Status -eq 'Skipped' -and $rule.Reason -match 'in the scope of this rule \(0 evaluated\)') { 'NotApplicableWithoutReasonCode' }
                switch ($case) {
                    { $_ -in 'NotApplicable', 'NotApplicableWithoutReasonCode' } { $result.ReasonCode | Should -Be 'NotApplicable' -Because "$($rule.RuleId) has nothing in its scope" }
                    'Unclassified' { $result.ReasonDetail | Should -Match ('^' + [regex]::Escape("EntraOps did not report rule $($rule.RuleId): $($rule.Reason)")) }
                    'MissingData' { $result.ReasonDetail | Should -Match ('^' + [regex]::Escape("EntraOps could not evaluate rule $($rule.RuleId): $($rule.Reason)")) }
                    'Note' { $result.TestResult | Should -Match ([regex]::Escape("Note: $($rule.Reason)")) -Because "$($rule.RuleId) is $($rule.Status) with a note" }
                }
                if ($case) { $covered[$case] = $true }
            }
            foreach ($case in 'NotApplicable', 'NotApplicableWithoutReasonCode', 'Unclassified', 'MissingData', 'Note') {
                $covered[$case] | Should -BeTrue -Because "the fixture covers the case $case"
            }
            foreach ($result in @($resultById.Values | Where-Object Result -in 'Passed', 'Failed')) {
                $result.TestResult | Should -Match ([regex]::Escape("results of $($findings.TenantName), ")) -Because "$($result.Id) names the tenant of the results"
            }
        }

        It 'finds the results in Reports/Findings/data of the EntraOps working folder without a setting (<_>)' -ForEach @('EntraOpsRoot', 'CurrentFolder') {
            $results = @(Invoke-EntraOpsPackTestRun -PackRoot $script:PackRoot -DefaultLocation $_)
            $results.Count | Should -Be $script:TestCount
            @($results | Where-Object Result -eq 'Passed').Count | Should -BeGreaterThan 0
        }

        It 'skips every test for results that are too old or of an unknown schema' {
            @(Invoke-EntraOpsPackTestRun -PackRoot $script:PackRoot -AgeDays 10).Result | Select-Object -Unique | Should -Be 'Skipped'
            @(Invoke-EntraOpsPackTestRun -PackRoot $script:PackRoot -SchemaVersion '2.0').Result | Select-Object -Unique | Should -Be 'Skipped'
        }
    }
}
