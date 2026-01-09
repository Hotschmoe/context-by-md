# Claude Instructions

## Context System

This project uses a markdown-based context system in `.context-by-md/` instead of beads.

### On Session Start

**ALWAYS** run `/context-start` before doing any work. This ensures you:
1. Know what we were working on
2. Understand the current state
3. Can continue from where we left off

### During Work

1. **Update CURRENT.md** periodically with session notes
2. **Update PLAN.md** when completing tasks or discovering blockers
3. **Add to BACKLOG.md** when you notice bugs or improvements not related to current work
4. Run `/context-checkpoint` before long operations

### On Session End

Run `/context-checkpoint` which will:
1. Update all context files with final state
2. Create a session log
3. Ensure nothing is lost

### Key Files

| File | Purpose | When to Update |
|------|---------|----------------|
| `.context-by-md/CURRENT.md` | Active work state | Every checkpoint |
| `.context-by-md/PLAN.md` | Task tracking | When tasks change status |
| `.context-by-md/BACKLOG.md` | Future work | When discovering issues |
| `.context-by-md/sessions/*.md` | History | End of session |

### Quick Reference

```
/context-start      # Begin session, read context
/context-checkpoint # Save state (auto-runs on stop)
/context-task       # Quick task operations
```

### On Compaction

When you see a compaction warning:
1. Run `/context-checkpoint` to save state
2. Read `.context-by-md/CURRENT.md` 
3. Continue with the next step listed there

This ensures you can work across context window limits seamlessly.
