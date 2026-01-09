# Quick Reference

## Commands

| Command | What it does |
|---------|--------------|
| `/context-start` | Read context, orient to state |
| `/context-task start "X"` | Interview + plan task |
| `/context-task add P1: X` | Add task to PLAN.md |
| `/context-task done X` | Mark complete |
| `/context-task block X` | Mark blocked |
| `/context-task ready X` | Unblock |
| `/context-task decide` | Record decision |
| `/context-task finish` | Archive + clear action plan |
| `/context-checkpoint` | Save all state |

## Task Format

```
- [STATUS] P#: Title | context | next: action
```

**Status:** `[READY]` `[WIP]` `[BLOCKED]` `[DONE]`
**Priority:** P0=Critical P1=High P2=Medium P3=Low

## Files

| File | Purpose |
|------|---------|
| `CURRENT.md` | Session state, next steps |
| `PLAN.md` | Task list (terse) |
| `ACTIONPLAN.md` | Active task detail |
| `BACKLOG.md` | Bugs, debt, ideas |

## Workflow

```
/context-start                    # Begin session
    ↓
/context-task start "Task"        # Interview → ACTIONPLAN.md
    ↓
[work on subtasks]                # Check off in ACTIONPLAN.md
    ↓
/context-task finish              # Archive, mark done
    ↓
/context-checkpoint               # Save state (auto on stop)
```

## On Compaction

1. Run `/context-checkpoint`
2. Read CURRENT.md + ACTIONPLAN.md
3. Continue from current subtask
