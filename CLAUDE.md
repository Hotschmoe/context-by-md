# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**context-by-md** is a lightweight markdown-based context management system for Claude Code. Provides session continuity across context window limits without external dependencies.

Philosophy: 80% of the value with 20% of the complexity using plain markdown.

## Repository Structure

```
context-by-md/
├── README.md
└── clean/context-by-md/         # Installable package
    ├── CLAUDE.md                # Installed to user projects
    ├── install.ps1              # Local install (Windows)
    ├── install-remote.ps1       # One-line remote install
    ├── .context-by-md/
    │   ├── CURRENT.md           # Session state
    │   ├── PLAN.md              # Task list (terse)
    │   ├── ACTIONPLAN.md        # Active task detail
    │   ├── BACKLOG.md           # Bugs, debt, ideas
    │   └── sessions/
    └── .claude/
        ├── commands/            # Slash commands
        ├── hooks/               # Auto-checkpoint on stop
        └── settings.local.json
```

## Key Concepts

### Task Format (PLAN.md - Terse)
```markdown
- [WIP] P1: Task title | context | next: action
- [READY] P2: Another task | details | next: first step
```

### Action Planning (ACTIONPLAN.md - Detailed)
When starting a task, `/context-task start` runs an interview:
- Goal & definition of done
- Scope (in/out)
- Constraints & unknowns
- Decomposition into subtasks
- Decision checkpoints

Only the active task gets this detail. Archived when task completes.

### Status Markers
`[READY]` `[WIP]` `[BLOCKED]` `[DONE]` `[PAUSED]`

### Priority
P0=Critical, P1=High, P2=Medium, P3=Low

## Archiving

- Done tasks: `archive/done-YYYY-MM.md`
- Action plans: `archive/plans/YYYY-MM-DD_task-name.md`

## Development

No build system or dependencies. Edit files in `clean/context-by-md/`.

### Testing
1. Install to test project: `.\clean\context-by-md\install.ps1`
2. Test slash commands
3. Verify hooks fire on stop
