# The Agentic Layer: Concept and Implementation

## Understanding the Foundation of Codebase Singularity

**Version**: 1.0.0
**Classification**: Class 3, Grade 1+
**Last Updated**: 2026-01-01

---

## Table of Contents

- [What is the Agentic Layer?](#what-is-the-agentic-layer)
- [The Classification System](#the-classification-system)
- [Our Implementation](#our-implementation)
- [Layer Architecture](#layer-architecture)
- [The Codebase Singularity](#the-codebase-singularity)

---

## What is the Agentic Layer?

The Agentic Layer is a **structured wrapper around your application code** that tells AI agents how to operate your codebase autonomously. It's separate from your application - it's the "control center" for AI.

Think of it this way:
- **Application Layer**: Your actual code (app/, tests/, etc.)
- **Agentic Layer**: The infrastructure that enables AI to work on your code

```
┌─────────────────────────────────────────────────────────────┐
│                      AGENTIC LAYER                          │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Memory    │ Commands │ Agents  │ Skills  │ Hooks   │   │
│  │  CLAUDE.md │ 11 cmds  │ 9 agents│ 4 skills│ 4 hooks │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                    Operates On                              │
│                           │                                 │
│                           ▼                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                 APPLICATION LAYER                    │   │
│  │                                                      │   │
│  │          app/  │  tests/  │  your actual code        │   │
│  │                                                      │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Why Separate Layers?

The Agentic Layer exists because AI agents need:

1. **Context** - Understanding what your project is about
2. **Instructions** - Knowing how to perform tasks
3. **Tools** - Access to specialized capabilities
4. **Workflows** - Structured processes to follow
5. **Quality Gates** - Standards to maintain

Without an Agentic Layer, AI operates generically. With it, AI operates with deep project understanding and structured workflows.

---

## The Classification System

IndyDevDan's framework defines a progression from basic AI assistance to full autonomous operation:

### Class 1: Foundation

Building blocks for AI-assisted development.

| Grade | Components | Purpose |
|-------|------------|---------|
| **Grade 1** | Prime prompt + Memory files | Give AI context about your project |
| **Grade 2** | Specialized sub-agents | Delegate tasks to expert agents |
| **Grade 3** | Custom tools (Skills, MCP) | Extend AI capabilities |
| **Grade 4** | Feedback loops (Hooks) | Enable self-correction |

### Class 2: Workflow Level

Complete development workflows.

| Grade | Components | Purpose |
|-------|------------|---------|
| **Grade 1** | Portable structure | Use framework in any project |
| **Grade 2** | E2E workflows | Full development cycles |

### Class 3: Orchestration

Multi-agent coordination for complex tasks.

| Grade | Components | Purpose |
|-------|------------|---------|
| **Grade 1+** | Orchestrator agent | Coordinate multiple agents |

---

## Our Implementation

This codebase implements **Class 3, Grade 1+** - the highest level.

### Class 1, Grade 1: Memory

**Files**: `CLAUDE.md`, `commands/prime.md`

The foundation - giving AI context about your project:

```
CLAUDE.md
├── Project Overview      # What this project is
├── Classification        # Current agentic level
├── Project Structure     # Directory layout
├── Available Commands    # What AI can do
├── Available Agents      # Specialized workers
├── Key Workflows         # How things work
├── Coding Standards      # Quality expectations
└── Agent Instructions    # How to behave
```

**Usage**:
```
> /project:prime
```

This loads all context, making AI aware of your project's structure, standards, and available tools.

---

### Class 1, Grade 2: Sub-Agents

**Files**: `agents/*.md`

Nine specialized agents, each with a specific role:

| Agent | Model | Specialty | Tools |
|-------|-------|-----------|-------|
| **orchestrator** | opus | Coordinates other agents | Task, Read, Write |
| **planner** | opus | Plans implementations | Read, Glob, Grep, WebSearch |
| **builder** | sonnet | Writes code | Read, Write, Edit, Bash |
| **reviewer** | opus | Reviews quality | Read, Grep, Glob |
| **fixer** | sonnet | Fixes issues | Read, Write, Edit, Bash |
| **test-writer** | sonnet | Creates tests | Read, Write, Edit |
| **doc-fetcher** | haiku | Fetches documentation | WebFetch, WebSearch, Write |
| **security-auditor** | opus | Security analysis | Read, Grep, Glob |
| **refactorer** | sonnet | Improves code | Read, Write, Edit |

**Model Selection Rationale**:
- **opus**: Complex reasoning (planning, reviewing, security)
- **sonnet**: Implementation tasks (building, fixing, testing)
- **haiku**: Simple, high-volume tasks (documentation)

**Usage**:
```
> /project:delegate planner Design authentication system
> /project:delegate security-auditor Audit the login flow
```

---

### Class 1, Grade 3: Skills & MCP

**Files**: `skills/*/SKILL.md`, `.mcp.json`

#### Skills

Reusable knowledge modules:

```
skills/
├── git-workflow/SKILL.md      # Git patterns and best practices
├── testing/SKILL.md           # Testing strategies
├── code-review/SKILL.md       # Review checklists
└── project-workflow/SKILL.md  # Development workflow patterns
```

Skills provide structured knowledge that agents reference during tasks.

#### MCP (Model Context Protocol)

External tool integrations:

```json
{
  "mcpServers": {
    "filesystem": {
      "description": "File system access for project directories"
    },
    "github": {
      "description": "GitHub integration for issues, PRs, repository management"
    },
    "memory": {
      "description": "Persistent memory for cross-session context"
    }
  }
}
```

MCP extends what agents can do beyond basic file operations.

---

### Class 1, Grade 4: Hooks

**Files**: `hooks/hooks.json`, `scripts/*.sh`

Event-driven automation that creates feedback loops:

| Hook | Event | Action |
|------|-------|--------|
| **auto-lint** | PostToolUse (Edit/Write) | Format code after editing |
| **protect-files** | PreToolUse (Edit/Write) | Block sensitive file edits |
| **log-subagent** | SubagentStop | Track agent activity |
| **quality-gate** | Stop | Verify quality before completion |

**How Hooks Enable Self-Correction**:

```
Agent edits file
       │
       ▼
PostToolUse fires
       │
       ▼
auto-lint.sh runs
       │
       ▼
Code is formatted automatically
```

This creates a self-correcting system where agents don't need to remember to format - it happens automatically.

---

### Class 2, Grade 1: Portable Structure

**Files**: `commands/init.md`, `templates/settings.json`

The framework can be initialized in any project:

```
> /project:init
```

This creates:
- `CLAUDE.md` - Project memory
- `commands/` - Workflow commands
- `agents/` - Agent definitions
- `skills/` - Skill modules
- `hooks/` - Automation hooks
- `specs/` - Plans and reviews
- `ai_docs/` - Documentation cache

**Why Portability Matters**: You can take this agentic layer to any codebase and immediately have structured AI workflows.

---

### Class 2, Grade 2: E2E Workflows

**Files**: `commands/cycle.md`, `commands/feature.md`, `commands/bugfix.md`

Complete development workflows:

#### The Cycle Command

```
> /project:cycle Add user authentication
```

Executes the full Plan-Build-Review-Fix loop:

```
┌─────────────────────────────────────────────────────────────┐
│                    /project:cycle                            │
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
> /project:feature Add notification system
```

Full feature development workflow:
```
Gather Requirements → Create Plan → Get Approval → Build → Test → Review → Fix → Complete
```

#### The Bugfix Command

```
> /project:bugfix Login fails after password change
```

Structured bug investigation:
```
Intake → Investigate → Reproduce → Plan Fix → Implement → Verify → Complete
```

---

### Class 3, Grade 1+: Orchestration

**Files**: `agents/00-orchestrator.md`, `commands/orchestrate.md`, `commands/delegate.md`

Multi-agent coordination for complex tasks:

```
> /project:orchestrate Implement complete authentication system
```

The orchestrator:

```
┌─────────────────────────────────────────────────────────────┐
│                      ORCHESTRATOR                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. ANALYZE                                                  │
│     └── Understand the complex task                          │
│                                                              │
│  2. DECOMPOSE                                                │
│     └── Break into subtasks                                  │
│         ├── Design authentication flow                       │
│         ├── Implement user registration                      │
│         ├── Implement login/logout                           │
│         ├── Add password reset                               │
│         └── Security audit                                   │
│                                                              │
│  3. DELEGATE                                                 │
│     └── Assign to specialized agents                         │
│         ├── planner → Design                                 │
│         ├── builder → Implementation                         │
│         ├── test-writer → Tests                              │
│         └── security-auditor → Security                      │
│                                                              │
│  4. COORDINATE                                               │
│     └── Run in parallel where possible                       │
│         ├── Group A: [planner] [doc-fetcher]                 │
│         ├── Group B: [builder]                               │
│         └── Group C: [test-writer] [security-auditor]        │
│                                                              │
│  5. AGGREGATE                                                │
│     └── Combine results, handle errors                       │
│                                                              │
│  6. REPORT                                                   │
│     └── Summary of completed work                            │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Layer Architecture

### Complete Structure

```
project/
│
├── AGENTIC LAYER ─────────────────────────────────────────────
│   │
│   ├── .claude-plugin/
│   │   └── plugin.json           # Plugin manifest
│   │
│   ├── CLAUDE.md                 # Project memory (Grade 1)
│   │
│   ├── commands/                 # Workflow commands
│   │   ├── prime.md              # Load context
│   │   ├── plan.md               # Create plans
│   │   ├── build.md              # Implement code
│   │   ├── review.md             # Quality analysis
│   │   ├── fix.md                # Address issues
│   │   ├── cycle.md              # Full PBRF cycle (Grade 2)
│   │   ├── feature.md            # Feature workflow
│   │   ├── bugfix.md             # Bug workflow
│   │   ├── orchestrate.md        # Multi-agent (Grade 1+)
│   │   ├── delegate.md           # Direct agent
│   │   └── init.md               # Initialize framework
│   │
│   ├── agents/                   # Specialized agents (Grade 2)
│   │   ├── 00-orchestrator.md
│   │   ├── 01-planner.md
│   │   ├── 02-builder.md
│   │   ├── 03-reviewer.md
│   │   ├── 04-fixer.md
│   │   ├── 05-test-writer.md
│   │   ├── 06-doc-fetcher.md
│   │   ├── 07-security-auditor.md
│   │   └── 08-refactorer.md
│   │
│   ├── skills/                   # Knowledge modules (Grade 3)
│   │   ├── git-workflow/
│   │   ├── testing/
│   │   ├── code-review/
│   │   └── project-workflow/
│   │
│   ├── hooks/                    # Automation (Grade 4)
│   │   └── hooks.json
│   │
│   ├── scripts/                  # Hook scripts
│   │   ├── auto-lint.sh
│   │   ├── protect-files.sh
│   │   ├── log-subagent.sh
│   │   └── quality-gate.sh
│   │
│   ├── .mcp.json                 # MCP integration (Grade 3)
│   │
│   ├── templates/                # Portable structure (Class 2)
│   │   └── settings.json
│   │
│   ├── specs/                    # Plans and reviews
│   │   ├── reviews/
│   │   └── fixes/
│   │
│   └── ai_docs/                  # Documentation cache
│
└── APPLICATION LAYER ─────────────────────────────────────────
    │
    ├── app/                      # Your application code
    │
    └── tests/                    # Your test files
```

### Data Flow

```
User Request
     │
     ▼
┌─────────────────┐
│  /project:prime │  ← Load context from CLAUDE.md
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Command       │  ← Interpret request
│  (plan/build/   │
│   review/etc)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Agent(s)      │  ← Specialized workers
│  with tools     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Hooks         │  ← Automation/validation
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Application    │  ← Your code is modified
│     Code        │
└─────────────────┘
```

---

## The Codebase Singularity

The ultimate goal is reaching the **Codebase Singularity** - the point where your AI agents can run your codebase better than you can.

### Signs You've Reached It

1. **Agents understand your codebase deeply** - They know the patterns, standards, and architecture
2. **They can plan, build, review, and fix autonomously** - The PBRF cycle runs without intervention
3. **You trust them to ship production-quality code** - Quality gates ensure standards
4. **Nothing goes to production without agent review** - Automated quality assurance
5. **Multi-agent orchestration handles complex tasks** - One command triggers coordinated work

### The Progression

```
Manual Development
       │
       ▼
AI-Assisted Development (Generic Claude)
       │
       ▼
AI-Augmented Development (Class 1)
       │
       ▼
AI-Driven Development (Class 2)
       │
       ▼
Autonomous Development (Class 3)
       │
       ▼
   ┌───────────────────────────────────┐
   │      CODEBASE SINGULARITY         │
   │                                   │
   │  "My agents run my codebase       │
   │   better than I can"              │
   │                                   │
   │  - IndyDevDan                     │
   └───────────────────────────────────┘
```

---

## Summary

The Agentic Layer is the infrastructure that transforms generic AI assistance into autonomous codebase operation:

| Component | Purpose | Class/Grade |
|-----------|---------|-------------|
| CLAUDE.md | Project memory | Class 1, Grade 1 |
| Commands | Workflow instructions | Class 1, Grade 1 |
| Agents | Specialized workers | Class 1, Grade 2 |
| Skills | Knowledge modules | Class 1, Grade 3 |
| MCP | External tools | Class 1, Grade 3 |
| Hooks | Automation | Class 1, Grade 4 |
| Init/Templates | Portability | Class 2, Grade 1 |
| Cycle/Feature/Bugfix | E2E workflows | Class 2, Grade 2 |
| Orchestrator | Multi-agent coordination | Class 3, Grade 1+ |

This implementation is complete at **Class 3, Grade 1+** - the highest level of the Agentic Layer framework.

---

## Related Documentation

- [ARCHITECTURE.md](./ARCHITECTURE.md) - Technical system design
- [DEVELOPER_GUIDE.md](./DEVELOPER_GUIDE.md) - Implementation details
- [AGENTS_REFERENCE.md](./AGENTS_REFERENCE.md) - Agent specifications
- [COMMANDS_REFERENCE.md](./COMMANDS_REFERENCE.md) - Command reference

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
