# Context Task Operations

Quick task management operations. Use natural language after the command.

## Usage Examples

```
/context-task add P1 bug: Login fails when password has special chars
/context-task done "Implement user auth"
/context-task block "API integration" waiting for credentials
/context-task ready "Database migration" 
/context-task find ready      # List all ready tasks
/context-task find blocked    # List all blocked tasks
```

## Operations

### Add New Task
Add to PLAN.md under current epic:
```markdown
### 🟢 P{priority}: {description}
**Added:** {timestamp}
**Notes:** {any context}
```

### Mark Done
In PLAN.md:
1. Change status to ✅
2. Move to "Completed This Sprint" section
3. Add completion date

### Block Task
In PLAN.md:
1. Change status to 🔴
2. Add/update "Blocked by:" line

### Unblock / Ready
In PLAN.md:
1. Change status to 🟢
2. Remove "Blocked by:" line

### Find Tasks
Scan PLAN.md and report matching tasks with their status.

## For Discovered Work

If discovering something during other work, add to BACKLOG.md instead:

```markdown
### [P{0-3}] {Bug|Debt|Feature}: {Description}
**Discovered:** {timestamp} during {what you were doing}
**File:** {path}:{line} (if applicable)
**Details:** {explanation}
```
