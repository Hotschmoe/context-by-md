# Markdown Context System

A lightweight context management system for Claude Code using plain markdown files.

## Philosophy

Achieve 80% of the value with 20% of the complexity:
- Plain markdown files (human-readable, git-friendly)
- Claude Code slash commands for context management
- Zero dependencies (no binaries, no daemons)

## Quick Start

### One-Line Install

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/hotschmoe/context-by-md/master/clean/context-by-md/install-remote.ps1 | iex
```

**Linux/macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/hotschmoe/context-by-md/master/clean/context-by-md/install-remote.sh | bash
```

### After Install

1. Edit `.context-by-md/CURRENT.md` with your project info
2. Add tasks to `PLAN.md`: `- [READY] P1: Task name | context | next: action`
3. Run `/context-start` then `/context-task start "Task name"`

## Directory Structure

```
.context-by-md/
├── CURRENT.md       # Session state, next steps, critical context
├── PLAN.md          # Task list (terse, one line per task)
├── ACTIONPLAN.md    # Active task detail (interview, decomposition, decisions)
├── BACKLOG.md       # Bugs, tech debt, ideas
├── sessions/        # Session logs (auto-generated)
└── archive/
    └── plans/       # Archived action plans

.claude/
├── commands/        # Slash commands
├── hooks/           # Auto-checkpoint on stop
└── settings.local.json
```

## Workflow

### Starting a Session
```
/context-start
```
Reads CURRENT.md, PLAN.md, orients to current state.

### Starting a Task
```
/context-task start "User authentication"
```

Claude runs an **interview**:
- What's the goal? What does "done" look like?
- What's explicitly OUT of scope?
- Any hard constraints?
- What don't we know yet? Risks?
- Main steps? First concrete action?

Answers are saved to **ACTIONPLAN.md** with:
- Goal & Definition of Done
- Scope (in/out)
- Constraints & Unknowns
- Decomposition (subtasks)
- Decision checkpoints

### During Work
- Subtasks checked off in ACTIONPLAN.md
- `/context-task decide "Question" | choice | rationale` - Record decisions
- `/context-task checkpoint` - Save progress
- `/context-checkpoint` - Full state save (also auto-runs on session stop)

### Finishing a Task
```
/context-task finish
```
Archives ACTIONPLAN.md, marks task [DONE] in PLAN.md, clears for next task.

## Task Format (PLAN.md)

Terse, one line per task:
```markdown
## Active Sprint

- [WIP] P1: User auth | JWT approach | next: session management
- [READY] P2: Rate limiting | token bucket | next: implement middleware
- [BLOCKED] P1: Payments | Stripe | waiting: API keys

## Task Notes

### User auth
Using JWT with 15min access + 7day refresh. Login endpoint done.
Decision: No OAuth for MVP.

## Done (This Sprint)

- [DONE] P1: Database schema | completed 01-07
```

**Status:** `[READY]` `[WIP]` `[BLOCKED]` `[DONE]` `[PAUSED]`

**Priority:** P0=Critical, P1=High, P2=Medium, P3=Low

## Commands Reference

| Command | Purpose |
|---------|---------|
| `/context-start` | Read context, orient to state |
| `/context-checkpoint` | Save all state (auto on stop) |
| `/context-task start "X"` | Interview + plan task |
| `/context-task add P1: X` | Add task to PLAN.md |
| `/context-task done X` | Mark task complete |
| `/context-task block X \| reason` | Mark blocked |
| `/context-task ready X` | Unblock task |
| `/context-task decide` | Record decision |
| `/context-task checkpoint` | Update ACTIONPLAN.md |
| `/context-task finish` | Archive + clear ACTIONPLAN.md |
| `/context-task find ready` | List ready tasks |

## File Purposes

### CURRENT.md - Session State
What Claude reads on compaction/session start:
- Active focus (1-3 items)
- Immediate next steps
- Critical context (decisions, constraints)
- Key resources

### PLAN.md - Task List (Terse)
One line per task, detailed notes in separate section:
- Active Sprint tasks
- Task Notes (2-3 lines per task needing detail)
- Done this sprint
- Archive tracking

### ACTIONPLAN.md - Active Task Detail
Only the current task gets full planning treatment:
- Interview results
- Decomposition into subtasks
- Decision log with rationale
- Checkpoints for key decisions

### BACKLOG.md - Discovered Work
Quick capture during sessions:
- `[BUG]` Bugs discovered
- `[DEBT]` Technical debt
- `[IDEA]` Future improvements

### sessions/*.md - Session Logs
Auto-generated history:
- Summary of work
- Decisions made
- Context for next session

## Archiving

- **Done tasks:** Weekly, move to `archive/done-YYYY-MM.md`
- **Action plans:** On task finish, move to `archive/plans/YYYY-MM-DD_task-name.md`

Keeps active files lean for minimal token usage.

## Hooks

Stop hook automatically reminds Claude to run `/context-checkpoint` when a session ends.

- **Windows:** PowerShell scripts in `.claude/hooks/`
- **Unix:** Bash scripts in `.claude/hooks/`

## Manual Install

1. Copy `clean/context-by-md/.context-by-md/` to your project root
2. Copy `clean/context-by-md/.claude/` to your project
3. Copy `clean/context-by-md/CLAUDE.md` to your project root (or append to existing)
4. Add to `.gitignore` (optional):
   ```
   .context-by-md/sessions/
   .context-by-md/archive/
   ```

## vs Beads

**What you lose:** Automated ready-work queries, hash-based IDs, formal dependency tracking, LLM summarization, multi-repo coordination, daemon sync.

**What you gain:** Zero dependencies, human-readable everything, works offline, easy to customize, meaningful git diffs, portable across AI tools.

**Use this for:** Solo/small team, simplicity over features, personal projects.

**Use beads for:** Large teams, multiple agents, formal dependencies, multi-repo.
