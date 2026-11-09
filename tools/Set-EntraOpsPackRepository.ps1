function Set-EntraOpsPackRepository {
    <#
    .SYNOPSIS
    Points the links of the pack to another GitHub repository: the manifest, the suite, the help link of every
    test, the guide, the documentation and the GitHub templates.

    .DESCRIPTION
    The pack is tested in a private Insiders repository (EntraOps-Insiders-MaesterPack) before it is published
    as EntraOps-MaesterPack. Build-EntraOpsMaesterPack.ps1 of EntraOps always writes the links of the published
    repository, so run this function after each build of the Insiders pack, and once more before publishing to
    switch back and remove the notes that apply to the Insiders repository only (-RemoveInsidersSection).

    The current repository is read from Homepage in maester-pack.json. Every <Owner>/<current repository> in the
    text files of the pack (not in .git, not in this file) becomes <Owner>/<Name>. A name without the owner, such
    as the local folder of a clone, is not changed. With -RemoveInsidersSection, the parts of the Markdown files
    between <!-- insiders:start --> and <!-- insiders:end --> are removed first.

    The pack is the whole repository, and Maester refuses any .ps1 file with code outside a function, so this is
    a function. Returns one object per changed file.

    .PARAMETER Name
    The repository to point the links to, for example EntraOps-MaesterPack.

    .PARAMETER Owner
    The owner of the repository. Default: Cloud-Architekt.

    .PARAMETER RemoveInsidersSection
    Remove the Insiders notes (<!-- insiders:start --> to <!-- insiders:end -->) from the Markdown files.

    .PARAMETER Path
    The root of the pack. Default: the parent folder of this file.

    .EXAMPLE
    . ./tools/Set-EntraOpsPackRepository.ps1
    Set-EntraOpsPackRepository -Name EntraOps-Insiders-MaesterPack

    After a build from EntraOps: points the links to the private Insiders repository again.

    .EXAMPLE
    . ./tools/Set-EntraOpsPackRepository.ps1
    Set-EntraOpsPackRepository -Name EntraOps-MaesterPack -RemoveInsidersSection -WhatIf

    Before publishing: shows which files would point to the public repository and lose the Insiders notes.
    Run it again without -WhatIf to change them.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory)]
        [ValidatePattern('^[A-Za-z0-9._-]+$')]
        [string] $Name,

        [ValidatePattern('^[A-Za-z0-9-]+$')]
        [string] $Owner = 'Cloud-Architekt',

        [switch] $RemoveInsidersSection,

        [string] $Path = (Split-Path -Parent $PSScriptRoot)
    )

    $root = (Resolve-Path -LiteralPath $Path).ProviderPath
    $manifestPath = Join-Path -Path $root -ChildPath 'maester-pack.json'
    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    $homepage = [regex]::Match("$($manifest.Homepage)", "^https://github\.com/$([regex]::Escape($Owner))/([A-Za-z0-9._-]+)$", 'IgnoreCase')
    if (-not $homepage.Success) { throw "Homepage in $manifestPath is '$($manifest.Homepage)', not a GitHub repository of $Owner." }
    $current = $homepage.Groups[1].Value

    # <Owner>/<current repository> as a whole name: not a part of a longer name (EntraOps-MaesterPack in
    # EntraOps-MaesterPack-Old), but followed by a path, @ref, .git or the end of a sentence.
    $repositoryPattern = '(?<![\w-]){0}/{1}(?![\w-])' -f [regex]::Escape($Owner), [regex]::Escape($current)
    $replacement = "$Owner/$Name"
    $insidersPattern = '(?s)[ \t]*<!-- insiders:start -->.*?<!-- insiders:end -->[ \t]*(\r?\n)?(\r?\n)?'
    $binaryExtensions = '.png', '.jpg', '.jpeg', '.gif', '.ico', '.svg', '.zip', '.nupkg'

    $files = Get-ChildItem -LiteralPath $root -File -Recurse -Force | Where-Object {
        $relative = [System.IO.Path]::GetRelativePath($root, $_.FullName)
        $relative -notmatch '^\.git([\\/]|$)' -and
        $_.Name -ne '.DS_Store' -and
        $_.Extension -notin $binaryExtensions -and
        $_.FullName -ne $PSCommandPath
    }

    foreach ($file in $files) {
        $content = Get-Content -LiteralPath $file.FullName -Raw
        if ([string]::IsNullOrEmpty($content)) { continue }
        $updated = $content
        $sections = 0
        if ($RemoveInsidersSection -and $file.Extension -eq '.md') {
            $sections = [regex]::Matches($updated, $insidersPattern).Count
            $updated = [regex]::Replace($updated, $insidersPattern, '')
        }
        $links = 0
        if ($current -cne $Name) {
            $links = [regex]::Matches($updated, $repositoryPattern, 'IgnoreCase').Count
            $updated = [regex]::Replace($updated, $repositoryPattern, $replacement, 'IgnoreCase')
        }
        if ($updated -ceq $content) { continue }

        $relative = [System.IO.Path]::GetRelativePath($root, $file.FullName)
        if ($PSCmdlet.ShouldProcess($relative, "Point $links link(s) from $Owner/$current to $replacement and remove $sections Insiders section(s)")) {
            Set-Content -LiteralPath $file.FullName -Value $updated -NoNewline -Encoding utf8NoBOM
        }
        [pscustomobject]@{
            File                    = $relative
            Links                   = $links
            InsidersSectionsRemoved = $sections
        }
    }
}
