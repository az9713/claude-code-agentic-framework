---
name: prime
description: Activate the agent with full project context and prepare for work. Run this at the start of every session.
---
# Prime Command - Project Activation

## Purpose

This is the main activation command that prepares Claude for working on this project. Run this at the start of every session.

## Instructions

When this command is invoked, perform the following steps:

### Step 1: Read Core Files

1. Read `CLAUDE.md` in the project root
2. Read any recent files in `specs/` directory
3. Scan the `app/` directory structure
4. Check for any pending review reports

### Step 2: Understand Context

Based on the files read:
- Identify the project purpose and goals
- Note the current agentic layer grade (Class/Grade)
- Review coding standards and conventions
- Understand the folder structure
- Identify available agents and skills

### Step 3: Confirm Readiness

Respond to the user with:
1. A brief summary (2-3 sentences) of the project
2. Current agentic layer classification (Class X, Grade Y)
3. What capabilities are available (commands, agents, skills)
4. Any pending work or recent changes
5. Ask what the user wants to accomplish

## Example Response

```
Project Loaded: Codebase Singularity Framework

This is a Class 3, Grade 1 agentic layer implementing the full Codebase
Singularity concept with orchestration capabilities. The framework enables
autonomous plan-build-review-fix workflows.

Available Commands:
- /project:plan - Create implementation plans
- /project:build - Build from specifications
- /project:review - Review code quality
- /project:fix - Address review issues
- /project:cycle - Complete development cycle
- /project:orchestrate - Multi-agent coordination

Available Agents: planner, builder, reviewer, fixer, test-writer,
                  doc-fetcher, security-auditor, refactorer, orchestrator

What would you like to work on?
```

## Notes

- Always be concise in the activation response
- Don't list every file - just the summary
- Be ready to dive deeper when asked
- Mention if there are pending reviews or incomplete work
