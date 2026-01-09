# Context Checkpoint

Save current state for session continuity and compaction recovery.

## When To Run
- End of session (auto-prompted by Stop hook)
- Before long operations that might hit context limits
- When switching major tasks
- Every ~30 min during long sessions

## Quick Checkpoint

### 1. Update CURRENT.md
```markdown
> **Last Updated:** [NOW] | **Session:** [brief description]

## [*] Active Focus
[What you're working on NOW - 1-3 items]

## [-] Immediate Next Steps
1. [Very next action]
2. [Then this]

## [!] Critical Context
[Decisions, constraints, WIP state - things that would be LOST]

## [~] Key Resources
[Currently relevant files/links]
```

### 2. Update ACTIONPLAN.md (if task active)
- Check off completed subtasks
- Add any decisions to Decisions table
- Update status if needed

### 3. Update PLAN.md
- Update task statuses: `[READY]`→`[WIP]`→`[DONE]`
- Move completed to "Done (This Sprint)"

### 4. Update BACKLOG.md
Add any discovered bugs/debt/ideas

---

## End of Session (add these)

### 5. Create Session Log
`.context-by-md/sessions/YYYY-MM-DD_HHMM.md`:
```markdown
# Session: [timestamp]
> **Duration:** ~Xmin | **Focus:** [main work]

## Summary
[2-3 sentences]

## Completed
- Task 1

## Decisions
- [Decision]: [rationale]

## Next Session
[What to continue]
```

### 6. Archive Check
**Done tasks (weekly):** If 5+ in "Done (This Sprint)":
→ Move to `archive/done-YYYY-MM.md`

**Action plans:** Only archive via `/context-task finish` when task completes

---

## On Compaction
1. Run this checkpoint
2. Read CURRENT.md + ACTIONPLAN.md (if active)
3. Continue from "Immediate Next Steps" / current subtask
