# Agentic Layer Classification Guide

## Complete Reference for Class 1-3, All Grades

**Version**: 1.0.0
**Current Level**: Class 3, Grade 1+
**Last Updated**: 2026-01-01

---

## Table of Contents

- [Overview](#overview)
- [Class 1: Foundation](#class-1-foundation)
  - [Grade 1: Memory & Context](#grade-1-memory--context)
  - [Grade 2: Sub-Agents](#grade-2-sub-agents)
  - [Grade 3: Custom Tools](#grade-3-custom-tools)
  - [Grade 4: Feedback Loops](#grade-4-feedback-loops)
- [Class 2: Workflow Level](#class-2-workflow-level)
  - [Grade 1: Portable Structure](#grade-1-portable-structure)
  - [Grade 2: E2E Workflows](#grade-2-e2e-workflows)
- [Class 3: Orchestration](#class-3-orchestration)
  - [Grade 1+: Multi-Agent Coordination](#grade-1-multi-agent-coordination)
- [Implementation Checklist](#implementation-checklist)
- [Progression Path](#progression-path)

---

## Overview

The Agentic Layer Classification system, introduced by IndyDevDan, defines a progression from basic AI assistance to full autonomous codebase operation.

```
┌─────────────────────────────────────────────────────────────┐
│                    CLASSIFICATION PYRAMID                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│                      ┌───────────┐                          │
│                      │  CLASS 3  │  Orchestration           │
│                      │  Grade 1+ │  Multi-agent coord       │
│                      └─────┬─────┘                          │
│                            │                                 │
│                 ┌──────────┴──────────┐                     │
│                 │       CLASS 2       │  Workflows           │
│                 │  Grade 1  │  Grade 2│  Portable + E2E      │
│                 └──────────┬──────────┘                     │
│                            │                                 │
│      ┌─────────────────────┴─────────────────────┐          │
│      │                  CLASS 1                   │  Foundation│
│      │  Grade 1 │ Grade 2 │ Grade 3 │ Grade 4    │          │
│      │  Memory  │ Agents  │  Tools  │ Feedback   │          │
│      └───────────────────────────────────────────┘          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Class 1: Foundation

Class 1 establishes the building blocks for AI-assisted development. Each grade adds a new capability layer.

---

### Grade 1: Memory & Context

**Purpose**: Give AI agents context about your project so they can work effectively.

**Dan's Description**: "The prime prompt and memory files - this is where you tell the AI what your project is about."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Prime Prompt | Load project context at session start | `commands/prime.md` |
| Memory File (Claude) | Claude-specific project memory | `CLAUDE.md` |
| Memory File (Universal) | Cross-platform agent instructions | `AGENTS.md` |

#### CLAUDE.md Contents

```
CLAUDE.md
├── Project Overview         # What this project is
├── Classification          # Current agentic level
├── Project Structure       # Directory layout
├── Available Commands      # What AI can do
├── Available Agents        # Specialized workers
├── Key Workflows           # How things work
├── Coding Standards        # Quality expectations
└── Agent Instructions      # How to behave
```

#### AGENTS.md Contents

Following the [agents.md](https://agents.md) standard:

```
AGENTS.md
├── Project Overview         # Context for any AI
├── Build and Test          # How to build/test
├── Code Style              # Development conventions
├── Project Structure       # Key directories
├── Security                # Protected files
└── Commit Guidelines       # Contribution standards
```

#### Usage

```
> /prime
```

This loads all context, making AI aware of your project.

#### Verification

- [ ] `CLAUDE.md` exists at project root
- [ ] `AGENTS.md` exists at project root
- [ ] `commands/prime.md` exists
- [ ] `/prime` loads context successfully

---

### Grade 2: Sub-Agents

**Purpose**: Delegate tasks to specialized AI agents, each expert in a specific domain.

**Dan's Description**: "Specialized prompts and sub-agents - you create different agents for different tasks."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Agent Definitions | YAML frontmatter + instructions | `agents/*.md` |
| Model Selection | Right model for each task | opus/sonnet/haiku |
| Tool Permissions | What each agent can do | `tools:` in frontmatter |

#### Agent Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      AGENT HIERARCHY                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│                    ┌──────────────┐                         │
│                    │ Orchestrator │  (opus)                 │
│                    │  Coordinator │                         │
│                    └──────┬───────┘                         │
│                           │                                  │
│         ┌─────────────────┼─────────────────┐               │
│         │                 │                 │               │
│    ┌────┴────┐      ┌────┴────┐      ┌────┴────┐           │
│    │ Planner │      │ Builder │      │Reviewer │           │
│    │ (opus)  │      │(sonnet) │      │ (opus)  │           │
│    └─────────┘      └─────────┘      └─────────┘           │
│                           │                                  │
│         ┌─────────────────┼─────────────────┐               │
│         │                 │                 │               │
│    ┌────┴────┐      ┌────┴────┐      ┌────┴────┐           │
│    │  Fixer  │      │  Test   │      │  Doc    │           │
│    │(sonnet) │      │ Writer  │      │ Fetcher │           │
│    └─────────┘      │(sonnet) │      │ (haiku) │           │
│                     └─────────┘      └─────────┘           │
│                           │                                  │
│              ┌────────────┴────────────┐                    │
│              │                         │                    │
│         ┌────┴────┐              ┌────┴────┐               │
│         │Security │              │Refactor │               │
│         │ Auditor │              │   er    │               │
│         │ (opus)  │              │(sonnet) │               │
│         └─────────┘              └─────────┘               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Our 9 Agents

| Agent | Model | Specialty | Tools |
|-------|-------|-----------|-------|
| `orchestrator` | opus | Multi-agent coordination | Task, Read, Write, Glob, Grep |
| `planner` | opus | Architecture, planning | Read, Glob, Grep, WebSearch, WebFetch |
| `builder` | sonnet | Code implementation | Read, Write, Edit, Bash, Glob, Grep |
| `reviewer` | opus | Quality analysis | Read, Grep, Glob |
| `fixer` | sonnet | Issue resolution | Read, Write, Edit, Bash, Glob, Grep |
| `test-writer` | sonnet | Test creation | Read, Write, Edit, Glob, Grep |
| `doc-fetcher` | haiku | Documentation research | Read, Write, WebFetch, WebSearch, Glob |
| `security-auditor` | opus | Security analysis | Read, Grep, Glob |
| `refactorer` | sonnet | Code improvement | Read, Write, Edit, Glob, Grep |

#### Model Selection Rationale

| Model | Use Case | Why |
|-------|----------|-----|
| opus | Complex reasoning | Best for planning, reviewing, security |
| sonnet | Implementation | Good balance for coding tasks |
| haiku | Simple tasks | Fast, cheap for documentation |

#### Agent Definition Format

```yaml
---
name: agent-name
description: What this agent does
model: opus|sonnet|haiku
tools:
  - Read
  - Write
  - Edit
---

# Agent Name

## Role
[Primary responsibility]

## Guidelines
[How to approach tasks]

## Output Format
[Expected structure]
```

#### Usage

```
> /delegate planner Design authentication system
> /delegate builder Implement the login form
> /delegate reviewer Review the authentication code
```

#### Verification

- [ ] 9 agent files exist in `agents/`
- [ ] Each agent has YAML frontmatter
- [ ] Each agent specifies model and tools
- [ ] `/delegate` invokes agents correctly

---

### Grade 3: Custom Tools

**Purpose**: Extend AI capabilities with external tools and knowledge.

**Dan's Description**: "Custom tools like Skills and MCP - this is where you give the AI access to external capabilities."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Skills | Reusable knowledge modules | `skills/*/SKILL.md` |
| MCP Servers | External tool integrations | `.mcp.json` |

#### Skills Architecture

```
skills/
├── git-workflow/
│   └── SKILL.md           # Git patterns and best practices
├── testing/
│   └── SKILL.md           # Testing strategies
├── code-review/
│   └── SKILL.md           # Review checklists
└── project-workflow/
    └── SKILL.md           # Development workflow patterns
```

#### Our 4 Skills

| Skill | Purpose | Triggers |
|-------|---------|----------|
| `git-workflow` | Git patterns, branching, commits | git, branch, commit |
| `testing` | Testing strategies, coverage | test, coverage |
| `code-review` | Review checklists, quality | review, audit |
| `project-workflow` | Development workflow patterns | workflow, cycle |

#### MCP Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "description": "File system access for project directories"
    },
    "github": {
      "description": "GitHub integration for issues, PRs"
    },
    "memory": {
      "description": "Persistent memory for cross-session context"
    }
  }
}
```

#### Our 3 MCP Servers

| Server | Purpose | Capabilities |
|--------|---------|--------------|
| `filesystem` | Project file access | Read/write to app/, tests/, specs/, ai_docs/ |
| `github` | GitHub integration | Issues, PRs, repository management |
| `memory` | Persistent memory | Cross-session context |

#### Verification

- [ ] 4 skill directories exist in `skills/`
- [ ] Each skill has `SKILL.md`
- [ ] `.mcp.json` exists at project root
- [ ] MCP servers are configured

---

### Grade 4: Feedback Loops

**Purpose**: Enable agents to review work and self-correct through automated feedback.

**Dan's Description**: "Feedback loops - this is where you have agents review the work done by other agents."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Hooks Configuration | Event-driven automation | `hooks/hooks.json` |
| Hook Scripts | Automation logic | `scripts/*.sh` |
| Review Trigger | Auto-review after builds | `auto-review` hook |

#### Feedback Loop Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     FEEDBACK LOOP                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   Builder Agent                                              │
│        │                                                     │
│        ▼                                                     │
│   ┌─────────────────┐                                       │
│   │ SubagentStop    │ ──► auto-review hook fires            │
│   │ Event           │                                       │
│   └─────────────────┘                                       │
│        │                                                     │
│        ▼                                                     │
│   ┌─────────────────┐                                       │
│   │ "FEEDBACK LOOP  │                                       │
│   │  TRIGGERED"     │ ──► Prompts /review           │
│   └─────────────────┘                                       │
│        │                                                     │
│        ▼                                                     │
│   Reviewer Agent                                             │
│        │                                                     │
│        ▼                                                     │
│   Score < 7? ─────────────────────────┐                     │
│        │                              │                     │
│        ▼                              ▼                     │
│   ┌─────────┐                   ┌─────────┐                 │
│   │  PASS   │                   │  FAIL   │                 │
│   │ Done!   │                   │  Fix    │ ──► Fixer Agent │
│   └─────────┘                   └─────────┘         │       │
│                                                     │       │
│                                       ┌─────────────┘       │
│                                       ▼                     │
│                                 auto-review fires again     │
│                                       │                     │
│                                       ▼                     │
│                                 Loop (max 3 iterations)     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Our 5 Hooks

| Hook | Event | Purpose | Type |
|------|-------|---------|------|
| `auto-lint` | PostToolUse | Format code after edits | Automation |
| `protect-files` | PreToolUse | Block sensitive files | Protection |
| `log-subagent` | SubagentStop | Track agent activity | Logging |
| `auto-review` | SubagentStop | Trigger review after build | **Feedback Loop** |
| `quality-gate` | Stop | Verify before completion | Validation |

#### Feedback Loop vs Automation

| Type | Purpose | Example |
|------|---------|---------|
| **Automation** | Do something automatically | `auto-lint` formats code |
| **Feedback Loop** | Agent reviews other agents | `auto-review` triggers reviewer |

#### Verification

- [ ] `hooks/hooks.json` exists
- [ ] `auto-review` hook is enabled
- [ ] `scripts/auto-review.sh` exists
- [ ] Hook triggers after builder/fixer complete
- [ ] Loop protection prevents infinite loops

---

## Class 2: Workflow Level

Class 2 builds on Class 1 to create complete development workflows.

---

### Grade 1: Portable Structure

**Purpose**: Make the agentic layer portable to any project.

**Dan's Description**: "Portable agentic layers - you can take this structure to any codebase."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Init Command | Initialize framework in new projects | `commands/init.md` |
| Templates | Default configurations | `templates/settings.json` |
| Self-Contained | No external dependencies | All files in project |

#### Init Command

```
> /init
```

Creates:
```
project/
├── CLAUDE.md              # Project memory
├── AGENTS.md              # Agent instructions
├── commands/              # Workflow commands
├── agents/                # Agent definitions
├── skills/                # Skill modules
├── hooks/                 # Hook configuration
├── scripts/               # Hook scripts
├── specs/                 # Plans and reviews
├── ai_docs/               # Documentation cache
└── templates/             # Settings template
```

#### Settings Template

```json
{
  "project": {
    "name": "Project Name",
    "language": "javascript"
  },
  "agenticLayer": {
    "class": 3,
    "grade": 1
  },
  "preferences": {
    "autoLint": true,
    "qualityGate": false
  },
  "agents": {
    "defaultModel": "sonnet",
    "enabled": ["planner", "builder", "reviewer", "fixer"]
  }
}
```

#### Verification

- [ ] `commands/init.md` exists
- [ ] `templates/settings.json` exists
- [ ] `/init` creates full structure
- [ ] Framework works in fresh project

---

### Grade 2: E2E Workflows

**Purpose**: Complete end-to-end development workflows in single commands.

**Dan's Description**: "End-to-end workflows - you can run a complete feature from start to finish."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Cycle Command | Complete Plan-Build-Review-Fix | `commands/cycle.md` |
| Feature Command | Full feature development | `commands/feature.md` |
| Bugfix Command | Bug investigation and fix | `commands/bugfix.md` |

#### The Cycle Command

```
> /cycle Add user authentication
```

```
┌─────────────────────────────────────────────────────────────┐
│                    /cycle                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐  │
│   │  PLAN   │───►│  BUILD  │───►│ REVIEW  │───►│   FIX   │  │
│   │ (opus)  │    │(sonnet) │    │ (opus)  │    │(sonnet) │  │
│   └─────────┘    └─────────┘    └─────────┘    └────┬────┘  │
│        ▲                                            │       │
│        │              Loop until                    │       │
│        └────────────  score >= 7/10  ◄──────────────┘       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### The Feature Command

```
> /feature Add notification system
```

```
Gather Requirements
       │
       ▼
 Create Detailed Plan
       │
       ▼
 Get User Approval
       │
       ▼
 Build with Tests
       │
       ▼
 Review Quality
       │
       ▼
 Fix Issues
       │
       ▼
 Complete
```

#### The Bugfix Command

```
> /bugfix Login fails after password change
```

```
Intake Bug Report
       │
       ▼
 Investigate & Reproduce
       │
       ▼
 Locate Root Cause
       │
       ▼
 Plan Fix
       │
       ▼
 Implement Fix
       │
       ▼
 Verify No Regression
       │
       ▼
 Complete
```

#### Our 11 Commands

| Command | Purpose | Workflow |
|---------|---------|----------|
| `prime` | Load context | - |
| `plan` | Create implementation plan | P |
| `build` | Implement from plan | B |
| `review` | Quality analysis | R |
| `fix` | Address issues | F |
| `cycle` | Complete P-B-R-F | P→B→R→F→Loop |
| `feature` | Feature development | Full lifecycle |
| `bugfix` | Bug investigation | Investigation→Fix |
| `orchestrate` | Multi-agent | Complex tasks |
| `delegate` | Direct agent | Specific agent |
| `init` | Initialize framework | Setup |

#### Verification

- [ ] `commands/cycle.md` exists
- [ ] `commands/feature.md` exists
- [ ] `commands/bugfix.md` exists
- [ ] Cycle loops until score >= 7
- [ ] Feature covers full lifecycle

---

## Class 3: Orchestration

Class 3 enables multi-agent coordination for complex tasks.

---

### Grade 1+: Multi-Agent Coordination

**Purpose**: Coordinate multiple agents to handle complex, multi-step tasks.

**Dan's Description**: "Orchestration - one agent coordinates multiple other agents."

#### Required Components

| Component | Purpose | Our Implementation |
|-----------|---------|-------------------|
| Orchestrator Agent | Coordinator | `agents/00-orchestrator.md` |
| Orchestrate Command | Invoke orchestrator | `commands/orchestrate.md` |
| Delegate Command | Direct agent invocation | `commands/delegate.md` |
| Parallel Execution | Run agents simultaneously | Task decomposition |

#### Orchestrator Flow

```
> /orchestrate Implement complete authentication system
```

```
┌─────────────────────────────────────────────────────────────┐
│                      ORCHESTRATOR                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. ANALYZE TASK                                             │
│     └── "Implement complete authentication system"          │
│                                                              │
│  2. DECOMPOSE INTO SUBTASKS                                  │
│     ├── Research auth best practices                        │
│     ├── Design authentication flow                          │
│     ├── Implement user registration                         │
│     ├── Implement login/logout                              │
│     ├── Add password reset                                  │
│     ├── Write tests                                         │
│     └── Security audit                                      │
│                                                              │
│  3. ASSIGN TO AGENTS                                         │
│     ├── doc-fetcher → Research                              │
│     ├── planner → Design                                    │
│     ├── builder → Implementation                            │
│     ├── test-writer → Tests                                 │
│     └── security-auditor → Audit                            │
│                                                              │
│  4. EXECUTE (PARALLEL WHERE POSSIBLE)                        │
│     │                                                        │
│     │  Group A (parallel):                                   │
│     │  ├── doc-fetcher researching...                       │
│     │  └── planner designing...                             │
│     │                                                        │
│     │  Group B (sequential, depends on A):                  │
│     │  └── builder implementing...                          │
│     │                                                        │
│     │  Group C (parallel, depends on B):                    │
│     │  ├── test-writer testing...                           │
│     │  └── security-auditor auditing...                     │
│     │                                                        │
│     │  Group D (sequential, depends on C):                  │
│     │  └── reviewer reviewing...                            │
│                                                              │
│  5. AGGREGATE RESULTS                                        │
│     ├── Combine all agent outputs                           │
│     ├── Handle any errors                                   │
│     └── Resolve conflicts                                   │
│                                                              │
│  6. REPORT                                                   │
│     └── Summary of completed work                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### Parallel vs Sequential Execution

```
PARALLEL (independent tasks):
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│ doc-fetcher │  │   planner   │  │ test-writer │
│  researching│  │  designing  │  │   writing   │
└─────────────┘  └─────────────┘  └─────────────┘
      │                │                │
      └────────────────┴────────────────┘
                       │
                       ▼
                 All complete

SEQUENTIAL (dependent tasks):
┌─────────────┐
│   planner   │
│  designing  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   builder   │
│ implementing│
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  reviewer   │
│  reviewing  │
└─────────────┘
```

#### Direct Delegation

```
> /delegate security-auditor Audit the payment module
```

Bypasses orchestrator for focused, single-agent tasks.

#### Verification

- [ ] `agents/00-orchestrator.md` exists
- [ ] `commands/orchestrate.md` exists
- [ ] `commands/delegate.md` exists
- [ ] Orchestrator decomposes tasks
- [ ] Parallel execution works
- [ ] Results are aggregated

---

## Implementation Checklist

### Class 1 Checklist

| Grade | Component | File | Status |
|-------|-----------|------|--------|
| **1** | Prime command | `commands/prime.md` | ✓ |
| **1** | Claude memory | `CLAUDE.md` | ✓ |
| **1** | Universal memory | `AGENTS.md` | ✓ |
| **2** | Orchestrator | `agents/00-orchestrator.md` | ✓ |
| **2** | Planner | `agents/01-planner.md` | ✓ |
| **2** | Builder | `agents/02-builder.md` | ✓ |
| **2** | Reviewer | `agents/03-reviewer.md` | ✓ |
| **2** | Fixer | `agents/04-fixer.md` | ✓ |
| **2** | Test Writer | `agents/05-test-writer.md` | ✓ |
| **2** | Doc Fetcher | `agents/06-doc-fetcher.md` | ✓ |
| **2** | Security Auditor | `agents/07-security-auditor.md` | ✓ |
| **2** | Refactorer | `agents/08-refactorer.md` | ✓ |
| **3** | Git Workflow skill | `skills/git-workflow/SKILL.md` | ✓ |
| **3** | Testing skill | `skills/testing/SKILL.md` | ✓ |
| **3** | Code Review skill | `skills/code-review/SKILL.md` | ✓ |
| **3** | Project Workflow skill | `skills/project-workflow/SKILL.md` | ✓ |
| **3** | MCP configuration | `.mcp.json` | ✓ |
| **4** | Hooks configuration | `hooks/hooks.json` | ✓ |
| **4** | Auto-lint hook | `scripts/auto-lint.sh` | ✓ |
| **4** | Protect files hook | `scripts/protect-files.sh` | ✓ |
| **4** | Log subagent hook | `scripts/log-subagent.sh` | ✓ |
| **4** | Auto-review hook | `scripts/auto-review.sh` | ✓ |
| **4** | Quality gate hook | `scripts/quality-gate.sh` | ✓ |

### Class 2 Checklist

| Grade | Component | File | Status |
|-------|-----------|------|--------|
| **1** | Init command | `commands/init.md` | ✓ |
| **1** | Settings template | `templates/settings.json` | ✓ |
| **2** | Cycle command | `commands/cycle.md` | ✓ |
| **2** | Feature command | `commands/feature.md` | ✓ |
| **2** | Bugfix command | `commands/bugfix.md` | ✓ |

### Class 3 Checklist

| Grade | Component | File | Status |
|-------|-----------|------|--------|
| **1+** | Orchestrate command | `commands/orchestrate.md` | ✓ |
| **1+** | Delegate command | `commands/delegate.md` | ✓ |
| **1+** | Orchestrator agent | `agents/00-orchestrator.md` | ✓ |

---

## Progression Path

### Starting from Scratch

```
Step 1: Class 1, Grade 1
├── Create CLAUDE.md
├── Create AGENTS.md
└── Create commands/prime.md

Step 2: Class 1, Grade 2
├── Create agents/01-planner.md
├── Create agents/02-builder.md
├── Create agents/03-reviewer.md
└── Create agents/04-fixer.md

Step 3: Class 1, Grade 3
├── Create skills/
├── Create .mcp.json
└── Configure MCP servers

Step 4: Class 1, Grade 4
├── Create hooks/hooks.json
├── Create scripts/auto-lint.sh
├── Create scripts/auto-review.sh
└── Enable feedback loop

Step 5: Class 2, Grade 1
├── Create commands/init.md
└── Create templates/settings.json

Step 6: Class 2, Grade 2
├── Create commands/cycle.md
├── Create commands/feature.md
└── Create commands/bugfix.md

Step 7: Class 3, Grade 1+
├── Create agents/00-orchestrator.md
├── Create commands/orchestrate.md
└── Create commands/delegate.md

COMPLETE: Codebase Singularity achieved!
```

### Quick Assessment

| Question | If Yes | If No |
|----------|--------|-------|
| Does AI know your project? | ≥ Grade 1 | Add CLAUDE.md |
| Can you delegate to specialized agents? | ≥ Grade 2 | Add agents/ |
| Do you have skills and MCP? | ≥ Grade 3 | Add skills/, .mcp.json |
| Do agents review each other? | ≥ Grade 4 | Add auto-review hook |
| Can you init in new projects? | ≥ Class 2 | Add init command |
| Do you have E2E workflows? | ≥ Class 2, Grade 2 | Add cycle/feature/bugfix |
| Can one agent coordinate others? | Class 3 | Add orchestrator |

---

## Summary

| Class | Grade | Name | Key Components |
|-------|-------|------|----------------|
| 1 | 1 | Memory | CLAUDE.md, AGENTS.md, prime.md |
| 1 | 2 | Agents | 9 specialized agents |
| 1 | 3 | Tools | 4 skills, 3 MCP servers |
| 1 | 4 | Feedback | 5 hooks including auto-review |
| 2 | 1 | Portable | init command, templates |
| 2 | 2 | Workflows | cycle, feature, bugfix |
| 3 | 1+ | Orchestration | orchestrator, delegate |

**Current Implementation**: Class 3, Grade 1+ (Complete)

---

## Related Documentation

- [AGENTIC_LAYER.md](./AGENTIC_LAYER.md) - Core concept explanation
- [AGENTS_REFERENCE.md](./AGENTS_REFERENCE.md) - Agent specifications
- [COMMANDS_REFERENCE.md](./COMMANDS_REFERENCE.md) - Command reference
- [HOOKS_GUIDE.md](./HOOKS_GUIDE.md) - Hook documentation

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
