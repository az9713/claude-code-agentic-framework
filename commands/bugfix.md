---
name: bugfix
description: Structured bug investigation and fix workflow. Investigates, plans, fixes, tests, and verifies the resolution.
---
# Bugfix Command - Bug Investigation and Fix Workflow

## Purpose

Systematically investigate, fix, and verify bug resolutions. This command provides a structured approach to debugging that prevents quick-fix thinking and ensures proper root cause analysis.

## When to Use

- Reported bugs from users or testing
- Unexpected behavior discovered
- Test failures
- Production issues
- Regression bugs

## Syntax

```
/bugfix [bug description]
/bugfix --issue [issue-number]  # Reference GitHub/Jira issue
/bugfix --regression [feature]  # Known regression
```

## Instructions

When this command is invoked:

### Phase 1: Intake

Gather bug information:

```markdown
# Bug Report

## Description
[What's happening]

## Expected Behavior
[What should happen]

## Actual Behavior
[What is happening]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Observe bug]

## Environment
- [Browser/OS/Version]
- [Relevant configuration]

## Severity
- [ ] Critical: System unusable
- [ ] High: Major feature broken
- [ ] Medium: Feature impaired
- [ ] Low: Minor inconvenience
```

### Phase 2: Investigate

**Delegate to**: reviewer agent (investigation mode)

```
┌─────────────────────────────────────┐
│        INVESTIGATION PHASE          │
├─────────────────────────────────────┤
│ 1. Reproduce the bug                │
│ 2. Locate affected code             │
│ 3. Trace execution path             │
│ 4. Identify root cause              │
│ 5. Document findings                │
└─────────────────────────────────────┘
```

Investigation checklist:
- [ ] Can reproduce consistently
- [ ] Located the failing code
- [ ] Understood the root cause
- [ ] Identified all affected areas
- [ ] Checked for related issues

**Output**: Investigation report

### Phase 3: Plan Fix

**Delegate to**: planner agent

```markdown
# Fix Plan

## Root Cause
[Clear explanation of why the bug occurs]

## Fix Approach
[How we'll fix it]

## Files to Modify
- `path/to/file.js` - [Change description]

## Risk Assessment
- Scope of change: [Small/Medium/Large]
- Regression risk: [Low/Medium/High]
- Areas to test: [List]

## Test Plan
- [ ] Test original bug is fixed
- [ ] Test related functionality
- [ ] Test edge cases
```

**Gate**: User approves fix approach

### Phase 4: Implement Fix

**Delegate to**: fixer agent

```
┌─────────────────────────────────────┐
│          FIX PHASE                  │
├─────────────────────────────────────┤
│ 1. Create regression test first     │
│ 2. Implement minimal fix            │
│ 3. Verify test now passes           │
│ 4. Check for side effects           │
│ 5. Document the fix                 │
└─────────────────────────────────────┘
```

Key principle: **Test first, then fix**

1. Write a test that reproduces the bug (should fail)
2. Implement the fix
3. Verify the test passes
4. Verify other tests still pass

### Phase 5: Verify

**Delegate to**: reviewer agent

Verification checklist:
- [ ] Original bug is fixed
- [ ] Regression test added
- [ ] No new bugs introduced
- [ ] All tests passing
- [ ] Code quality maintained

### Phase 6: Complete

```markdown
# Bug Fix Complete

## Bug
[Original description]

## Root Cause
[What caused it]

## Fix Applied
- File: `path/to/file.js`
- Change: [Description]

## Tests Added
- `test/unit/file.test.js`
  - "should handle [edge case]"

## Verification
- [x] Original bug fixed
- [x] Regression test passes
- [x] All tests pass
- [x] No new issues

## Commit
```bash
git commit -m "fix: [bug description]

Fixes #[issue-number]

Root cause: [brief explanation]
Solution: [brief solution]"
```
```

## Investigation Techniques

### Log Analysis
```javascript
// Add targeted logging
console.log('[DEBUG]', { variable, state, input });
```

### Trace Execution
```
Start → Function A → Function B → Bug occurs
                          ↑
                    Root cause here
```

### Binary Search
```
If bug exists in current version:
1. Check if exists in version from 1 week ago
2. Narrow down to specific commit
3. Identify exact change that introduced bug
```

### Input Isolation
```
Test with:
- Minimal input → Works?
- Add one element → Works?
- Add another → Bug!
   ↑ This input triggers the bug
```

## Common Bug Patterns

### Off-by-One
```javascript
// Bug
for (let i = 0; i <= items.length; i++)

// Fix
for (let i = 0; i < items.length; i++)
```

### Null Reference
```javascript
// Bug
const name = user.profile.name;

// Fix
const name = user?.profile?.name ?? 'Unknown';
```

### Race Condition
```javascript
// Bug
let data = await fetch();
process(data); // data might not be ready

// Fix
const data = await fetch();
if (data) {
  process(data);
}
```

### State Mutation
```javascript
// Bug
items.push(newItem); // Mutates original

// Fix
const newItems = [...items, newItem];
```

## Example Execution

```
User: /bugfix Users can't log in after password change

> Starting Bug Investigation

## Phase 1: Intake
Bug: Login fails after password change
Expected: User can log in with new password
Actual: Login returns "Invalid credentials"
Severity: High

## Phase 2: Investigate
[reviewer agent - investigation mode]

Findings:
- Reproduction: Change password, try login → Fails
- Location: app/services/authService.js
- Root cause: Password hash not being saved to database
  - Line 45: `await user.save()` is missing after hash update
- Related: Only affects password change, not initial registration

## Phase 3: Plan
Fix approach:
1. Add `await user.save()` after password hash update
2. Add test for password change flow
3. Verify with existing tests

Risk: Low (isolated change)

> Approve fix? (y/n)

User: y

## Phase 4: Implement
[fixer agent]

1. Created test:
   tests/integration/passwordChange.test.js
   - "should allow login after password change"
   - Currently FAILING (as expected)

2. Applied fix:
   app/services/authService.js:45
   Added: await user.save();

3. Test now PASSING

## Phase 5: Verify
[reviewer agent]
- [x] Bug is fixed
- [x] Regression test added
- [x] All 42 tests passing
- [x] No side effects found

## Phase 6: Complete

Bug Fixed: Login after password change ✓

Commit:
git commit -m "fix: save password hash after change

Fixes #234

Root cause: user.save() was missing after password update
Solution: Added await user.save() after hash update"
```

## Notes

- Always reproduce before fixing
- Understand the root cause, not just symptoms
- Write regression test first
- Make minimal, focused fixes
- Verify thoroughly before closing
- Document for future reference
