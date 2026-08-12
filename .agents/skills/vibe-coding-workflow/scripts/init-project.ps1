[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,

    [switch]$DryRun
)

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

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillDirectory = Split-Path -Parent $scriptDirectory
$templateDirectory = Join-Path $skillDirectory 'assets\templates'
$resolvedTarget = [System.IO.Path]::GetFullPath($TargetPath)

if (-not (Test-Path -LiteralPath $templateDirectory -PathType Container)) {
    throw "Template directory not found: $templateDirectory"
}

foreach ($fileName in $managedFiles) {
    $templatePath = Join-Path $templateDirectory $fileName
    if (-not (Test-Path -LiteralPath $templatePath -PathType Leaf)) {
        throw "Required template not found: $templatePath"
    }
}

if (-not $DryRun -and -not (Test-Path -LiteralPath $resolvedTarget)) {
    New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
}

$created = [System.Collections.Generic.List[string]]::new()
$skipped = [System.Collections.Generic.List[string]]::new()

foreach ($fileName in $managedFiles) {
    $templatePath = Join-Path $templateDirectory $fileName
    $destinationPath = Join-Path $resolvedTarget $fileName

    if (Test-Path -LiteralPath $destinationPath) {
        $skipped.Add($fileName)
        continue
    }

    if (-not $DryRun) {
        Copy-Item -LiteralPath $templatePath -Destination $destinationPath
    }
    $created.Add($fileName)
}

Write-Output "Target: $resolvedTarget"
Write-Output "Mode: $(if ($DryRun) { 'dry-run' } else { 'write' })"
Write-Output "Created ($($created.Count)): $($created -join ', ')"
Write-Output "Skipped existing ($($skipped.Count)): $($skipped -join ', ')"
