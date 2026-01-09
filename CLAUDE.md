# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**context-by-md** is a lightweight markdown-based context management system for Claude Code. It provides session continuity across context window limits without requiring external dependencies like databases or daemons.

The philosophy: achieve 80% of the value of complex context systems with 20% of the complexity using plain markdown files that are human-readable and git-friendly.

## Repository Structure

```
context-by-md/
├── README.md                    # Project documentation
└── clean/context-by-md/         # The installable package
    ├── CLAUDE.md                # Instructions appended to user's CLAUDE.md on install
    ├── install.ps1              # Local install script (Windows)
    ├── install-remote.ps1       # Remote one-line install (Windows)
    ├── .context-by-md/          # Context files template
    │   ├── CURRENT.md           # Active work state
    │   ├── PLAN.md              # Task tracking with status markers
    │   ├── BACKLOG.md           # Future work, bugs, ideas
    │   └── sessions/            # Session logs
    └── .claude/
        ├── commands/            # Slash commands
        │   ├── context-start.md
        │   ├── context-checkpoint.md
        │   └── context-task.md
        ├── hooks/               # Auto-checkpoint hooks
        │   ├── context-start.ps1
        │   └── context-stop.ps1
        └── settings.local.json  # Hook configuration
```

## How the System Works

1. **Session Start**: User runs `/context-start`, Claude reads CURRENT.md and PLAN.md to understand what was being worked on
2. **During Work**: Claude updates CURRENT.md periodically and tracks tasks in PLAN.md
3. **Session End**: Stop hook reminds Claude to run `/context-checkpoint`, which saves state and creates a session log
4. **On Compaction**: Claude reads CURRENT.md "Immediate Next Steps" and continues seamlessly

### Key Files (in installed projects)

| File | Purpose |
|------|---------|
| `.context-by-md/CURRENT.md` | Active focus, next steps, critical context |
| `.context-by-md/PLAN.md` | Task tracking with [READY]/[WIP]/[BLOCKED]/[DONE] status |
| `.context-by-md/BACKLOG.md` | Discovered bugs, tech debt, future improvements |
| `.context-by-md/sessions/*.md` | Historical session logs |

### Slash Commands

- `/context-start` - Read context files and orient to current state
- `/context-checkpoint` - Save current state to context files and create session log
- `/context-task` - Quick task operations (add, done, block, ready, find)

## Development

This project has no build system, tests, or dependencies. Changes are made directly to the markdown and PowerShell files in `clean/context-by-md/`.

### Testing Changes

1. Install to a test project: `.\clean\context-by-md\install.ps1` from the test project directory
2. Verify the slash commands work in Claude Code
3. Check that hooks fire on session stop

### Important Conventions

- **Status markers in PLAN.md**: [READY], [WIP], [BLOCKED], [DONE], [PAUSED], [ABANDONED]
- **Priority markers**: P0 (critical) through P3 (low)
- **Timestamps**: Use ISO format (YYYY-MM-DD HH:MM)
- **Session log naming**: `YYYY-MM-DD_HHMM.md`
