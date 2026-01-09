# Action Plan

> **Last Updated:** 2026-01-08
> **Status:** [READY] Active

## Legend

| Symbol | Meaning |
|--------|---------|
| [DONE] | Done |
| [READY] | Ready (no blockers) |
| [WIP] | In Progress |
| [BLOCKED] | Blocked |
| [PAUSED] | Paused/Deferred |
| [ABANDONED] | Abandoned |

**Priority:** P0 = Critical, P1 = High, P2 = Medium, P3 = Low

---

## Active Epic: _[Epic Name]_

> **Goal:** _[What success looks like]_
> **Started:** _[Date]_

### [READY] P1: Task Name Here
<!-- Description of what needs to be done -->

- [ ] Subtask 1
- [ ] Subtask 2
- [ ] Subtask 3

**Notes:** _Any context, blockers, or decisions_

### [WIP] P2: Another Task
<!-- Currently being worked on -->

- [x] Completed subtask
- [ ] Remaining work

**Blocked by:** _Nothing_
**Notes:** _In progress as of session X_

### [BLOCKED] P1: Blocked Task
<!-- Cannot proceed until blocker resolved -->

- [ ] Waiting for something

**Blocked by:** Dependency on external API response
**Notes:** _Filed issue #123_

---

## Completed This Sprint

### [DONE] Task That's Done
- [x] All subtasks
- [x] Completed

**Completed:** 2026-01-07
**Notes:** _Brief summary of outcome_

---

## How To Use This File

**Claude maintains this file by:**
1. Moving tasks between status sections as work progresses
2. Checking off subtasks as they're completed
3. Adding new tasks discovered during work
4. Updating "Blocked by" notes when dependencies arise

**Finding ready work:**
1. Look for [READY] items (no blockers)
2. Sort by priority (P0 > P1 > P2 > P3)
3. Pick the highest priority ready item

**On session start:** Claude scans for [READY] items and continues highest priority.

**Dependency tracking:** Use "Blocked by:" notes. When blocker resolves, change [BLOCKED] to [READY].
