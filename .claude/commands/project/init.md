---
name: init
description: Initialize the Codebase Singularity framework in a new project. Sets up directory structure, CLAUDE.md, and default configuration.
---
# Init Command - Project Initialization

## Purpose

Initialize the Codebase Singularity framework in a new or existing project, setting up all necessary structure for agentic layer operations.

## When to Use

- Starting a new project with the framework
- Adding the framework to an existing codebase
- Resetting a project's agentic layer configuration
- Upgrading from a lower class/grade implementation

## Instructions

When this command is invoked:

### Step 1: Check Current State

1. Check if framework is already initialized
2. Identify existing project structure
3. Detect project type (Node.js, Python, etc.)
4. Note any existing configuration

### Step 2: Get User Preferences

Ask user (if not specified):
- "What class level? (1: Single Agent, 2: Portable, 3: Orchestration)"
- "Include MCP server configuration?"
- "Include hook scripts?"
- "What's the project name/description?"

### Step 3: Create Directory Structure

Create the following structure:

```
project-root/
├── .claude-plugin/
│   └── plugin.json        # Plugin manifest
├── commands/              # Custom commands
├── agents/                # Agent definitions
├── skills/                # Skill definitions
├── hooks/                 # Hook configuration
│   └── hooks.json
├── scripts/               # Hook scripts
├── specs/                 # Plans and reviews
│   ├── reviews/
│   └── fixes/
├── ai_docs/               # AI reference documentation
├── logs/                  # Agent activity logs
├── templates/             # Project templates
│   └── settings.json
├── CLAUDE.md              # Project memory
└── .mcp.json              # MCP configuration
```

### Step 4: Create CLAUDE.md

Generate a CLAUDE.md tailored to the project:

```markdown
# [Project Name] - Agentic Layer Memory

## Project Overview
[Auto-detected or user-provided description]

## Classification
- **Class**: [Selected class]
- **Grade**: 1 (Initial)

## Project Structure
[Auto-detected structure]

## Commands
[List available commands]

## Agents
[List available agents]

## Coding Standards
[Default standards or detected from project]

## Quick Start
1. /prime - Load context
2. /plan - Create implementation plan
3. /build - Implement features
4. /review - Review code quality
5. /fix - Address issues
```

### Step 5: Create Default Configuration

Create `templates/settings.json`:

```json
{
  "project": {
    "name": "[Project Name]",
    "description": "[Description]",
    "version": "1.0.0"
  },
  "agenticLayer": {
    "class": 1,
    "grade": 1
  },
  "preferences": {
    "autoLint": true,
    "protectedFiles": true,
    "qualityGate": false
  },
  "agents": {
    "defaultModel": "sonnet",
    "plannerModel": "opus",
    "reviewerModel": "opus"
  }
}
```

### Step 6: Verify Installation

Check that all components are in place:

- [ ] Directory structure created
- [ ] CLAUDE.md exists
- [ ] Plugin manifest valid
- [ ] At least one command available
- [ ] MCP configuration (if selected)
- [ ] Hooks configuration (if selected)

### Step 7: Present Summary

Show initialization summary:

```markdown
# Framework Initialized

## Configuration
- Class: [X]
- Grade: 1
- MCP: [Enabled/Disabled]
- Hooks: [Enabled/Disabled]

## Structure Created
✓ .claude-plugin/plugin.json
✓ commands/ (X commands)
✓ agents/ (X agents)
✓ skills/ (X skills)
✓ CLAUDE.md
✓ specs/
✓ ai_docs/

## Next Steps
1. Review CLAUDE.md and customize for your project
2. Run /prime to load context
3. Start developing with /plan

## Available Commands
[List all commands]

Type /prime to begin!
```

## Class-Specific Initialization

### Class 1: Single Agent Operations
- Basic commands: prime, plan, build, review, fix
- Core agents: planner, builder, reviewer, fixer
- No orchestration

### Class 2: Portable Layer
- All Class 1 features
- Init command for portability
- Settings template
- E2E workflow commands

### Class 3: Orchestration
- All Class 2 features
- Orchestrator agent
- Multi-agent coordination commands
- Parallel execution support

## Upgrade Path

When upgrading from lower class:

```bash
# From Class 1 to Class 2
/init --upgrade --class 2

# From Class 2 to Class 3
/init --upgrade --class 3
```

Upgrade adds:
- New agents for the class
- New commands
- Updated CLAUDE.md
- Preserves existing customizations

## Notes

- Never overwrite existing CLAUDE.md without confirmation
- Preserve existing specs/ content
- Detect and adapt to project type
- Create .gitignore entries for logs/
- Suggest next steps based on project state
