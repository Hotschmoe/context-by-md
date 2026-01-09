#!/bin/bash
# Remote install - downloads and installs context-by-md from GitHub
# Usage: curl -fsSL https://raw.githubusercontent.com/hotschmoe/context-by-md/master/clean/context-by-md/install-remote.sh | bash

set -e

REPO="hotschmoe/context-by-md"
BRANCH="master"
BASE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/clean/context-by-md"

echo "[*] Installing context-by-md..."

# Check for existing installation
if [ -d ".context-by-md" ] && [ -f ".context-by-md/CURRENT.md" ]; then
    echo ""
    echo "[!] Existing context-by-md installation detected."
    echo "    This will overwrite your context files (CURRENT.md, PLAN.md)."
    read -p "    Continue? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[*] Installation cancelled."
        exit 1
    fi
fi

# Create directories
mkdir -p .context-by-md
mkdir -p .claude/commands
mkdir -p .claude/hooks

# Download context files
echo "Downloading context files..."
curl -fsSL "$BASE_URL/.context-by-md/CURRENT.md" -o .context-by-md/CURRENT.md
curl -fsSL "$BASE_URL/.context-by-md/PLAN.md" -o .context-by-md/PLAN.md
curl -fsSL "$BASE_URL/.context-by-md/QUICKREF.md" -o .context-by-md/QUICKREF.md

# Download Claude commands
echo "Downloading Claude commands..."
curl -fsSL "$BASE_URL/.claude/commands/context-start.md" -o .claude/commands/context-start.md
curl -fsSL "$BASE_URL/.claude/commands/context-checkpoint.md" -o .claude/commands/context-checkpoint.md
curl -fsSL "$BASE_URL/.claude/commands/context-task.md" -o .claude/commands/context-task.md

# Download hooks (bash versions for Unix)
echo "Downloading hooks..."
curl -fsSL "$BASE_URL/.claude/hooks/context-start.sh" -o .claude/hooks/context-start.sh
curl -fsSL "$BASE_URL/.claude/hooks/context-stop.sh" -o .claude/hooks/context-stop.sh
chmod +x .claude/hooks/*.sh

# Download or merge settings (Unix version)
if [ -f .claude/settings.local.json ]; then
    echo "  .claude/settings.local.json exists - please manually add hooks"
    echo "   See $BASE_URL/.claude/settings.local.unix.json for reference"
else
    curl -fsSL "$BASE_URL/.claude/settings.local.unix.json" -o .claude/settings.local.json
fi

# Download and append/create CLAUDE.md
if [ -f CLAUDE.md ]; then
    echo "" >> CLAUDE.md
    echo "---" >> CLAUDE.md
    echo "" >> CLAUDE.md
    curl -fsSL "$BASE_URL/CLAUDE.md" >> CLAUDE.md
    echo "Appended context instructions to existing CLAUDE.md"
else
    curl -fsSL "$BASE_URL/CLAUDE.md" -o CLAUDE.md
    echo "Created CLAUDE.md"
fi

echo ""
echo "Context system installed!"
echo ""
echo "Files created:"
echo "  .context-by-md/CURRENT.md  - Session state + active task"
echo "  .context-by-md/PLAN.md     - Task list + backlog"
echo "  .context-by-md/QUICKREF.md - Command cheat sheet"
echo "  .claude/commands/          - Slash commands"
echo "  .claude/hooks/             - Auto-checkpoint reminder"
echo ""
echo "Next steps:"
echo "  1. Add tasks: /context-task add P1: Task | context | next: action"
echo "  2. Start work: /context-task start 'Task name'"
echo "  3. Save state: /context-checkpoint"
