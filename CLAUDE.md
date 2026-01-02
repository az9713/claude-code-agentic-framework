# Codebase Singularity Framework - Claude Memory File

## Project Overview

This is the **Codebase Singularity Framework** - a full Claude Code plugin implementing the Codebase Singularity concept by IndyDevDan. The framework creates an "agentic layer" around your codebase that enables AI agents to operate autonomously through planning, building, reviewing, and fixing workflows.

### What is the Agentic Layer?

The agentic layer is a structured set of commands, agents, skills, and hooks that wrap around your application code. Think of it as the "control center" that tells AI agents:
- What your project is about
- How to navigate your codebase
- What commands and tools are available
- How to perform tasks autonomously
- When to delegate to specialized agents

### The Codebase Singularity

The ultimate goal is reaching the **"Codebase Singularity"** - the point where your AI agents can run your codebase better than you can. At this point:
- Agents understand your codebase deeply
- They can plan, build, review, and fix code autonomously
- You trust them to ship production-quality code
- Nothing goes to production without agent review
- Multi-agent orchestration handles complex tasks

---

## Classification

**Current Level: Class 3, Grade 1+ (Full Orchestration)**

### Class 1: Foundation (Grades 1-4) ✓

| Grade | Components | Status |
|-------|------------|--------|
| **Grade 1** | Prime prompt + Memory files | ✓ Complete |
| **Grade 2** | Specialized prompts + Sub-agents | ✓ Complete |
| **Grade 3** | Custom tools (Skills, MCP) | ✓ Complete |
| **Grade 4** | Feedback loops (Hooks) | ✓ Complete |

### Class 2: Workflow Level ✓

| Grade | Components | Status |
|-------|------------|--------|
| **Grade 1** | Portable agentic layers (init, templates) | ✓ Complete |
| **Grade 2** | E2E workflows (cycle, feature, bugfix) | ✓ Complete |

### Class 3: Orchestration ✓

| Grade | Components | Status |
|-------|------------|--------|
| **Grade 1+** | Orchestrator agent, multi-agent coordination | ✓ Complete |

---

## Project Structure

```
codebase-singularity/
├── .claude-plugin/
│   └── plugin.json           # Plugin manifest
├── commands/                  # 11 workflow commands
│   ├── prime.md              # Activate with context
│   ├── plan.md               # Create implementation plans
│   ├── build.md              # Implement features
│   ├── review.md             # Code quality review
│   ├── fix.md                # Address issues
│   ├── cycle.md              # Complete Plan-Build-Review-Fix
│   ├── feature.md            # Feature development workflow
│   ├── bugfix.md             # Bug investigation workflow
│   ├── orchestrate.md        # Multi-agent coordination
│   ├── delegate.md           # Direct agent invocation
│   └── init.md               # Initialize in new projects
├── agents/                    # 9 specialized agents
│   ├── 00-orchestrator.md    # Master coordinator
│   ├── 01-planner.md         # Strategic planning
│   ├── 02-builder.md         # Code implementation
│   ├── 03-reviewer.md        # Quality analysis
│   ├── 04-fixer.md           # Issue resolution
│   ├── 05-test-writer.md     # Test creation
│   ├── 06-doc-fetcher.md     # Documentation
│   ├── 07-security-auditor.md # Security analysis
│   └── 08-refactorer.md      # Code improvement
├── skills/                    # 4 skill modules
│   ├── git-workflow/         # Git patterns
│   ├── testing/              # Testing patterns
│   ├── code-review/          # Review checklists
│   └── project-workflow/     # Workflow patterns
├── hooks/
│   └── hooks.json            # Lifecycle hooks
├── scripts/                   # Hook scripts
│   ├── auto-lint.sh          # Auto-format on edit
│   ├── protect-files.sh      # File protection
│   ├── log-subagent.sh       # Activity logging
│   └── quality-gate.sh       # Quality verification
├── templates/
│   └── settings.json         # Project settings
├── specs/                     # Plans and reviews
│   ├── reviews/
│   └── fixes/
├── ai_docs/                   # AI reference docs
├── logs/                      # Activity logs
├── docs/                      # User documentation
├── app/                       # Application code
├── tests/                     # Test files
├── CLAUDE.md                  # This file
├── .mcp.json                  # MCP server config
└── README.md                  # Plugin readme
```

---

## Available Commands

### Core Workflow Commands

| Command | Purpose | Agent |
|---------|---------|-------|
| `/project:prime` | Activate with full context | - |
| `/project:plan` | Create implementation plan | planner |
| `/project:build` | Implement from plan | builder |
| `/project:review` | Quality analysis | reviewer |
| `/project:fix` | Address issues | fixer |

### E2E Workflow Commands

