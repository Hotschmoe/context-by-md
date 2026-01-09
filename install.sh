#!/bin/bash
# Install markdown context system into current project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Installing markdown context system..."

# Create directories
mkdir -p .context/sessions
mkdir -p .context/archive
mkdir -p .claude/commands

# Copy context files
cp "$SCRIPT_DIR/.context/CURRENT.md" .context/
cp "$SCRIPT_DIR/.context/PLAN.md" .context/
cp "$SCRIPT_DIR/.context/BACKLOG.md" .context/
cp "$SCRIPT_DIR/.context/sessions/_template.md" .context/sessions/

# Copy Claude commands
cp "$SCRIPT_DIR/.claude/commands/"*.md .claude/commands/

# Copy or merge settings
if [ -f .claude/settings.local.json ]; then
    echo "⚠️  .claude/settings.local.json exists - please manually add hooks"
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
    echo "✅ Appended context instructions to existing CLAUDE.md"
else
    cp "$SCRIPT_DIR/CLAUDE.md" .
    echo "✅ Created CLAUDE.md"
fi

echo ""
echo "✅ Context system installed!"
echo ""
echo "Files created:"
echo "  .context/CURRENT.md    - Active work state"
echo "  .context/PLAN.md       - Task tracking"
echo "  .context/BACKLOG.md    - Future work"
echo "  .context/sessions/     - Session logs"
echo "  .claude/commands/      - Slash commands"
echo ""
echo "Next steps:"
echo "  1. Edit .context/CURRENT.md with your project info"
echo "  2. Add initial tasks to .context/PLAN.md"
echo "  3. Tell Claude to run /context-start"
