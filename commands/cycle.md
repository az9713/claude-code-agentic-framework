---
name: cycle
description: Execute the complete Plan-Build-Review-Fix development cycle for a feature or change. The core workflow of the framework.
---
# Cycle Command - Complete Development Cycle

## Purpose

Execute the complete Plan-Build-Review-Fix cycle, the core workflow of the Codebase Singularity framework. This command orchestrates all phases of development into a cohesive workflow.

## When to Use

- Implementing a new feature end-to-end
- Making significant changes that need full workflow
- When you want automated quality assurance
- For complete development lifecycle management

## Syntax

```
/cycle [feature description]
/cycle --quick [feature]    # Skip deep review
/cycle --thorough [feature] # Deep review + security
```

## Instructions

When this command is invoked:

### Pre-Flight Check

1. Run `/prime` if not already primed
2. Verify CLAUDE.md is loaded
3. Check for any pending work in specs/
4. Confirm feature description with user

### Phase 1: PLAN

**Delegate to**: planner agent

```
┌─────────────────────────────────────┐
│           PLANNING PHASE            │
├─────────────────────────────────────┤
│ 1. Analyze requirements             │
│ 2. Review existing code             │
│ 3. Research solutions (if needed)   │
│ 4. Design architecture              │
│ 5. Create implementation plan       │
│ 6. Get user approval                │
└─────────────────────────────────────┘
```

**Output**: `specs/[feature]-plan.md`

**Gate**: User must approve plan before continuing

### Phase 2: BUILD

**Delegate to**: builder agent

```
┌─────────────────────────────────────┐
│           BUILDING PHASE            │
├─────────────────────────────────────┤
│ 1. Read approved plan               │
│ 2. Create/modify files              │
│ 3. Implement core logic             │
│ 4. Add error handling               │
│ 5. Show progress to user            │
│ 6. Create basic tests               │
└─────────────────────────────────────┘
```

**Output**: Working code + tests

**Gate**: All files created, no syntax errors

### Phase 3: REVIEW

**Delegate to**: reviewer agent

```
┌─────────────────────────────────────┐
│           REVIEW PHASE              │
├─────────────────────────────────────┤
│ 1. Check code quality               │
│ 2. Verify logic correctness         │
│ 3. Security analysis                │
│ 4. Performance check                │
│ 5. Test coverage check              │
│ 6. Generate review report           │
└─────────────────────────────────────┘
```

**Output**: `specs/reviews/[date]-review.md`

**Gate**: Score ≥ 7/10 to proceed, else fix

### Phase 4: FIX (if needed)

**Delegate to**: fixer agent

```
┌─────────────────────────────────────┐
│            FIX PHASE                │
├─────────────────────────────────────┤
│ 1. Read review findings             │
│ 2. Prioritize issues                │
│ 3. Fix each issue                   │
│ 4. Verify fixes                     │
│ 5. Re-run affected tests            │
│ 6. Report completion                │
└─────────────────────────────────────┘
```

**Output**: Fixed code + fix report

**Loop**: Return to Review if issues remain

### Completion

After all phases complete:

```markdown
# Cycle Complete

## Summary
- **Feature**: [Feature name]
- **Duration**: [Total time]
- **Iterations**: [Review-Fix loops]

## Files Changed
### Created
- `path/to/new-file.js` (XX lines)

### Modified
- `path/to/existing.js` (X changes)

## Quality Report
| Metric | Score |
|--------|-------|
| Code Quality | X/10 |
| Security | X/10 |
| Test Coverage | X% |
| Overall | X/10 |

## What's Next
1. Run tests: `npm test`
2. Manual testing: [Suggested scenarios]
3. Commit: `git commit -m "feat: [feature]"`
4. Deploy: [If applicable]
```

## Cycle Options

### Standard Cycle (default)
- Full planning phase
- Standard review
- One review-fix iteration

### Quick Cycle (`--quick`)
- Brief planning
- Quick review (critical issues only)
- Skip minor issues

### Thorough Cycle (`--thorough`)
- Comprehensive planning
- Deep review
- Security audit
- Multiple iterations until perfect

## Error Handling

### Plan Rejected
- Ask user for clarification
- Revise plan
- Present again

### Build Fails
- Diagnose issue
- Attempt fix
- If blocked, ask user

### Review Score < 7
- Automatic fix phase
- Re-review after fixes
- Max 3 iterations before asking user

### Unrecoverable Error
- Save current state
- Present error to user
- Suggest recovery options

## Example Execution

```
User: /cycle Add user authentication with JWT

> Starting Cycle: User Authentication

## Phase 1: Planning
[Planner agent works...]
Plan created: specs/user-auth-plan.md
> Do you approve this plan? (y/n)

User: y

## Phase 2: Building
[Builder agent works...]
Created: app/middleware/auth.js
Created: app/routes/authRoutes.js
Created: tests/unit/auth.test.js
Build complete!

## Phase 3: Review
[Reviewer agent works...]
Review Score: 6/10
Issues found: 3 (1 High, 2 Medium)

## Phase 4: Fix
[Fixer agent works...]
Fixed: Issue 1/3 - Input validation
Fixed: Issue 2/3 - Error handling
Fixed: Issue 3/3 - Token expiry

## Phase 3: Review (Iteration 2)
Review Score: 9/10
Issues found: 0

# Cycle Complete!
Feature: User Authentication
Files: 3 created, 1 modified
Quality: 9/10

Ready to commit?
```

## Notes

- Each phase builds on the previous
- User can intervene at any gate
- Progress is saved in specs/ for recovery
- Supports partial execution (start from any phase)
- Consider using orchestrator for complex features
