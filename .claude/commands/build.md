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

### Step 2: Review Standards

Before writing code:
1. Read the coding standards in `CLAUDE.md`
2. Look at existing code patterns in `app/`
3. Ensure consistency with project style

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

### Step 4: Verify

After implementation:
1. List all files created/modified
2. Summarize what was done
3. Suggest next steps (testing, documentation)

## Implementation Principles

### DO:
- Follow existing patterns in the codebase
- Write self-documenting code
- Handle errors gracefully
- Keep functions small and focused
- Add appropriate input validation

### DON'T:
- Over-engineer simple solutions
- Add unnecessary dependencies
- Ignore existing conventions
- Skip error handling
- Create overly complex abstractions

## Example Output

After building:

```
Implementation Complete!

Files Created:
- app/utils/newHelper.js (45 lines)
- tests/newHelper.test.js (30 lines)

Files Modified:
- app/index.js (added import)

Summary:
Created the newHelper utility function with full error handling
and comprehensive tests covering all edge cases.

Next Steps:
1. Run tests to verify: node tests/run.js
2. Review changes: /project:review
```

## Notes

- Always ask for approval before creating/modifying files
- Explain why you made specific implementation choices
- If something is unclear, ask rather than assume
