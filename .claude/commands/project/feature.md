---
name: feature
description: Complete feature development workflow from specification to tested, reviewed code ready for commit.
---
# Feature Command - Feature Development Workflow

## Purpose

Implement a complete feature from start to finish, including research, planning, implementation, testing, review, and preparation for commit. This is a high-level workflow command that coordinates multiple agents.

## When to Use

- Starting a new feature
- Implementing a user story
- Adding significant new functionality
- When you want a guided development experience

## Syntax

```
/project:feature [feature description]
/project:feature --with-docs [feature]     # Include documentation
/project:feature --with-security [feature] # Include security audit
```

## Instructions

When this command is invoked:

### Step 0: Initialize

1. Run `/project:prime` if needed
2. Confirm feature scope with user
3. Create feature tracking in specs/

### Step 1: Research (Optional)

**Delegate to**: doc-fetcher agent

```
Questions to answer:
- What libraries/patterns are needed?
- Are there existing implementations to reference?
- What are the best practices?
```

**Skip if**: Feature is well-understood

**Output**: `ai_docs/[feature]-research.md`

### Step 2: Specification

Create or confirm feature specification:

```markdown
# Feature: [Name]

## User Story
As a [user type], I want [action] so that [benefit].

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Technical Requirements
- [Requirement 1]
- [Requirement 2]

## Out of Scope
- [Exclusion 1]
```

**Gate**: User confirms specification

### Step 3: Plan

**Delegate to**: planner agent

Create detailed implementation plan covering:
- Architecture decisions
- Files to create/modify
- Step-by-step implementation
- Testing strategy

**Output**: `specs/[feature]-plan.md`

**Gate**: User approves plan

### Step 4: Implement

**Delegate to**: builder agent

Follow the plan to:
- Create new files
- Modify existing files
- Implement core logic
- Add error handling

**Output**: Working code

### Step 5: Test

**Delegate to**: test-writer agent

Create comprehensive tests:
- Unit tests for new functions
- Integration tests for flows
- Edge case coverage
- Error handling tests

**Output**: Test files

### Step 6: Review

**Delegate to**: reviewer agent

Perform quality review:
- Code quality check
- Logic verification
- Performance check
- Standard review checklist

**Output**: `specs/reviews/[date]-[feature]-review.md`

### Step 7: Fix

**Delegate to**: fixer agent

If review score < 7:
- Address findings
- Verify fixes
- Re-review

**Loop until**: Score ≥ 7

### Step 8: Security (if --with-security)

**Delegate to**: security-auditor agent

Security audit:
- OWASP Top 10 check
- Input validation
- Authentication/authorization
- Data protection

**Output**: Security report

### Step 9: Documentation (if --with-docs)

Update documentation:
- API documentation
- README updates
- Inline code comments
- Usage examples

### Step 10: Finalize

Prepare for commit:

```markdown
# Feature Complete: [Name]

## Summary
[Brief description of what was implemented]

## Files Changed
### New Files
- `path/file.js` - [Description]

### Modified Files
- `path/file.js` - [Changes]

## Tests
- X new tests added
- All tests passing

## Quality Scores
| Area | Score |
|------|-------|
| Code Quality | X/10 |
| Security | X/10 |
| Coverage | X% |

## Commit Suggestion
```bash
git add .
git commit -m "feat: [feature description]"
```

## Manual Testing
Please verify:
1. [Test scenario 1]
2. [Test scenario 2]
```

## Feature Workflow Diagram

```
┌─────────┐   ┌──────────┐   ┌────────┐
│Research │──►│  Specify │──►│  Plan  │
└─────────┘   └──────────┘   └───┬────┘
                                 │
                                 ▼
              ┌──────────────────────────────────┐
              │           IMPLEMENT               │
              │  builder → test-writer → review   │
              └────────────────┬─────────────────┘
                               │
                    ┌──────────┴──────────┐
                    ▼                      ▼
              ┌──────────┐          ┌──────────┐
              │ Security │          │   Docs   │
              │  (opt)   │          │  (opt)   │
              └────┬─────┘          └────┬─────┘
                   │                     │
                   └──────────┬──────────┘
                              ▼
                        ┌──────────┐
                        │ Finalize │
                        └──────────┘
```

## Example Execution

```
User: /project:feature --with-docs Add password reset functionality

> Starting Feature: Password Reset

## Step 1: Research
[doc-fetcher agent]
Fetched: Password reset best practices
Fetched: JWT token patterns for reset links
Research saved to: ai_docs/password-reset-research.md

## Step 2: Specification
Created specification:
- User requests password reset via email
- System sends reset link (expires in 1 hour)
- User clicks link, enters new password
- System updates password, invalidates link

> Does this match your requirements? (y/n)

User: y

## Step 3: Plan
[planner agent]
Plan created: specs/password-reset-plan.md
- Create reset token table/collection
- Add reset request endpoint
- Add reset confirmation endpoint
- Add email sending functionality
- Add tests

> Approve plan? (y/n)

User: y

## Step 4: Implement
[builder agent]
Created: app/routes/resetRoutes.js
Created: app/services/resetService.js
Created: app/email/resetEmail.js
Modified: app/models/User.js

## Step 5: Test
[test-writer agent]
Created: tests/unit/resetService.test.js
Created: tests/integration/reset.test.js
Tests: 12 written, 12 passing

## Step 6: Review
[reviewer agent]
Score: 8/10
Minor issues: 2 (both Low severity)

## Step 9: Documentation
Updated: README.md (API endpoints)
Created: docs/password-reset.md

## Step 10: Complete
Feature: Password Reset ✓
Files: 4 new, 2 modified
Tests: 12 passing
Score: 8/10

Ready to commit:
git commit -m "feat: add password reset functionality"
```

## Notes

- Feature command provides guided, comprehensive workflow
- Each step is explicit and can be reviewed
- Optional steps (security, docs) add thoroughness
- Consider for medium-to-large features
- For simple changes, use `/project:cycle` instead
