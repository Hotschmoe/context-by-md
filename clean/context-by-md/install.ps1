# Install markdown context system into current project
# Usage: .\install.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Installing markdown context system..." -ForegroundColor Cyan

# Check for existing installation
if ((Test-Path ".context-by-md") -and (Test-Path ".context-by-md\CURRENT.md")) {
    Write-Host ""
    Write-Host "Existing context-by-md installation detected." -ForegroundColor Yellow
    Write-Host "This will overwrite your context files (CURRENT.md, PLAN.md, BACKLOG.md)." -ForegroundColor Yellow
    $response = Read-Host "Continue? [y/N]"
    if ($response -notmatch "^[Yy]$") {
        Write-Host "Installation cancelled." -ForegroundColor Cyan
        exit 1
    }
}

# Create directories
New-Item -ItemType Directory -Force -Path ".context-by-md\sessions" | Out-Null
New-Item -ItemType Directory -Force -Path ".context-by-md\archive\plans" | Out-Null
New-Item -ItemType Directory -Force -Path ".claude\commands" | Out-Null
New-Item -ItemType Directory -Force -Path ".claude\hooks" | Out-Null

# Copy context files
Copy-Item "$ScriptDir\.context-by-md\CURRENT.md" ".context-by-md\"
Copy-Item "$ScriptDir\.context-by-md\PLAN.md" ".context-by-md\"
Copy-Item "$ScriptDir\.context-by-md\ACTIONPLAN.md" ".context-by-md\"
Copy-Item "$ScriptDir\.context-by-md\BACKLOG.md" ".context-by-md\"
if (Test-Path "$ScriptDir\.context-by-md\sessions\_template.md") {
    Copy-Item "$ScriptDir\.context-by-md\sessions\_template.md" ".context-by-md\sessions\"
}

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
Write-Host "  .context-by-md\CURRENT.md    - Session state"
Write-Host "  .context-by-md\PLAN.md       - Task list (terse)"
Write-Host "  .context-by-md\ACTIONPLAN.md - Active task detail"
Write-Host "  .context-by-md\BACKLOG.md    - Bugs, debt, ideas"
Write-Host "  .context-by-md\sessions\     - Session logs"
Write-Host "  .claude\commands\            - Slash commands"
Write-Host "  .claude\hooks\               - Auto-checkpoint on stop"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Edit .context-by-md\CURRENT.md with your project info"
Write-Host "  2. Add tasks to PLAN.md: - [READY] P1: Task | context | next: action"
Write-Host "  3. Run /context-start then /context-task start 'Task name'"
