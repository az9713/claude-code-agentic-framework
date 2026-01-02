# Review Command - Code Quality Review

## Purpose

Review code for quality, bugs, security issues, and adherence to best practices.

## When to Use

- After implementing a feature
- Before committing changes
- When troubleshooting issues
- Periodically for quality assurance

## Instructions

When this command is invoked:

### Step 1: Determine Scope

Ask user (if not specified):
- "What should I review? All recent changes, specific files, or the whole project?"

Options:
1. **Recent changes**: Review what was modified today
2. **Specific files**: Review named files only
3. **Whole project**: Review everything in `app/` and `tests/`

### Step 2: Perform Review

For each file, check:

#### Code Quality
- [ ] Code is readable and self-documenting
- [ ] Functions are small and focused
- [ ] Variable names are descriptive
- [ ] No unnecessary complexity
- [ ] Consistent formatting and style

#### Error Handling
- [ ] All error cases are handled
- [ ] Error messages are helpful
- [ ] No silent failures
- [ ] Input validation present

#### Security
- [ ] No hardcoded credentials
- [ ] Input is sanitized
- [ ] No SQL/command injection risks
- [ ] Sensitive data is protected

#### Best Practices
- [ ] Follows project conventions
- [ ] No code duplication
- [ ] Proper use of data structures
- [ ] Efficient algorithms

#### Testing
- [ ] Tests exist for the code
- [ ] Tests cover edge cases
- [ ] Tests are maintainable

### Step 3: Generate Report

Create a report in this format:

```markdown
# Code Review Report

**Date**: [Current date]
**Scope**: [What was reviewed]
**Reviewer**: Claude AI

## Summary

| Category | Score | Issues |
|----------|-------|--------|
| Code Quality | X/10 | N issues |
| Error Handling | X/10 | N issues |
| Security | X/10 | N issues |
| Best Practices | X/10 | N issues |
| Testing | X/10 | N issues |

**Overall Score**: X/10

## Critical Issues (Fix Immediately)

### Issue 1: [Title]
- **File**: path/to/file.js
- **Line**: XX
- **Problem**: [Description]
- **Solution**: [How to fix]

## Warnings (Should Fix)

### Warning 1: [Title]
- **File**: path/to/file.js
- **Problem**: [Description]
- **Suggestion**: [How to improve]

## Suggestions (Nice to Have)

- [Suggestion 1]
- [Suggestion 2]

## What's Good

- [Positive observation 1]
- [Positive observation 2]
```

### Step 4: Present Options

After the review, offer:
1. "Would you like me to fix the critical issues?"
2. "Would you like detailed explanations for any issue?"
3. "Should I save this report to a file?"

## Review Depth Levels

### Quick Review (default)
- Scan for obvious issues
- Check for critical bugs
- Takes 1-2 minutes

### Thorough Review
- Line-by-line analysis
- Full security audit
- Performance considerations
- Takes 5-10 minutes

### Deep Dive
- Architecture review
- Alternative approaches
- Comprehensive documentation
- Takes 15+ minutes

User can specify: "Do a thorough review" or "Quick scan is fine"

## Notes

- Be constructive, not harsh
- Explain why something is an issue
- Always provide solutions with problems
- Acknowledge good code too
