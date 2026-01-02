---
name: plan
description: Create a detailed implementation plan before coding any feature. Planning first leads to better code.
---
# Plan Command - Create Implementation Plans

## Purpose

Create a detailed plan before implementing any feature or change. Planning first leads to better code.

## When to Use

- Before implementing a new feature
- Before making significant changes
- When the task has multiple steps
- When you want to think through the approach

## Instructions

When this command is invoked with a task description:

### Step 1: Understand Requirements

1. Clarify the user's request
2. Identify what problem is being solved
3. Note any constraints or preferences mentioned
4. Ask clarifying questions if needed

### Step 2: Analyze Existing Code

1. Look at relevant existing files
2. Identify patterns to follow
3. Note any code that will be affected
4. Check for similar implementations to reference

### Step 3: Create the Plan

Structure the plan as follows:

```markdown
# Implementation Plan: [Feature Name]

## Overview
[2-3 sentences describing what will be built]

## Requirements
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

## Affected Files
| File | Action | Description |
|------|--------|-------------|
| path/to/file.js | Create | [what this file does] |
| path/to/other.js | Modify | [what changes] |

## Implementation Steps
1. [Step 1 with detail]
2. [Step 2 with detail]
3. [Step 3 with detail]

## Testing Strategy
- [How to test this feature]
- [Edge cases to cover]

## Risk Assessment
- [Potential issues]
- [Mitigation strategies]

## Questions/Concerns
- [Any unclear requirements]
- [Potential issues to discuss]
```

### Step 4: Save the Plan

Save the plan to `specs/[feature-name]-plan.md`

### Step 5: Present for Review

Show the plan to the user and ask:
- "Does this plan look correct?"
- "Any changes before we proceed?"
- "Ready to start building?"

## Notes

- Keep plans focused and actionable
- Include estimates only if asked
- Plans should be detailed enough that anyone could implement them
- Consider delegating to the planner agent for complex plans
