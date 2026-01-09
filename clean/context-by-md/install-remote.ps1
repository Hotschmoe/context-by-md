# Remote install - downloads and installs context-by-md from GitHub
# Usage: irm https://raw.githubusercontent.com/hotschmoe/context-by-md/master/clean/context-by-md/install-remote.ps1 | iex

$ErrorActionPreference = "Stop"

$Repo = "hotschmoe/context-by-md"
$Branch = "master"
$BaseUrl = "https://raw.githubusercontent.com/$Repo/$Branch/clean/context-by-md"

Write-Host "Installing context-by-md..." -ForegroundColor Cyan

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

# Download context files
Write-Host "Downloading context files..."
Invoke-RestMethod "$BaseUrl/.context-by-md/CURRENT.md" -OutFile ".context-by-md\CURRENT.md"
Invoke-RestMethod "$BaseUrl/.context-by-md/PLAN.md" -OutFile ".context-by-md\PLAN.md"
Invoke-RestMethod "$BaseUrl/.context-by-md/ACTIONPLAN.md" -OutFile ".context-by-md\ACTIONPLAN.md"
Invoke-RestMethod "$BaseUrl/.context-by-md/BACKLOG.md" -OutFile ".context-by-md\BACKLOG.md"
Invoke-RestMethod "$BaseUrl/.context-by-md/QUICKREF.md" -OutFile ".context-by-md\QUICKREF.md"
Invoke-RestMethod "$BaseUrl/.context-by-md/sessions/_template.md" -OutFile ".context-by-md\sessions\_template.md"

# Download Claude commands
Write-Host "Downloading Claude commands..."
Invoke-RestMethod "$BaseUrl/.claude/commands/context-start.md" -OutFile ".claude\commands\context-start.md"
Invoke-RestMethod "$BaseUrl/.claude/commands/context-checkpoint.md" -OutFile ".claude\commands\context-checkpoint.md"
Invoke-RestMethod "$BaseUrl/.claude/commands/context-task.md" -OutFile ".claude\commands\context-task.md"

# Download hooks (PowerShell versions for Windows)
Write-Host "Downloading hooks..."
Invoke-RestMethod "$BaseUrl/.claude/hooks/context-start.ps1" -OutFile ".claude\hooks\context-start.ps1"
Invoke-RestMethod "$BaseUrl/.claude/hooks/context-stop.ps1" -OutFile ".claude\hooks\context-stop.ps1"

# Download or merge settings (Windows version with PowerShell hooks)
if (Test-Path ".claude\settings.local.json") {
    Write-Host "  .claude\settings.local.json exists - please manually add hooks" -ForegroundColor Yellow
    Write-Host "   See $BaseUrl/.claude/settings.local.json for reference" -ForegroundColor Yellow
} else {
    Invoke-RestMethod "$BaseUrl/.claude/settings.local.json" -OutFile ".claude\settings.local.json"
}

# Download and append/create CLAUDE.md
if (Test-Path "CLAUDE.md") {
    Add-Content -Path "CLAUDE.md" -Value ""
    Add-Content -Path "CLAUDE.md" -Value "---"
    Add-Content -Path "CLAUDE.md" -Value ""
    $claudeMd = Invoke-RestMethod "$BaseUrl/CLAUDE.md"
    Add-Content -Path "CLAUDE.md" -Value $claudeMd
    Write-Host "Appended context instructions to existing CLAUDE.md" -ForegroundColor Green
} else {
    Invoke-RestMethod "$BaseUrl/CLAUDE.md" -OutFile "CLAUDE.md"
    Write-Host "Created CLAUDE.md" -ForegroundColor Green
}

Write-Host ""
Write-Host "Context system installed!" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:"
Write-Host "  .context-by-md\QUICKREF.md   - Command cheat sheet"
Write-Host "  .context-by-md\CURRENT.md    - Session state"
Write-Host "  .context-by-md\PLAN.md       - Task list (terse)"
Write-Host "  .context-by-md\ACTIONPLAN.md - Active task detail"
Write-Host "  .context-by-md\BACKLOG.md    - Bugs, debt, ideas"
Write-Host "  .claude\commands\            - Slash commands"
Write-Host "  .claude\hooks\               - Auto-checkpoint on stop"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Edit .context-by-md\CURRENT.md with your project info"
Write-Host "  2. Add tasks to PLAN.md: - [READY] P1: Task | context | next: action"
Write-Host "  3. Run /context-start then /context-task start 'Task name'"
