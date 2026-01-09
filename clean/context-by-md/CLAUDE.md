# Claude Instructions

## Context System

This project uses markdown context in `.context-by-md/`. **Run `/context-start` before work.**

### Commands
- `/context-start` - Read context, orient to current state
- `/context-checkpoint` - Save state (auto-prompted on stop)
- `/context-task start "X"` - Interview + plan task in ACTIONPLAN.md
- `/context-task` - Other ops: add, done, block, ready, decide, finish

### Key Files
| File | Purpose |
|------|---------|
| `CURRENT.md` | Session state, next steps |
| `PLAN.md` | Task list (terse) |
| `ACTIONPLAN.md` | Active task detail (interview, decomposition, decisions) |
| `BACKLOG.md` | Bugs, debt, ideas |

### Task Format (PLAN.md)
```markdown
- [WIP] P1: Task title | context | next: action
```
Status: `[READY]` `[WIP]` `[BLOCKED]` `[DONE]` | Priority: P0-P3

### Starting a Task
1. Pick task from PLAN.md
2. Run `/context-task start "Task name"`
3. Answer interview questions (goal, scope, constraints, steps)
4. Claude fills ACTIONPLAN.md with plan
5. Begin work on first concrete step

### During Work
- Update ACTIONPLAN.md subtasks as you complete them
- Use `/context-task decide` to record key decisions
- Use `/context-task checkpoint` to save progress
- Update CURRENT.md on `/context-checkpoint`

### Finishing a Task
Run `/context-task finish` to:
- Archive ACTIONPLAN.md to `archive/plans/`
- Mark task [DONE] in PLAN.md
- Clear ACTIONPLAN.md for next task

### On Compaction
1. Run `/context-checkpoint`
2. Read CURRENT.md + ACTIONPLAN.md
3. Continue from current subtask
