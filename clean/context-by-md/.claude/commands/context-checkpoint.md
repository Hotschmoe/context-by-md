# Context Checkpoint

Save current state so the next session (or post-compaction continuation) can pick up seamlessly.

## When To Run

- End of session (automatically via Stop hook)
- Before long operations that might hit context limits
- When switching between major tasks
- Periodically during long sessions (~every 30 min of work)

## Instructions

### 1. Update CURRENT.md

```markdown
# Current Context

> **Last Updated:** [NOW - ISO timestamp]
> **Session:** [Brief description of what was happening]

## [*] Active Focus

[What we're ACTUALLY working on right now, not what we started with]

## [-] Immediate Next Steps

1. [Very next thing to do]
2. [Then this]
3. [Then this]

## [!] Critical Context

[Anything that would be LOST if not written down]
- Key decisions made this session
- Important constraints discovered
- State of work-in-progress

## [~] Key Resources

[Files currently relevant]

## [...] Session Notes

[Move existing notes to session log, add final notes here]
```

### 2. Update PLAN.md

- Check off completed subtasks
- Update task statuses ([READY]->[WIP]->[DONE] etc)
- Add any new tasks discovered
- Update "Blocked by" notes if blockers resolved

### 3. Update BACKLOG.md

- Add any bugs discovered
- Add any technical debt noticed
- Add any ideas that came up

### 4. Create Session Log (end of session only)

Create `.context-by-md/sessions/YYYY-MM-DD_HHMM.md` using template:

```markdown
# Session: [timestamp]

> **Duration:** ~X minutes
> **Focus:** [main work area]

## Summary
[2-3 sentences on what was accomplished]

## Work Completed
- [x] Thing done
- [ ] Thing started but not finished

## Decisions Made
[Any significant choices and rationale]

## Context for Next Session
[What's needed to continue]
```

### 5. Final Check

- [ ] CURRENT.md reflects actual current state
- [ ] PLAN.md tasks are accurate
- [ ] No lost context - everything important is written down
- [ ] Session log created (if ending session)

## On Compaction

If you're running this because of compaction warning:
1. Complete all steps above
2. Read CURRENT.md
3. Continue with the next step from "Immediate Next Steps"
