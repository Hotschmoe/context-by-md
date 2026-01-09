# Install markdown context system into current project
# Usage: .\install.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Installing markdown context system..." -ForegroundColor Cyan

# Check for existing installation
if ((Test-Path ".context-by-md") -and (Test-Path ".context-by-md\CURRENT.md")) {
    Write-Host ""
    Write-Host "Existing context-by-md installation detected." -ForegroundColor Yellow
    Write-Host "This will overwrite your context files (CURRENT.md, PLAN.md)." -ForegroundColor Yellow
    $response = Read-Host "Continue? [y/N]"
    if ($response -notmatch "^[Yy]$") {
        Write-Host "Installation cancelled." -ForegroundColor Cyan
        exit 1
    }
}

# Create directories
New-Item -ItemType Directory -Force -Path ".context-by-md" | Out-Null
New-Item -ItemType Directory -Force -Path ".claude\commands" | Out-Null
New-Item -ItemType Directory -Force -Path ".claude\hooks" | Out-Null

# Copy context files
Copy-Item "$ScriptDir\.context-by-md\CURRENT.md" ".context-by-md\"
Copy-Item "$ScriptDir\.context-by-md\PLAN.md" ".context-by-md\"
Copy-Item "$ScriptDir\.context-by-md\QUICKREF.md" ".context-by-md\"

# Copy Claude commands
Copy-Item "$ScriptDir\.claude\commands\*.md" ".claude\commands\"

# Copy hooks (PowerShell versions for Windows)
Copy-Item "$ScriptDir\.claude\hooks\*.ps1" ".claude\hooks\"

# Copy or merge settings (Windows version with PowerShell hooks)
if (Test-Path ".claude\settings.local.json") {
    Write-Host "  .claude\settings.local.json exists - please manually add hooks" -ForegroundColor Yellow
    Write-Host "   See $ScriptDir\.claude\settings.local.json for reference" -ForegroundColor Yellow
} else {
    Copy-Item "$ScriptDir\.claude\settings.local.json" ".claude\"
}

# Add CLAUDE.md content or create it
if (Test-Path "CLAUDE.md") {
    Add-Content -Path "CLAUDE.md" -Value ""
    Add-Content -Path "CLAUDE.md" -Value "---"
    Add-Content -Path "CLAUDE.md" -Value ""
    Get-Content "$ScriptDir\CLAUDE.md" | Add-Content -Path "CLAUDE.md"
    Write-Host "Appended context instructions to existing CLAUDE.md" -ForegroundColor Green
} else {
    Copy-Item "$ScriptDir\CLAUDE.md" "."
    Write-Host "Created CLAUDE.md" -ForegroundColor Green
}

Write-Host ""
Write-Host "Context system installed!" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:"
Write-Host "  .context-by-md\CURRENT.md  - Session state + active task"
Write-Host "  .context-by-md\PLAN.md     - Task list + backlog"
Write-Host "  .context-by-md\QUICKREF.md - Command cheat sheet"
Write-Host "  .claude\commands\          - Slash commands"
Write-Host "  .claude\hooks\             - Auto-checkpoint reminder"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Add tasks: /context-task add P1: Task | context | next: action"
Write-Host "  2. Start work: /context-task start 'Task name'"
Write-Host "  3. Save state: /context-checkpoint"
