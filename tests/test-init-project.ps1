[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$managedFiles = @(
    'AGENTS.md',
    'PRD.md',
    'APP_FLOW.md',
    'TECH_STACK.md',
    'FRONTEND_GUIDELINES.md',
    'BACKEND_STRUCTURE.md',
    'IMPLEMENTATION_PLAN.md',
    'progress.txt',
    'lessons.md'
)

$repository = Split-Path -Parent $PSScriptRoot
$initializer = Join-Path $repository '.agents\skills\vibe-coding-workflow\scripts\init-project.ps1'
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("vibe-workflow-test-" + [guid]::NewGuid().ToString('N'))

try {
    & $initializer -TargetPath $testRoot | Out-Host

    $actualFiles = @(Get-ChildItem -LiteralPath $testRoot -File | Select-Object -ExpandProperty Name | Sort-Object)
    $expectedFiles = @($managedFiles | Sort-Object)
    if (($actualFiles -join '|') -ne ($expectedFiles -join '|')) {
        throw "Unexpected initialized files. Expected '$($expectedFiles -join ', ')'; actual '$($actualFiles -join ', ')'."
    }

    $prdPath = Join-Path $testRoot 'PRD.md'
    $sentinel = "`nPRESERVE_EXISTING_CONTENT`n"
    Add-Content -LiteralPath $prdPath -Value $sentinel -NoNewline
    $beforeHash = (Get-FileHash -LiteralPath $prdPath -Algorithm SHA256).Hash

    $secondRun = & $initializer -TargetPath $testRoot
    $afterHash = (Get-FileHash -LiteralPath $prdPath -Algorithm SHA256).Hash

    if ($beforeHash -ne $afterHash) {
        throw 'Initializer overwrote an existing managed file.'
    }
    if (-not ($secondRun -match 'Skipped existing \(9\)')) {
        throw 'Second run did not report all managed files as skipped.'
    }

    Write-Output 'PowerShell initializer test passed.'
}
finally {
    $resolvedTemp = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
    $resolvedTest = [System.IO.Path]::GetFullPath($testRoot)
    if ($resolvedTest.StartsWith($resolvedTemp, [System.StringComparison]::OrdinalIgnoreCase) -and
        (Split-Path -Leaf $resolvedTest).StartsWith('vibe-workflow-test-')) {
        Remove-Item -LiteralPath $resolvedTest -Recurse -Force -ErrorAction SilentlyContinue
    }
}
