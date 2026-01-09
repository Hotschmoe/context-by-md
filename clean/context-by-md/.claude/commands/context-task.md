# Context Task

Quick task operations and action planning.

## Usage
```
/context-task start User auth          # Interview + plan active task
/context-task add P1: User auth | JWT  # Add to PLAN.md
/context-task done User auth           # Mark complete
/context-task block Payments | waiting: API keys
/context-task ready Payments
/context-task decide "Use JWT vs sessions" | chose JWT | stateless, simpler
/context-task checkpoint               # Record progress in ACTIONPLAN.md
/context-task finish                   # Archive ACTIONPLAN.md, mark done
/context-task find ready
```

---

## Start Task (Interview Flow)

When user runs `/context-task start "Task name"`:

### 1. Update ACTIONPLAN.md Header
```markdown
> **Task:** Task name | **Started:** YYYY-MM-DD | **Status:** Planning
```

### 2. Run Interview (ask user these questions)

**Goal & Scope:**
- What's the goal? What does "done" look like?
- What's explicitly OUT of scope?
- Any hard constraints? (tech, time, dependencies)

**Unknowns:**
- What don't we know yet? Any risks?
- External dependencies or blockers?

**Decomposition:**
- Can you describe the main steps?
- What's the very first concrete action?

### 3. Record Answers in ACTIONPLAN.md

Fill in sections:
- Goal & Definition of Done
- Scope (in/out)
- Constraints
- Unknowns & Risks
- Decomposition (subtasks)
- First concrete step

### 4. Identify Checkpoints

Based on interview, add decision checkpoints:
```markdown
## Checkpoints
- [ ] **After auth design:** JWT or sessions? Refresh token strategy?
- [ ] **After basic login works:** Add OAuth or ship MVP first?
```

### 5. Update PLAN.md

Change task status: `[READY]` → `[WIP]`

### 6. Confirm Ready

Tell user: "Ready to start. First step: [X]. Proceed?"

---

## Other Operations

### Add Task
Add to PLAN.md "Active Sprint":
```markdown
- [READY] P#: Title | context | next: action
```

### Mark Done
1. `[WIP]` → `[DONE]` in PLAN.md
2. Move to "Done (This Sprint)"

### Block / Ready
Update status and blocker in PLAN.md

### Decide (during work)
Add to ACTIONPLAN.md Decisions table:
```markdown
| Use JWT vs sessions | JWT | Stateless, simpler scaling | 01-09 |
```

### Checkpoint (during work)
Update ACTIONPLAN.md:
- Check off completed subtasks
- Add any new decisions
- Note current state in Interview Log section

### Finish Task
1. Archive ACTIONPLAN.md to `.context-by-md/archive/plans/YYYY-MM-DD_task-name.md`
2. Reset ACTIONPLAN.md to blank template:
```markdown
# Action Plan

> **Task:** _none active_ | **Started:** — | **Status:** —

_Run `/context-task start "Task name"` to begin planning._

---

## Goal & Definition of Done
_Not yet defined._

## Scope
**In scope:**
- _item_

**Out of scope:**
- _item_

## Constraints
- _none identified_

## Unknowns & Risks
- _none identified_

---

## Decomposition
- [ ] _subtask 1_

**First concrete step:** _what to do right now_

---

## Decisions
| Decision | Choice | Rationale | Date |
|----------|--------|-----------|------|

## Checkpoints
- [ ] **Checkpoint:** _description_ | **Question:** _what to decide_

---

## Interview Log
_No interview conducted yet._
```
3. Mark task [DONE] in PLAN.md
4. Move to "Done (This Sprint)"

### Find Tasks
Scan PLAN.md, report matching by status

---

## For Discovered Work

Add to BACKLOG.md (not PLAN.md):
```markdown
- [BUG] P#: Description | file:line | details
- [DEBT] P#: Description | why | impact
- [IDEA] Description | value
```
