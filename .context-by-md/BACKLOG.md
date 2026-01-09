# Backlog

> **Last Updated:** 2026-01-08

Work discovered during sessions, future improvements, and ideas. Claude adds to this
when noticing issues that aren't immediately actionable.

---

## [BUG] Bugs & Issues

<!-- Things that are broken but not blocking current work -->

_None discovered yet._

<!-- Example format:
### [P2] Bug: Description
**Discovered:** 2026-01-08 during session on feature X
**File:** path/to/file.py:123
**Details:** What's broken and how it manifests
**Suggested fix:** If known
-->

---

## [DEBT] Technical Debt

<!-- Code that works but should be improved -->

_None identified yet._

<!-- Example format:
### [P3] Refactor: Component Name
**Why:** Current implementation has issues with X
**Impact:** Low - works but slow/ugly/fragile
**Effort:** Medium - 2-4 hours
**Notes:** Consider during next related work
-->

---

## [NEW] Future Improvements

<!-- Nice-to-haves, enhancements, ideas -->

_None yet._

<!-- Example format:
### [P3] Feature: Description
**Value:** What problem this solves
**Effort:** Rough estimate
**Dependencies:** What needs to exist first
-->

---

## [IDEA] Ideas & Notes

<!-- Unstructured thoughts to revisit later -->

_Empty._

---

## Promoted to PLAN.md

<!-- Track what's been moved to active work -->

| Date | Item | Promoted To |
|------|------|-------------|
| _none yet_ | | |

---

## How This File Works

**Claude adds items here when:**
- Discovering bugs during other work
- Noticing code that should be refactored
- Having ideas for improvements
- Finding TODOs in code that need tracking

**Format for new items:**
```markdown
### [P{0-3}] {Type}: {Brief Description}
**Discovered:** {Date} during {context}
**File:** {path}:{line} (if applicable)
**Details:** {What and why}
```

**Promoting to active work:**
1. Copy item to PLAN.md under appropriate epic
2. Add entry to "Promoted to PLAN.md" table
3. Remove from this file

**Review cadence:** Check this file at session end to see if anything should be promoted.
