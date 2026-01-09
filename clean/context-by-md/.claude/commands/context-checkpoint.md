# Context Checkpoint

Save current state for session continuity and compaction recovery.

## When To Run
- End of session (auto-prompted by Stop hook)
- Before long operations that might hit context limits
- When switching tasks
- Every ~30 min during long sessions

## Steps

### 1. Update CURRENT.md

```markdown
> **Last Updated:** [NOW] | **Active Task:** [task name or _none_]

## Now
[What you're working on - 1-3 items]

## Next Steps
1. [Very next action]
2. [Then this]

## Active Task
**Task:** [name] | **Status:** [WIP/Planning] | **Started:** [date]

### Goal
[What done looks like]

### Subtasks
- [x] Completed step
- [ ] Current step  <-- you are here
- [ ] Next step

### Decisions
| Decision | Choice | Why | Date |
|----------|--------|-----|------|
| [topic] | [choice] | [reason] | [date] |

## Context
[Key files, blockers, critical info]

## Notes
[Scratch space]
```

### 2. Update PLAN.md

- Update task status: `[READY]` → `[WIP]`
- Add any discovered bugs/debt/ideas to Backlog section

## On Compaction

1. Run checkpoint
2. Read CURRENT.md
3. Continue from Next Steps / current subtask
