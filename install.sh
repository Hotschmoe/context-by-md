#!/bin/bash
# Install markdown context system into current project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing markdown context system..."

# Check for existing installation
if [ -d ".context-by-md" ] && [ -f ".context-by-md/CURRENT.md" ]; then
    echo ""
    echo "[!] Existing context-by-md installation detected."
    echo "    This will overwrite your context files (CURRENT.md, PLAN.md, BACKLOG.md)."
    read -p "    Continue? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[*] Installation cancelled."
        exit 1
    fi
fi

# Create directories
mkdir -p .context-by-md/sessions
mkdir -p .context-by-md/archive
mkdir -p .claude/commands

# Copy context files
cp "$SCRIPT_DIR/.context-by-md/CURRENT.md" .context-by-md/
cp "$SCRIPT_DIR/.context-by-md/PLAN.md" .context-by-md/
cp "$SCRIPT_DIR/.context-by-md/BACKLOG.md" .context-by-md/
cp "$SCRIPT_DIR/.context-by-md/sessions/_template.md" .context-by-md/sessions/ 2>/dev/null || true

# Copy Claude commands
cp "$SCRIPT_DIR/.claude/commands/"*.md .claude/commands/

# Copy or merge settings
if [ -f .claude/settings.local.json ]; then
    echo "[!] .claude/settings.local.json exists - please manually add hooks"
    echo "   See $SCRIPT_DIR/.claude/settings.local.json for reference"
else
    cp "$SCRIPT_DIR/.claude/settings.local.json" .claude/
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
echo "  .context-by-md/CURRENT.md    - Active work state"
echo "  .context-by-md/PLAN.md       - Task tracking"
echo "  .context-by-md/BACKLOG.md    - Future work"
echo "  .context-by-md/sessions/     - Session logs"
echo "  .claude/commands/            - Slash commands"
echo ""
echo "Next steps:"
echo "  1. Edit .context-by-md/CURRENT.md with your project info"
echo "  2. Add initial tasks to .context-by-md/PLAN.md"
echo "  3. Tell Claude to run /context-start"
