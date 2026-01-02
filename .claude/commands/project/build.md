---
name: build
description: Implement features following an approved plan or specification. Creates code, tests, and documentation.
---
# Build Command - Implement Features

## Purpose

Implement features or changes, either from a plan or from a direct request.

## When to Use

- After a plan has been created and approved
- For small, straightforward implementations
- When building new functionality

## Instructions

When this command is invoked:

### Step 1: Identify What to Build

1. Check if there's a recent plan in `specs/`
2. If no plan exists, clarify requirements with user
3. Understand the scope of work
4. Identify dependencies

### Step 2: Review Standards

Before writing code:
1. Read the coding standards in `CLAUDE.md`
2. Look at existing code patterns in `app/`
3. Ensure consistency with project style
4. Note any required testing patterns

### Step 3: Implement

For each piece of work:

1. **Create/modify files** following this order:
   - Core logic files first
   - Utility/helper files second
   - Configuration files third
   - Tests last

2. **Per file, follow this pattern**:
   - Add imports at top
   - Add any necessary comments
   - Implement the logic
   - Export what needs to be exported

3. **Show progress**:
   - Show each file change to user
   - Wait for approval before continuing
   - Explain what each change does

### Step 4: Write Tests

For each new function or module:
1. Create corresponding test file
2. Cover happy path
3. Cover edge cases
4. Cover error conditions

### Step 5: Verify

After implementation:
1. List all files created/modified
2. Summarize what was done
3. Run tests if available
4. Suggest next steps (review, documentation)

## Implementation Principles

### DO:
- Follow existing patterns in the codebase
- Write self-documenting code
- Handle errors gracefully
- Keep functions small and focused
- Add appropriate input validation
- Write tests alongside implementation

### DON'T:
- Over-engineer simple solutions
- Add unnecessary dependencies
- Ignore existing conventions
- Skip error handling
- Create overly complex abstractions
- Leave code without tests

## Example Output

After building:

```
Implementation Complete!

Files Created:
- app/utils/newHelper.js (45 lines)
- tests/unit/newHelper.test.js (30 lines)

Files Modified:
- app/index.js (added import)

Summary:
Created the newHelper utility function with full error handling
and comprehensive tests covering all edge cases.

Next Steps:
1. Run tests: node tests/run.js
2. Review changes: /review
3. Commit if satisfied: git add . && git commit
```

## Notes

- Always ask for approval before creating/modifying files
- Explain why you made specific implementation choices
- If something is unclear, ask rather than assume
- Consider delegating to the builder agent for complex implementations
