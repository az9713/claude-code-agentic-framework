# Developer Guide: Codebase Singularity Plugin

## Complete Technical Documentation for Developers

**Target Audience**: Developers who want to understand, extend, or maintain this Claude Code plugin implementing the Codebase Singularity concept.

**Goal**: After reading this guide, you will understand the architecture, design decisions, implementation details, and how to extend every component of this framework.

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Plugin Structure](#2-plugin-structure)
3. [Agent System Design](#3-agent-system-design)
4. [Command Implementation](#4-command-implementation)
5. [Skills Architecture](#5-skills-architecture)
6. [Hooks System](#6-hooks-system)
7. [MCP Integration](#7-mcp-integration)
8. [Orchestration Engine](#8-orchestration-engine)
9. [The Plan-Build-Review-Fix Cycle](#9-the-plan-build-review-fix-cycle)
10. [Quality Gates and Feedback Loops](#10-quality-gates-and-feedback-loops)
11. [Extending the Framework](#11-extending-the-framework)
12. [Testing and Debugging](#12-testing-and-debugging)
13. [Implementation Reference](#13-implementation-reference)
14. [Glossary](#14-glossary)

---

## 1. Architecture Overview

### 1.1 The Codebase Singularity Concept

The Codebase Singularity is the point where AI agents can operate your codebase autonomously. This plugin implements IndyDevDan's framework as a Claude Code plugin, achieving **Class 3, Grade 1+** - the highest level of the agentic layer classification.

### 1.2 Classification System

```
┌─────────────────────────────────────────────────────────────────┐
│                    CODEBASE SINGULARITY                          │
│                    Class 3, Grade 1+                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  CLASS 3: Orchestration Layer                                    │
│  ├── Multi-agent coordination                                    │
│  ├── Parallel execution                                          │
│  └── Task decomposition and delegation                           │
│                                                                  │
│  CLASS 2: Workflow Layer                                         │
│  ├── Portable layer structure                                    │
│  ├── E2E workflows (Plan-Build-Review-Fix)                       │
│  └── Quality gates                                               │
│                                                                  │
│  CLASS 1: Foundation Layer                                       │
│  ├── Grade 4: Hooks (feedback loops)                             │
│  ├── Grade 3: Skills and MCP                                     │
│  ├── Grade 2: Specialized agents                                 │
│  └── Grade 1: Memory (CLAUDE.md)                                 │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 Two-Layer Architecture

Every project using this framework has two distinct layers:

```
┌─────────────────────────────────────────────────────────────────┐
│                       AGENTIC LAYER                              │
│  (Plugin, Commands, Agents, Skills, Hooks, Memory)               │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                  APPLICATION LAYER                       │    │
│  │  (Your actual code: backend, frontend, database, etc.)   │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

**Agentic Layer** = Instructions, workflows, and tools that teach AI to operate your codebase
**Application Layer** = The actual code that runs your application

### 1.4 Core Design Principles

| Principle | Description |
|-----------|-------------|
| **Separation of Concerns** | Each agent has a single responsibility |
| **Quality Gates** | Every change must pass review (score ≥ 7/10) |
| **Feedback Loops** | Self-reviewing, self-correcting automation |
| **Parallel Execution** | Independent tasks run concurrently |
| **Deterministic Workflows** | Same input produces consistent output |

---

## 2. Plugin Structure

### 2.1 Directory Layout

```
codebase_singularity/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest (CRITICAL)
│
├── commands/                    # 11 workflow commands
│   ├── prime.md                 # Context activation
│   ├── plan.md                  # Planning workflow
│   ├── build.md                 # Implementation workflow
│   ├── review.md                # Quality review
│   ├── fix.md                   # Issue resolution
│   ├── cycle.md                 # Complete P-B-R-F cycle
│   ├── feature.md               # Feature development workflow
│   ├── bugfix.md                # Bug investigation workflow
│   ├── orchestrate.md           # Multi-agent coordination
│   ├── delegate.md              # Direct agent invocation
│   └── setup.md                  # Initialize in new projects
│
├── agents/                      # 9 specialized agents
│   ├── 00-orchestrator.md       # Master coordinator (opus)
│   ├── 01-planner.md            # Strategic planning (opus)
│   ├── 02-builder.md            # Code implementation (sonnet)
│   ├── 03-reviewer.md           # Quality analysis (opus)
│   ├── 04-fixer.md              # Issue resolution (sonnet)
│   ├── 05-test-writer.md        # Test creation (sonnet)
│   ├── 06-doc-fetcher.md        # Documentation research (haiku)
│   ├── 07-security-auditor.md   # Security analysis (opus)
│   └── 08-refactorer.md         # Code improvement (sonnet)
│
├── skills/                      # 4 skill modules
│   ├── git-workflow/
│   │   └── SKILL.md
│   ├── testing/
│   │   └── SKILL.md
│   ├── code-review/
│   │   └── SKILL.md
│   └── project-workflow/
│       └── SKILL.md
│
├── hooks/
│   └── hooks.json               # Lifecycle automation
│
├── scripts/                     # Hook scripts
│   ├── auto-lint.sh             # Auto-format on save
│   ├── protect-files.sh         # File protection
│   ├── log-subagent.sh          # Activity logging
│   └── quality-gate.sh          # Quality verification
│
├── templates/
│   └── settings.json            # Project settings template
│
├── specs/                       # Plans and reviews
│   ├── plans/                   # Implementation plans
│   └── reviews/                 # Code reviews
│
├── ai_docs/                     # AI reference documentation
│
├── .mcp.json                    # MCP server configuration
├── CLAUDE.md                    # Agent memory file
└── README.md                    # Project documentation
```

### 2.2 Plugin Manifest

**File**: `.claude-plugin/plugin.json`

```json
{
  "$schema": "https://cdn.jsdelivr.net/npm/@anthropic-ai/claude-code-plugin/schema.json",
  "name": "codebase-singularity",
  "version": "1.0.0",
  "description": "AI agents operating codebases autonomously - Plan-Build-Review-Fix",
  "classification": {
    "class": 3,
    "grade": "1+"
  },
  "entryPoints": {
    "commands": "commands/",
    "agents": "agents/",
    "skills": "skills/",
    "hooks": "hooks/hooks.json"
  },
  "memory": "CLAUDE.md",
  "settings": "templates/settings.json",
  "mcp": ".mcp.json"
}
```

**Key Fields**:

| Field | Purpose |
|-------|---------|
| `name` | Plugin identifier (used in command prefixes) |
| `entryPoints.commands` | Directory containing command definitions |
| `entryPoints.agents` | Directory containing agent definitions |
| `entryPoints.skills` | Directory containing skill modules |
| `entryPoints.hooks` | Hook configuration file path |
| `memory` | Memory file Claude reads first |

### 2.3 Memory File (CLAUDE.md)

The memory file is the **single source of truth** that Claude reads at session start. It contains:

```markdown
# Project Memory

## Classification
Class 3, Grade 1+ - Full Codebase Singularity

## Available Commands
- /prime, /plan, /build, etc.

## Agents
- orchestrator, planner, builder, reviewer, fixer, etc.

## Project Structure
[Directory layout and file descriptions]

## Coding Standards
[Conventions to follow]

## Important Rules
[Constraints and guidelines]
```

**Design Rationale**: Centralized memory prevents context drift and ensures consistent behavior across sessions.

---

## 3. Agent System Design

### 3.1 Agent Architecture

Each agent is a specialized prompt definition with YAML frontmatter:

```yaml
---
name: agent-name
description: What this agent does
tools:
  - Tool1
  - Tool2
model: opus|sonnet|haiku
---

# Agent Prompt Content

[Instructions for the agent]
```

### 3.2 Agent Hierarchy

```
                    ┌───────────────────┐
                    │   ORCHESTRATOR    │
                    │     (opus)        │
                    └─────────┬─────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│   PLANNER     │    │   BUILDER     │    │   REVIEWER    │
│   (opus)      │    │   (sonnet)    │    │   (opus)      │
└───────────────┘    └───────────────┘    └───────────────┘
        │                     │                     │
        │            ┌────────┴────────┐            │
        │            │                 │            │
        ▼            ▼                 ▼            ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ DOC-FETCHER │ │ TEST-WRITER │ │  REFACTORER │ │    FIXER    │
│  (haiku)    │ │  (sonnet)   │ │  (sonnet)   │ │  (sonnet)   │
└─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘
                                                       │
                                               ┌───────┴───────┐
                                               ▼               ▼
                                        ┌─────────────┐ ┌─────────────┐
                                        │  SECURITY   │ │    MORE     │
                                        │  AUDITOR    │ │   AGENTS    │
                                        │   (opus)    │ │    ...      │
                                        └─────────────┘ └─────────────┘
```

### 3.3 Agent Specifications

#### Orchestrator (`agents/00-orchestrator.md`)

**Purpose**: Master coordinator that decomposes complex tasks and delegates to specialized agents.

```yaml
---
name: orchestrator
description: Master coordinator for multi-agent workflows
tools:
  - Read
  - Write
  - Glob
  - Grep
  - Task
model: opus
---
```

**Key Responsibilities**:
- Task decomposition into subtasks
- Agent selection and delegation
- Parallel execution coordination
- Result aggregation
- Error recovery

**Design Decision**: Uses `opus` model for complex reasoning and coordination.

#### Planner (`agents/01-planner.md`)

**Purpose**: Strategic planning, architecture design, and research.

```yaml
---
name: planner
description: Strategic planning and architecture design
tools:
  - Read
  - Glob
  - Grep
  - WebSearch
  - WebFetch
model: opus
---
```

**Output Format**: Structured plans in `specs/plans/`

```markdown
# Plan: [Feature Name]

## Overview
[Brief description]

## Tasks
1. [Task 1]
2. [Task 2]
...

## Files to Create/Modify
- path/to/file.js - [Description]

## Dependencies
- [Dependency 1]

## Risks
- [Risk 1]
```

#### Builder (`agents/02-builder.md`)

**Purpose**: Code implementation following plans.

```yaml
---
name: builder
description: Code implementation and feature building
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
model: sonnet
---
```

**Design Decision**: Uses `sonnet` model for balance of quality and speed in code generation.

**Key Behaviors**:
- Follows existing code patterns
- Implements incrementally
- Runs tests after changes
- Documents new code

#### Reviewer (`agents/03-reviewer.md`)

**Purpose**: Quality analysis and code review.

```yaml
---
name: reviewer
description: Quality analysis and code review
tools:
  - Read
  - Grep
  - Glob
model: opus
---
```

**Output Format**: Review reports in `specs/reviews/`

```markdown
# Code Review: [Date]

## Summary
[Brief assessment]

## Score: X/10

## Findings

### Critical
- [Issue 1]

### Major
- [Issue 2]

### Minor
- [Issue 3]

## Recommendations
1. [Recommendation 1]
```

**Quality Gate**: Score must be ≥ 7/10 to pass.

#### Fixer (`agents/04-fixer.md`)

**Purpose**: Resolve issues identified in reviews.

```yaml
---
name: fixer
description: Issue resolution and bug fixing
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
model: sonnet
---
```

**Input**: Review findings from reviewer
**Output**: Fixed code and resolution report

#### Test Writer (`agents/05-test-writer.md`)

**Purpose**: Create comprehensive test suites.

```yaml
---
name: test-writer
description: Test creation and coverage improvement
tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
model: sonnet
---
```

**Coverage Targets**:
- Unit tests for all functions
- Integration tests for workflows
- Edge case coverage
- Error handling verification

#### Doc Fetcher (`agents/06-doc-fetcher.md`)

**Purpose**: Research and cache external documentation.

```yaml
---
name: doc-fetcher
description: Documentation research and caching
tools:
  - Read
  - Write
  - WebFetch
  - WebSearch
  - Glob
model: haiku
---
```

**Design Decision**: Uses `haiku` model for cost efficiency in documentation fetching.

**Output Location**: `ai_docs/[library]/[topic].md`

#### Security Auditor (`agents/07-security-auditor.md`)

**Purpose**: Security analysis and vulnerability detection.

```yaml
---
name: security-auditor
description: Security analysis and vulnerability detection
tools:
  - Read
  - Grep
  - Glob
model: opus
---
```

**Checks**:
- OWASP Top 10
- Injection vulnerabilities
- Authentication/authorization issues
- Data exposure risks
- Dependency vulnerabilities

#### Refactorer (`agents/08-refactorer.md`)

**Purpose**: Code improvement and technical debt reduction.

```yaml
---
name: refactorer
description: Code improvement and refactoring
tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
model: sonnet
---
```

**Focus Areas**:
- Code complexity reduction
- Pattern extraction
- Performance optimization
- Maintainability improvement

### 3.4 Model Selection Strategy

| Model | Cost | Speed | Use For |
|-------|------|-------|---------|
| `opus` | High | Slower | Complex reasoning, coordination, review |
| `sonnet` | Medium | Balanced | Code generation, implementation |
| `haiku` | Low | Fastest | Documentation, simple tasks |

**Design Principle**: Match model capability to task complexity for optimal cost/performance.

---

## 4. Command Implementation

### 4.1 Command Format

Commands use YAML frontmatter:

```yaml
---
name: command-name
description: What this command does
---

# Command Instructions

[Markdown content with instructions for Claude]
```

### 4.2 Command Categories

#### Core Workflow Commands

| Command | File | Purpose |
|---------|------|---------|
| `/prime` | `commands/prime.md` | Activate context |
| `/plan` | `commands/plan.md` | Create implementation plan |
| `/build` | `commands/build.md` | Implement from plan |
| `/review` | `commands/review.md` | Quality analysis |
| `/fix` | `commands/fix.md` | Address issues |

#### E2E Workflow Commands

| Command | File | Purpose |
|---------|------|---------|
| `/cycle` | `commands/cycle.md` | Complete P-B-R-F cycle |
| `/feature` | `commands/feature.md` | Full feature development |
| `/bugfix` | `commands/bugfix.md` | Bug investigation and fix |

#### Orchestration Commands

| Command | File | Purpose |
|---------|------|---------|
| `/orchestrate` | `commands/orchestrate.md` | Multi-agent coordination |
| `/delegate` | `commands/delegate.md` | Direct agent invocation |

#### Utility Commands

| Command | File | Purpose |
|---------|------|---------|
| `/setup` | `commands/setup.md` | Initialize framework |

### 4.3 Command Implementation Examples

#### Prime Command (`commands/prime.md`)

```yaml
---
name: prime
description: Activate the Codebase Singularity with full context
---

# Prime Command - Context Activation

## Purpose
Load project context and prepare for work.

## Instructions

1. Read CLAUDE.md for project memory
2. Scan project structure
3. Load relevant context for current task
4. Confirm readiness

## Output
Project context summary and available commands.
```

#### Cycle Command (`commands/cycle.md`)

```yaml
---
name: cycle
description: Complete Plan-Build-Review-Fix workflow cycle
---

# Cycle Command - Complete Workflow

## Purpose
Execute the full Plan → Build → Review → Fix cycle.

## Instructions

### Phase 1: Plan
[Instructions for planning phase]

### Phase 2: Build
[Instructions for build phase]

### Phase 3: Review
[Instructions for review phase]

### Phase 4: Fix (if needed)
[Instructions for fix phase]

## Completion Criteria
- All phases complete
- Review score ≥ 7/10
- All tests passing
```

### 4.4 Command Invocation Flow

```
User Input: /cycle Add user authentication
                           │
                           ▼
              ┌────────────────────────┐
              │  Load command/cycle.md │
              └───────────┬────────────┘
                          │
              ┌───────────▼────────────┐
              │  Parse task description │
              └───────────┬────────────┘
                          │
           ┌──────────────┴──────────────┐
           │                             │
           ▼                             ▼
    ┌─────────────┐              ┌─────────────┐
    │    PLAN     │              │  Read Plan  │
    │   Phase     │──────────────│   (if any)  │
    └──────┬──────┘              └─────────────┘
           │
           ▼
    ┌─────────────┐
    │   BUILD     │
    │   Phase     │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │   REVIEW    │◄──────────────┐
    │   Phase     │               │
    └──────┬──────┘               │
           │                      │
           ▼                      │
    ┌─────────────┐               │
    │  Score < 7? │───Yes────►┌───┴───┐
    └──────┬──────┘           │  FIX  │
           │                  │ Phase │
           No                 └───────┘
           │
           ▼
    ┌─────────────┐
    │  COMPLETE   │
    └─────────────┘
```

---

## 5. Skills Architecture

### 5.1 Skill Format (SKILL.md)

Skills follow a specific format in `skills/[skill-name]/SKILL.md`:

```markdown
---
name: skill-name
description: What this skill teaches
triggers:
  - keyword1
  - keyword2
---

# Skill Name

## Purpose
[What Claude learns from this skill]

## Prerequisites
- [Requirement 1]
- [Requirement 2]

## Commands

### Action 1
```bash
command to run
```
**When to use**: [Explanation]
**Expected output**: [What success looks like]

## Troubleshooting

### Error: [Error message]
**Cause**: [Why it happens]
**Solution**: [How to fix]
```

### 5.2 Implemented Skills

#### Git Workflow (`skills/git-workflow/SKILL.md`)

**Triggers**: `git`, `branch`, `commit`, `merge`, `pr`

**Teaches**:
- Branch naming conventions (`feature/`, `bugfix/`, `hotfix/`)
- Commit message format (type: description)
- Pull request workflow
- Merge strategies

**Key Commands**:
```bash
git checkout -b feature/[name]      # Create feature branch
git commit -m "feat: description"   # Commit with convention
git push -u origin [branch]         # Push with upstream
```

#### Testing (`skills/testing/SKILL.md`)

**Triggers**: `test`, `coverage`, `jest`, `unit test`

**Teaches**:
- Test file organization
- Test naming conventions
- Coverage targets (>80%)
- Mocking strategies

**Key Commands**:
```bash
npm test                    # Run all tests
npm test -- --coverage      # With coverage report
npm test -- --watch         # Watch mode
```

#### Code Review (`skills/code-review/SKILL.md`)

**Triggers**: `review`, `quality`, `check`, `audit`

**Teaches**:
- Review checklist
- Scoring criteria
- Finding categorization (Critical/Major/Minor)
- Constructive feedback

**Scoring Criteria**:
| Score | Meaning |
|-------|---------|
| 9-10 | Excellent, minor polish only |
| 7-8 | Good, few improvements needed |
| 5-6 | Acceptable, several issues |
| 3-4 | Needs work, significant problems |
| 1-2 | Major rewrite needed |

#### Project Workflow (`skills/project-workflow/SKILL.md`)

**Triggers**: `workflow`, `plan`, `build`, `cycle`

**Teaches**:
- Plan-Build-Review-Fix methodology
- When to use each command
- Quality gate requirements
- Workflow best practices

### 5.3 Creating New Skills

1. Create directory: `skills/[skill-name]/`
2. Create SKILL.md with YAML frontmatter
3. Define triggers for auto-activation
4. Include commands with explanations
5. Add troubleshooting section
6. Update CLAUDE.md to reference skill

---

## 6. Hooks System

### 6.1 Hook Architecture

Hooks provide lifecycle automation through shell scripts:

```
┌────────────────────────────────────────────────────────────┐
│                      HOOK LIFECYCLE                         │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  PreToolUse ──► Tool Execution ──► PostToolUse             │
│       │                                  │                  │
│       ▼                                  ▼                  │
│  [Protection]                       [Auto-lint]             │
│                                                             │
│  SubagentStop ──► Stop ──► [Quality Gate]                  │
│       │                                                     │
│       ▼                                                     │
│  [Logging]                                                  │
│                                                             │
└────────────────────────────────────────────────────────────┘
```

### 6.2 Hook Configuration (`hooks/hooks.json`)

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tools": ["Edit", "Write"],
      "script": "scripts/auto-lint.sh",
      "description": "Auto-format files after editing"
    },
    {
      "event": "PreToolUse",
      "tools": ["Edit", "Write"],
      "script": "scripts/protect-files.sh",
      "description": "Prevent editing protected files"
    },
    {
      "event": "Stop",
      "script": "scripts/quality-gate.sh",
      "description": "Verify quality before session end"
    },
    {
      "event": "SubagentStop",
      "script": "scripts/log-subagent.sh",
      "description": "Log subagent activity"
    }
  ]
}
```

### 6.3 Hook Events

| Event | When Triggered | Common Use |
|-------|----------------|------------|
| `PreToolUse` | Before a tool executes | Validation, protection |
| `PostToolUse` | After a tool executes | Formatting, logging |
| `Stop` | Session ending | Quality gates, cleanup |
| `SubagentStop` | Sub-agent completes | Logging, aggregation |

### 6.4 Hook Scripts

#### Auto-Lint (`scripts/auto-lint.sh`)

```bash
#!/bin/bash
# Auto-format files after editing

FILE_PATH="$1"
EXTENSION="${FILE_PATH##*.}"

case "$EXTENSION" in
    js|jsx|ts|tsx)
        npx prettier --write "$FILE_PATH" 2>/dev/null
        ;;
    py)
        black "$FILE_PATH" 2>/dev/null
        ;;
    json)
        npx prettier --write "$FILE_PATH" 2>/dev/null
        ;;
esac

exit 0
```

**Design Decision**: Silent execution (redirects stderr) to avoid cluttering output.

#### Protect Files (`scripts/protect-files.sh`)

```bash
#!/bin/bash
# Prevent editing protected files

FILE_PATH="$1"
PROTECTED_PATTERNS=(
    "*.lock"
    ".env"
    ".env.*"
    "package-lock.json"
    "yarn.lock"
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
    if [[ "$FILE_PATH" == $pattern ]]; then
        echo "BLOCK: Protected file: $FILE_PATH"
        exit 1
    fi
done

exit 0
```

**Return Codes**:
- `0`: Allow operation
- `1`: Block operation (with message)

#### Quality Gate (`scripts/quality-gate.sh`)

```bash
#!/bin/bash
# Verify quality before session end

REVIEW_DIR="specs/reviews"
LATEST_REVIEW=$(ls -t "$REVIEW_DIR"/*.md 2>/dev/null | head -1)

if [ -n "$LATEST_REVIEW" ]; then
    SCORE=$(grep -oP 'Score:\s*\K\d+' "$LATEST_REVIEW" | head -1)
    if [ -n "$SCORE" ] && [ "$SCORE" -lt 7 ]; then
        echo "WARNING: Latest review score ($SCORE/10) below threshold"
        echo "Consider running /fix before ending session"
    fi
fi

exit 0
```

#### Log Subagent (`scripts/log-subagent.sh`)

```bash
#!/bin/bash
# Log subagent activity

LOG_FILE="specs/agent-activity.log"
AGENT_NAME="$1"
TASK="$2"
STATUS="$3"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

mkdir -p "$(dirname "$LOG_FILE")"
echo "[$TIMESTAMP] Agent: $AGENT_NAME | Task: $TASK | Status: $STATUS" >> "$LOG_FILE"

exit 0
```

### 6.5 Creating New Hooks

1. Create script in `scripts/`
2. Add entry to `hooks/hooks.json`
3. Specify event and tools (if applicable)
4. Handle arguments appropriately
5. Return proper exit codes

---

## 7. MCP Integration

### 7.1 MCP Configuration (`.mcp.json`)

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-filesystem", "."],
      "description": "File system access"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      },
      "description": "GitHub integration"
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-memory"],
      "description": "Persistent memory across sessions"
    }
  }
}
```

### 7.2 Available MCP Servers

| Server | Purpose | Environment Variables |
|--------|---------|----------------------|
| `filesystem` | File read/write operations | None |
| `github` | Repository management | `GITHUB_TOKEN` |
| `memory` | Cross-session persistence | None |
| `postgres` | Database operations | `DATABASE_URL` |
| `slack` | Team communication | `SLACK_TOKEN` |

### 7.3 Environment Variables

Store sensitive values in environment, reference with `${VAR_NAME}`:

```bash
# .env or shell profile
export GITHUB_TOKEN="ghp_..."
export DATABASE_URL="postgresql://..."
```

### 7.4 When to Use MCP vs Skills

| Use MCP | Use Skills |
|---------|------------|
| External service integration | Local command execution |
| Real-time data access | Static instructions |
| Complex API interactions | Simple CLI tools |
| Persistent state | Ephemeral operations |

---

## 8. Orchestration Engine

### 8.1 Orchestration Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    ORCHESTRATION ENGINE                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌───────────────┐                                              │
│  │ Task Analysis │ Decompose into subtasks                      │
│  └───────┬───────┘                                              │
│          │                                                       │
│  ┌───────▼───────┐                                              │
│  │ Dependency    │ Map task dependencies                        │
│  │ Mapping       │                                              │
│  └───────┬───────┘                                              │
│          │                                                       │
│  ┌───────▼───────┐                                              │
│  │ Agent         │ Assign agents to subtasks                    │
│  │ Assignment    │                                              │
│  └───────┬───────┘                                              │
│          │                                                       │
│  ┌───────▼───────┐                                              │
│  │ Execution     │ Run tasks (parallel where possible)          │
│  │ Scheduling    │                                              │
│  └───────┬───────┘                                              │
│          │                                                       │
│  ┌───────▼───────┐                                              │
│  │ Result        │ Collect and aggregate outputs                │
│  │ Aggregation   │                                              │
│  └───────────────┘                                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 8.2 Task Decomposition

The orchestrator breaks complex tasks into subtasks:

```markdown
## Task
Add user authentication

## Subtasks

| ID | Subtask | Agent | Depends On | Parallel Group |
|----|---------|-------|------------|----------------|
| 1 | Research auth patterns | doc-fetcher | - | A |
| 2 | Design architecture | planner | - | A |
| 3 | Implement core auth | builder | 1, 2 | B |
| 4 | Add security checks | security-auditor | 3 | C |
| 5 | Write tests | test-writer | 3 | C |
| 6 | Review all | reviewer | 4, 5 | D |
```

### 8.3 Parallel Execution

Tasks in the same parallel group execute concurrently:

```
Group A: [doc-fetcher] [planner]     ← Run simultaneously
            │            │
            └─────┬──────┘
                  ▼
Group B:      [builder]               ← Wait for A
                  │
            ┌─────┴─────┐
            ▼           ▼
Group C: [security] [test-writer]     ← Run simultaneously
            │           │
            └─────┬─────┘
                  ▼
Group D:      [reviewer]              ← Wait for C
```

### 8.4 Error Handling

```
┌─────────────────────────────────────────────────────────────┐
│                    ERROR RECOVERY                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Agent Fails                                                 │
│      │                                                       │
│      ▼                                                       │
│  ┌──────────────────┐                                       │
│  │ Assess Impact    │ What downstream tasks are affected?   │
│  └────────┬─────────┘                                       │
│           │                                                  │
│      ┌────┴────┬────────┬──────────┐                        │
│      ▼         ▼        ▼          ▼                        │
│   [Retry]  [Alternate] [Skip]   [Abort]                     │
│   with      Agent      (if       Entire                     │
│   context              optional) Workflow                   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 8.5 Orchestration Patterns

#### Feature Development Pattern
```
planner → builder → test-writer → reviewer → fixer (loop) → complete
          ↑
          doc-fetcher (parallel research)
```

#### Security-First Pattern
```
planner → security-auditor → builder → security-auditor → reviewer
```

#### Test-Driven Pattern
```
planner → test-writer → builder → reviewer → fixer
```

---

## 9. The Plan-Build-Review-Fix Cycle

### 9.1 Cycle Overview

```
    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │  PLAN   │───►│  BUILD  │───►│ REVIEW  │───►│   FIX   │
    └─────────┘    └─────────┘    └─────────┘    └────┬────┘
         ▲                                            │
         └────────── Loop until quality passes ◄──────┘
```

### 9.2 Phase Details

#### PLAN Phase

**Agent**: Planner (opus)

**Input**: Feature/task description

**Process**:
1. Analyze requirements
2. Research existing patterns
3. Design architecture
4. Define tasks and dependencies
5. Estimate complexity

**Output**: `specs/plans/[date]-[feature].md`

**Quality Criteria**:
- Clear task breakdown
- Identified dependencies
- Risk assessment included

#### BUILD Phase

**Agent**: Builder (sonnet)

**Input**: Plan from PLAN phase

**Process**:
1. Read plan
2. Set up file structure
3. Implement incrementally
4. Run tests
5. Document changes

**Output**: Implementation code + changelog

**Quality Criteria**:
- Follows plan
- Tests pass
- Code follows conventions

#### REVIEW Phase

**Agent**: Reviewer (opus)

**Input**: Implementation from BUILD phase

**Process**:
1. Read all changes
2. Check against requirements
3. Analyze code quality
4. Identify issues
5. Score implementation

**Output**: `specs/reviews/[date]-review.md`

**Quality Gate**: Score ≥ 7/10 to pass

#### FIX Phase

**Agent**: Fixer (sonnet)

**Input**: Review findings

**Process**:
1. Parse review findings
2. Prioritize by severity
3. Fix each issue
4. Verify fixes
5. Update changelog

**Output**: Fixed code + resolution report

**Loop Condition**: Returns to REVIEW if changes made

### 9.3 Quality Scoring

| Category | Weight | Criteria |
|----------|--------|----------|
| Correctness | 30% | Does it work as specified? |
| Code Quality | 25% | Clean, readable, maintainable? |
| Test Coverage | 20% | Are critical paths tested? |
| Security | 15% | Any vulnerabilities? |
| Performance | 10% | Any obvious bottlenecks? |

**Score Calculation**:
```
Final Score = Σ (Category Score × Weight)
```

---

## 10. Quality Gates and Feedback Loops

### 10.1 Quality Gate Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      QUALITY GATES                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Gate 1: Plan Approval                                          │
│  ├── Human review of plan                                        │
│  └── Explicit approval required                                  │
│                                                                  │
│  Gate 2: Test Passage                                            │
│  ├── All tests must pass                                         │
│  └── No regressions                                              │
│                                                                  │
│  Gate 3: Review Score                                            │
│  ├── Score ≥ 7/10                                                │
│  └── No critical findings                                        │
│                                                                  │
│  Gate 4: Security Check (optional)                               │
│  ├── No high-severity vulnerabilities                            │
│  └── Security auditor approval                                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 10.2 Feedback Loop Implementation

```
┌─────────────────────────────────────────────────────────────────┐
│                     FEEDBACK LOOPS                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Loop 1: Build-Review-Fix                                        │
│  ┌────────────────────────────────────────────────────────┐     │
│  │                                                         │     │
│  │  BUILD ──► REVIEW ──► Score < 7? ──Yes──► FIX ────┐    │     │
│  │    ▲                      │                        │    │     │
│  │    │                      No                       │    │     │
│  │    │                      │                        │    │     │
│  │    └──────────────────────┼────────────────────────┘    │     │
│  │                           ▼                              │     │
│  │                       COMPLETE                           │     │
│  │                                                         │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
│  Loop 2: Hook-Based Auto-Fix                                     │
│  ┌────────────────────────────────────────────────────────┐     │
│  │                                                         │     │
│  │  Edit ──► PostToolUse ──► auto-lint.sh ──► Fixed File  │     │
│  │                                                         │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
│  Loop 3: Agent Self-Correction                                   │
│  ┌────────────────────────────────────────────────────────┐     │
│  │                                                         │     │
│  │  Agent Output ──► Validation ──► Error? ──► Retry      │     │
│  │                       │                                 │     │
│  │                       OK                                │     │
│  │                       │                                 │     │
│  │                       ▼                                 │     │
│  │                   Continue                              │     │
│  │                                                         │     │
│  └────────────────────────────────────────────────────────┘     │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 10.3 Automated Quality Checks

| Check | Trigger | Action |
|-------|---------|--------|
| Lint | PostToolUse (Edit/Write) | Auto-format |
| Tests | Build completion | Run test suite |
| Review | Build completion | Generate review |
| Security | Pre-deploy | Vulnerability scan |

---

## 11. Extending the Framework

### 11.1 Adding New Agents

1. **Create agent file**: `agents/XX-agent-name.md`

```yaml
---
name: agent-name
description: What this agent does
tools:
  - RequiredTool1
  - RequiredTool2
model: opus|sonnet|haiku
---

# Agent Name

## Role
[Description of the agent's role]

## Responsibilities
- [Responsibility 1]
- [Responsibility 2]

## Process
1. [Step 1]
2. [Step 2]

## Output Format
[Expected output structure]
```

2. **Update CLAUDE.md** to reference new agent

3. **Update delegate command** if needed

4. **Test agent** with `/delegate [agent] [task]`

### 11.2 Adding New Commands

1. **Create command file**: `commands/command-name.md`

```yaml
---
name: command-name
description: What this command does
---

# Command Name

## Purpose
[What this command achieves]

## When to Use
- [Scenario 1]
- [Scenario 2]

## Instructions
[Step-by-step process]

## Expected Output
[What should happen]
```

2. **Update CLAUDE.md** with command reference

3. **Test command** with `/command-name`

### 11.3 Adding New Skills

1. **Create skill directory**: `skills/skill-name/`

2. **Create SKILL.md**:

```yaml
---
name: skill-name
description: What this skill teaches
triggers:
  - keyword1
  - keyword2
---

# Skill Name

## Purpose
[What Claude learns]

## Commands
[Available commands with explanations]

## Troubleshooting
[Common errors and solutions]
```

3. **Update CLAUDE.md** to reference skill

### 11.4 Adding New Hooks

1. **Create script**: `scripts/hook-script.sh`

```bash
#!/bin/bash
# Description of what this hook does

# Arguments vary by event type
ARG1="$1"
ARG2="$2"

# Your logic here

# Exit codes:
# 0 = success/allow
# 1 = block operation (PreToolUse)
exit 0
```

2. **Update hooks.json**:

```json
{
  "event": "EventType",
  "tools": ["Tool1", "Tool2"],
  "script": "scripts/hook-script.sh",
  "description": "What this hook does"
}
```

3. **Make script executable**:
```bash
chmod +x scripts/hook-script.sh
```

---

## 12. Testing and Debugging

### 12.1 Testing Agents

```markdown
# Agent Test: [Agent Name]

## Test Case 1: [Description]

### Input
[Task to give the agent]

### Expected Output
[What the agent should produce]

### Actual Output
[Fill in when testing]

### Pass/Fail
[Result]
```

### 12.2 Testing Commands

```markdown
# Command Test: /[command]

## Test Case 1: [Description]

### Preconditions
- [What must be true before testing]

### Input
/[command] [arguments]

### Expected Behavior
[What should happen]

### Actual Behavior
[Fill in when testing]

### Pass/Fail
[Result]
```

### 12.3 Debugging Workflow

1. **Check CLAUDE.md**: Is it being read correctly?
2. **Check command file**: Is syntax correct?
3. **Check agent output**: What did the agent produce?
4. **Check hooks**: Are they executing?
5. **Check logs**: `specs/agent-activity.log`

### 12.4 Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Agent not found | Wrong name in delegate | Check agent filename |
| Command not working | Syntax error in YAML | Validate frontmatter |
| Hook not executing | Script not executable | `chmod +x script.sh` |
| Quality gate fails | Score below threshold | Run `/fix` |
| Orchestration hangs | Circular dependency | Review task graph |

### 12.5 Logging and Monitoring

**Agent Activity Log**: `specs/agent-activity.log`
```
[2026-01-01T12:00:00Z] Agent: builder | Task: Implement login | Status: complete
[2026-01-01T12:05:00Z] Agent: reviewer | Task: Review login | Status: complete
```

**Review History**: `specs/reviews/`
- Chronological review files
- Score history for trend analysis

---

## 13. Implementation Reference

### 13.1 File Templates

#### Agent Template
```yaml
---
name: template-agent
description: Template for creating new agents
tools:
  - Read
  - Write
model: sonnet
---

# Agent Name

## Role
You are a [role description].

## Responsibilities
- Responsibility 1
- Responsibility 2
- Responsibility 3

## Constraints
- What you must NOT do
- Boundaries of your work

## Process
1. First, you...
2. Then, you...
3. Finally, you...

## Output Format
[Structure of expected output]
```

#### Command Template
```yaml
---
name: template-command
description: Template for creating new commands
---

# Command Name

## Purpose
[One sentence description]

## When to Use
- Scenario 1
- Scenario 2

## Instructions

### Step 1: [Action]
[Details]

### Step 2: [Action]
[Details]

## Expected Output
[What should happen when this command runs successfully]
```

#### Skill Template
```yaml
---
name: template-skill
description: Template for creating new skills
triggers:
  - keyword1
  - keyword2
---

# Skill Name

## Purpose
[What this skill teaches Claude]

## Prerequisites
- [Requirement 1]
- [Requirement 2]

## Commands

### Action 1
```bash
command
```
**When to use**: [Explanation]
**Expected output**: [Success criteria]

## Troubleshooting

### Error: [Message]
**Cause**: [Why]
**Solution**: [Fix]
```

### 13.2 Configuration Reference

#### Plugin Manifest Schema
```json
{
  "$schema": "...",
  "name": "string (required)",
  "version": "string (required)",
  "description": "string",
  "classification": {
    "class": "number (1-3)",
    "grade": "string (1-4, 1+)"
  },
  "entryPoints": {
    "commands": "string (directory path)",
    "agents": "string (directory path)",
    "skills": "string (directory path)",
    "hooks": "string (file path)"
  },
  "memory": "string (file path)",
  "settings": "string (file path)",
  "mcp": "string (file path)"
}
```

#### Hook Configuration Schema
```json
{
  "hooks": [
    {
      "event": "PreToolUse|PostToolUse|Stop|SubagentStop",
      "tools": ["Tool1", "Tool2"],
      "script": "string (script path)",
      "description": "string"
    }
  ]
}
```

### 13.3 Tool Reference

| Tool | Purpose | Available In |
|------|---------|--------------|
| `Read` | Read file contents | All agents |
| `Write` | Create/overwrite files | builder, fixer, doc-fetcher |
| `Edit` | Modify existing files | builder, fixer, refactorer |
| `Bash` | Execute shell commands | builder, fixer |
| `Glob` | Find files by pattern | All agents |
| `Grep` | Search file contents | All agents |
| `Task` | Invoke sub-agents | orchestrator |
| `WebSearch` | Web search | planner, doc-fetcher |
| `WebFetch` | Fetch web content | planner, doc-fetcher |

---

## 14. Glossary

| Term | Definition |
|------|------------|
| **Agent** | Specialized prompt definition for specific tasks |
| **Agentic Layer** | Collection of prompts, commands, skills, and tools |
| **Class** | Level of framework sophistication (1-3) |
| **Codebase Singularity** | Point where AI agents operate code autonomously |
| **Command** | Predefined workflow trigger (`/name`) |
| **Feedback Loop** | Self-reviewing, self-correcting automation |
| **Grade** | Sub-level within a class (1-4, 1+) |
| **Hook** | Lifecycle event handler |
| **MCP** | Model Context Protocol for external integrations |
| **Memory File** | CLAUDE.md - persistent context |
| **Orchestrator** | Agent that coordinates other agents |
| **Quality Gate** | Checkpoint requiring criteria to pass |
| **Skill** | Instructions for specific capabilities |
| **Sub-agent** | Agent invoked by orchestrator or directly |

---

## Conclusion

This Developer Guide provides complete technical documentation for the Codebase Singularity plugin. Key takeaways:

1. **Architecture**: Two-layer design (Agentic + Application)
2. **Classification**: Class 3, Grade 1+ implementation
3. **Agents**: 9 specialized agents with distinct roles
4. **Commands**: 11 workflow commands for different scenarios
5. **Quality**: Built-in quality gates and feedback loops
6. **Extensibility**: Clear patterns for adding new components

For user-focused documentation, see `USER_GUIDE.md`.
For quick start examples, see `QUICKSTART.md`.
For architecture diagrams, see `ARCHITECTURE.md`.

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