| Command | Purpose |
|---------|---------|
| `/project:cycle` | Complete Plan-Build-Review-Fix cycle |
| `/project:feature` | Full feature development workflow |
| `/project:bugfix` | Bug investigation and fix |

### Orchestration Commands

| Command | Purpose |
|---------|---------|
| `/project:orchestrate` | Multi-agent coordination |
| `/project:delegate [agent]` | Direct agent invocation |

### Utility Commands

| Command | Purpose |
|---------|---------|
| `/project:init` | Initialize in new project |

---

## Available Agents

| Agent | Model | Specialty |
|-------|-------|-----------|
| orchestrator | opus | Multi-agent coordination |
| planner | opus | Planning, architecture |
| builder | sonnet | Code implementation |
| reviewer | opus | Quality analysis |
| fixer | sonnet | Issue resolution |
| test-writer | sonnet | Test creation |
| doc-fetcher | haiku | Documentation research |
| security-auditor | opus | Security analysis |
| refactorer | sonnet | Code improvement |

---

## Key Workflows

### Plan-Build-Review-Fix Cycle

The core workflow for all development:

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│   ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐│
│   │  PLAN   │───►│  BUILD  │───►│ REVIEW  │───►│   FIX   ││
│   └─────────┘    └─────────┘    └─────────┘    └────┬────┘│
│        ▲                                            │      │
│        │              Loop until                    │      │
│        └────────────  quality passes ◄──────────────┘      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Feature Development

```
Research → Specify → Plan → Build → Test → Review → Fix → Complete
```

### Bug Investigation

```
Intake → Investigate → Plan Fix → Implement → Verify → Complete
```

### Orchestration

```
Analyze → Decompose → Delegate → Monitor → Aggregate → Report
```

---

## Coding Standards

### General Principles

1. **Simplicity First**: Write the simplest code that works
2. **Self-Documenting**: Code should be readable without comments
3. **Test Coverage**: All new features need tests
4. **No Magic**: Avoid clever tricks; prefer explicit code
5. **Error Handling**: Handle all error cases explicitly

### File Organization

- Keep files focused on a single responsibility
- Use descriptive file names that indicate purpose
- Group related files in meaningful directories
- Follow existing patterns in the codebase

### Naming Conventions

- **Functions**: camelCase, verb-first (`getUserById`)
- **Variables**: camelCase, descriptive (`userCount`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRIES`)
- **Classes**: PascalCase (`UserService`)
- **Files**: kebab-case (`user-service.js`)

---

## Agent Instructions

### When Starting a Session

1. Read this CLAUDE.md file
2. Run `/project:prime` to load context
3. Check `/specs/` for pending work
4. Understand current state before acting

### When Working on Tasks

1. Use the appropriate command for the task type
2. Follow the Plan-Build-Review-Fix cycle
3. Delegate to specialized agents as needed
4. Keep user informed of progress

### When Writing Code

1. Follow existing patterns
2. Write tests alongside implementation
3. Handle errors properly
4. Update documentation if needed

### When Reviewing Code

1. Use the review checklist
2. Check for security issues
3. Verify test coverage
4. Provide actionable feedback

---

## Quality Gates

| Gate | Requirement |
|------|-------------|
| Plan | User approval |
| Build | Syntax valid, patterns followed |
| Review | Score ≥ 7/10 |
| Fix | All critical issues addressed |
| Commit | All tests pass |

---

## Quick Reference

### Starting Work
```
/project:prime              # Load context
/project:plan [feature]     # Create plan
/project:build              # Implement
/project:review             # Check quality
/project:fix                # Address issues
```

### Complete Workflows
```
/project:cycle [feature]    # Full PBRF cycle
/project:feature [feature]  # Feature workflow
/project:bugfix [bug]       # Bug fix workflow
```

### Agent Delegation
```
/project:delegate planner [task]
/project:delegate builder [task]
/project:delegate reviewer [task]
/project:orchestrate [complex task]
```

---

## MCP Servers

Configured in `.mcp.json`:

| Server | Purpose |
|--------|---------|
| filesystem | Project file access |
| github | GitHub integration |
| memory | Persistent memory |

---

## Hooks

Configured in `hooks/hooks.json`:

| Hook | Trigger | Action |
|------|---------|--------|
| auto-lint | PostToolUse (Edit/Write) | Format code |
| protect-files | PreToolUse (Edit/Write) | Block protected files |
| log-subagent | SubagentStop | Log activity |
| quality-gate | Stop | Verify quality (optional) |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-01 | Initial framework (Class 1, Grade 1) |
| 2.0.0 | 2026-01-01 | Full implementation (Class 3, Grade 1+) |

---

*This file is the foundation of your agentic layer. It is automatically read by agents at session start.*
