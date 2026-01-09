# Claude Instructions

## Context System

This project uses markdown context in `.context-by-md/`.

### Commands
| Command | What it does |
|---------|--------------|
| `/context-task` | List tasks (default) |
| `/context-task start 1` | Start task #1 |
| `/context-task start 1 --plan` | Start with interview |
| `/context-task add P1: X` | Add task |
| `/context-task done` | Complete active task |
| `/context-checkpoint` | Save state |

### Files
| File | Purpose |
|------|---------|
| `CURRENT.md` | Session state + active task |
| `PLAN.md` | Task list + backlog |

### Workflow
```
/context-task          # List tasks
/context-task start 1  # Start task #1
[work]                 # Update subtasks in CURRENT.md
/context-task done     # Complete task
/context-checkpoint    # Save state
```

### On Compaction
1. Run `/context-checkpoint`
2. Read CURRENT.md
3. Continue from current subtask
