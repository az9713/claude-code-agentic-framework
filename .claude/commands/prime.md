# Prime Command - Project Activation

## Purpose

This is the main activation command that prepares Claude for working on this project. Run this at the start of every session.

## Instructions

When this command is invoked, perform the following steps:

### Step 1: Read Core Files

1. Read `CLAUDE.md` in the project root
2. Read any recent files in `specs/` directory
3. Scan the `app/` directory structure

### Step 2: Understand Context

Based on the files read:
- Identify the project purpose and goals
- Note the current agentic layer grade
- Review coding standards and conventions
- Understand the folder structure

### Step 3: Confirm Readiness

Respond to the user with:
1. A brief summary (2-3 sentences) of the project
2. Current agentic layer grade
3. What capabilities are available
4. Ask what the user wants to accomplish

## Example Response

```
Project Loaded: Agentic Layer Framework

This is a Class 1, Grade 1 agentic layer implementation focused on
teaching AI agents to operate codebases. Current capabilities include
prime activation, planning workflows, and code review.

Available commands:
- /project:plan - Create implementation plans
- /project:build - Build from specifications
- /project:review - Review code quality

What would you like to work on?
```

## Notes

- Always be concise in the activation response
- Don't list every file - just the summary
- Be ready to dive deeper when asked
