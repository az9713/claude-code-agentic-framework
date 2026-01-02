# Sub-Agents Directory

This folder contains specialized agent definitions for specific tasks.

## What Are Sub-Agents?

Sub-agents are specialized prompts that give Claude a focused role for specific types of work. Instead of one general-purpose agent, you create experts:

- **Documentation Agent**: Expert at writing and fetching docs
- **Test Writer Agent**: Expert at writing comprehensive tests
- **Code Reviewer Agent**: Expert at reviewing code quality

## File Naming

- Use descriptive names: `test-writer.md`, `doc-fetcher.md`
- One agent per file
- Use `.md` extension

## Agent Template

```markdown
# [Agent Name]

## Role
You are a [specific role]. Your expertise is [domain].

## Responsibilities
- Responsibility 1
- Responsibility 2

## Constraints
- What you MUST NOT do
- Boundaries of your work

## Input
What you need:
- Input 1
- Input 2

## Output
What you produce:
- Output 1
- Output 2

## Process
1. First step
2. Second step
3. Third step
```

## Available Agents

| Agent | File | Purpose |
|-------|------|---------|
| Test Writer | `test-writer.md` | Write comprehensive tests |
| (Add more as you create them) | | |

## Using Agents

Reference agents in commands or invoke directly:

```
> Use the test writer agent to create tests for validators.js
```

## Best Practices

1. **Keep agents focused**: One job per agent
2. **Be specific about constraints**: What they shouldn't do
3. **Include examples**: Show expected input/output
4. **Define the process**: Step-by-step workflow
