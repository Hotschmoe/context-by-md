#!/bin/bash
# Install markdown context system into current project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing markdown context system..."

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

# Copy context files
cp "$SCRIPT_DIR/.context-by-md/CURRENT.md" .context-by-md/
cp "$SCRIPT_DIR/.context-by-md/PLAN.md" .context-by-md/
cp "$SCRIPT_DIR/.context-by-md/QUICKREF.md" .context-by-md/

# Copy Claude commands
cp "$SCRIPT_DIR/.claude/commands/"*.md .claude/commands/

# Copy hooks (bash versions for Unix)
cp "$SCRIPT_DIR/.claude/hooks/"*.sh .claude/hooks/
chmod +x .claude/hooks/*.sh

# Copy or merge settings (use Unix version)
if [ -f .claude/settings.local.json ]; then
    echo "[!] .claude/settings.local.json exists - please manually add hooks"
    echo "    See $SCRIPT_DIR/.claude/settings.local.unix.json for reference"
else
    cp "$SCRIPT_DIR/.claude/settings.local.unix.json" .claude/settings.local.json
fi

# Add CLAUDE.md content or create it
if [ -f CLAUDE.md ]; then
    echo "" >> CLAUDE.md
    echo "---" >> CLAUDE.md
    echo "" >> CLAUDE.md
    cat "$SCRIPT_DIR/CLAUDE.md" >> CLAUDE.md
    echo "[OK] Appended context instructions to existing CLAUDE.md"
else
    cp "$SCRIPT_DIR/CLAUDE.md" .
    echo "[OK] Created CLAUDE.md"
fi

echo ""
echo "[OK] Context system installed!"
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
