---
name: fix
description: Address issues found during code review. Implements fixes systematically with verification.
---
# Fix Command - Address Review Issues

## Purpose

Implement fixes for issues identified during code review, systematically addressing each problem with verification.

## When to Use

- After a review has identified issues
- When bugs are reported
- To address technical debt
- After security audit findings

## Instructions

When this command is invoked:

### Step 1: Gather Issues

1. Check for recent review report in `specs/reviews/`
2. If no review exists, ask user what to fix
3. Categorize issues by severity:
   - **Critical**: Security, data loss, crashes
   - **High**: Bugs, broken functionality
   - **Medium**: Code quality, maintainability
   - **Low**: Style, minor improvements

### Step 2: Plan Fixes

For each issue, determine:
1. Root cause of the problem
2. Files that need modification
3. Potential side effects
4. Testing approach

Create a fix plan:

```markdown
# Fix Plan

## Issues to Address

| # | Severity | Issue | File | Approach |
|---|----------|-------|------|----------|
| 1 | Critical | [Issue] | path/file.js | [How to fix] |
| 2 | High | [Issue] | path/file.js | [How to fix] |

## Order of Operations
1. Fix critical issues first
2. Run tests after each fix
3. Verify no regressions
```

### Step 3: Implement Fixes

For each fix:

1. **Announce** what you're fixing
2. **Show** the current problematic code
3. **Explain** what the fix does
4. **Apply** the fix
5. **Verify** the fix works

### Step 4: Verify

After all fixes:

1. Run all tests
2. Check for regressions
3. Verify each original issue is resolved
4. Document what was fixed

### Step 5: Report

Create a fix report:

```markdown
# Fix Report

**Date**: [Current date]
**Review Reference**: [Link to original review]

## Fixes Applied

### Fix 1: [Issue Title]
- **File**: path/to/file.js
- **Line**: XX → YY
- **Problem**: [What was wrong]
- **Solution**: [What was done]
- **Verification**: [How it was verified]

## Summary

| Category | Issues | Fixed | Remaining |
|----------|--------|-------|-----------|
| Critical | X | X | 0 |
| High | X | X | 0 |
| Medium | X | X | X |
| Low | X | X | X |

## Tests
- All tests passing: Yes/No
- New tests added: X
- Regressions found: None

## Next Steps
- [Any remaining work]
- [Suggested improvements]
```

Save to `specs/fixes/[date]-fix-report.md`

## Fix Principles

### DO:
- Fix one issue at a time
- Verify each fix before moving on
- Run tests frequently
- Keep fixes minimal and focused
- Document what you changed and why

### DON'T:
- Fix multiple issues in one change
- Make unrelated "improvements"
- Skip verification
- Assume the fix works without testing
- Ignore potential side effects

## Handling Complex Fixes

If a fix is complex:

1. **Isolate**: Create a minimal reproduction
2. **Understand**: Trace the root cause completely
3. **Design**: Plan the fix before coding
4. **Implement**: Make the smallest change that fixes the issue
5. **Test**: Verify with multiple test cases
6. **Review**: Consider if the fix introduces new issues

## Notes

- Always prioritize critical and security issues
- When in doubt, ask before making changes
- If a fix is too risky, discuss alternatives with user
- Consider delegating to the fixer agent for complex fixes
