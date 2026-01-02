# User Guide: Codebase Singularity Framework

## A Complete Guide for Users of All Experience Levels

**Who This Is For**: Anyone who wants to use AI to help with coding tasks, from beginners to experienced developers.

**What You'll Learn**: How to use all commands, agents, and workflows effectively.

---

## Table of Contents

1. [Welcome! What Is This?](#1-welcome-what-is-this)
2. [Getting Started](#2-getting-started)
3. [Understanding the Framework](#3-understanding-the-framework)
4. [Core Commands](#4-core-commands)
5. [Workflow Commands](#5-workflow-commands)
6. [Orchestration Commands](#6-orchestration-commands)
7. [Working with Agents](#7-working-with-agents)
8. [Using Skills](#8-using-skills)
9. [The Plan-Build-Review-Fix Cycle](#9-the-plan-build-review-fix-cycle)
10. [Advanced Workflows](#10-advanced-workflows)
11. [Best Practices](#11-best-practices)
12. [Troubleshooting](#12-troubleshooting)
13. [Quick Reference](#13-quick-reference)

---

## 1. Welcome! What Is This?

### 1.1 The Simple Explanation

The Codebase Singularity Framework turns Claude into your AI development team. Instead of one AI assistant, you get:

- **9 specialized agents** - Each expert in their domain
- **11 workflow commands** - Pre-built development workflows
- **4 skill modules** - Reusable patterns and best practices
- **Automated quality gates** - Built-in code review and security

### 1.2 What Can You Do With It?

| Task | Command | What Happens |
|------|---------|--------------|
| Start working | `/prime` | Load full project context |
| Plan a feature | `/plan` | Create detailed implementation plan |
| Build features | `/build` | Implement from plan |
| Review code | `/review` | Quality analysis with scoring |
| Fix issues | `/fix` | Address review findings |
| Complete workflow | `/cycle` | Run Plan-Build-Review-Fix |
| Feature development | `/feature` | Full feature workflow |
| Bug fixing | `/bugfix` | Investigation and fix workflow |
| Multi-agent tasks | `/orchestrate` | Coordinate multiple agents |
| Direct agent access | `/delegate` | Use specific agent |
| New project setup | `/setup` | Initialize framework |

### 1.3 The Classification System

This framework is at **Class 3, Grade 1+** - the highest level:

```
Class 1: Foundation
├── Grade 1: Memory files ✓
├── Grade 2: Specialized agents ✓
├── Grade 3: Custom tools ✓
└── Grade 4: Feedback loops ✓

Class 2: Workflow Level
├── Grade 1: Portable layers ✓
└── Grade 2: E2E workflows ✓

Class 3: Orchestration
└── Grade 1+: Multi-agent coordination ✓
```

---

## 2. Getting Started

### 2.1 Quick Start (5 Minutes)

**Step 1: Open Terminal**

- Windows: Press `Win`, type `cmd`, press `Enter`
- Mac: Press `Cmd+Space`, type `Terminal`, press `Enter`
- Linux: Press `Ctrl+Alt+T`

**Step 2: Navigate to Your Project**

```bash
cd /path/to/your/project
```

**Step 3: Start Claude**

```bash
claude
```

**Step 4: Load Context**

```
> /prime
```

**Step 5: Start Working**

```
> /plan Add user authentication
```

### 2.2 First Session Workflow

```
1. /prime              # Always start here
2. "What's in this project?"   # Get oriented
3. /plan [task]        # Plan your work
4. /build              # Implement
5. /review             # Check quality
6. /fix                # Fix any issues
```

---

## 3. Understanding the Framework

### 3.1 The Two Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    AGENTIC LAYER                             │
│  Commands • Agents • Skills • Hooks • Memory                │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              APPLICATION LAYER                       │   │
│  │  Your actual code: backend, frontend, database       │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 Key Components

| Component | What It Is | Where It Lives |
|-----------|-----------|----------------|
| **CLAUDE.md** | Project memory | Project root |
| **Commands** | Workflow triggers | `/commands/` |
| **Agents** | Specialized workers | `/agents/` |
| **Skills** | Knowledge modules | `/skills/` |
| **Hooks** | Automation scripts | `/hooks/` |
| **Specs** | Plans and reviews | `/specs/` |

### 3.3 The Core Workflow

Everything revolves around the **Plan-Build-Review-Fix** cycle:

```
    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │  PLAN   │───►│  BUILD  │───►│ REVIEW  │───►│   FIX   │
    └─────────┘    └─────────┘    └─────────┘    └────┬────┘
         ▲                                            │
         └────────── Loop until quality passes ◄──────┘
```

---

## 4. Core Commands

### 4.1 `/prime` - Load Context

**When to Use**: At the start of every session

**What It Does**:
1. Reads CLAUDE.md (project memory)
2. Scans project structure
3. Loads coding standards
4. Prepares agents for work

**Example**:
```
> /prime

Project Loaded: Codebase Singularity Framework

This is a Class 3, Grade 1+ agentic layer with full
orchestration capabilities.

Available Commands: prime, plan, build, review, fix,
cycle, feature, bugfix, orchestrate, delegate, init

What would you like to work on?
```

### 4.2 `/plan` - Create Implementation Plan

**When to Use**: Before implementing any feature

**What It Does**:
1. Analyzes requirements
2. Reviews existing code
3. Researches solutions
4. Creates detailed plan
5. Gets your approval

**Example**:
```
> /plan Add JWT authentication

Creating implementation plan...

# Implementation Plan: JWT Authentication

## Overview
Add JWT-based authentication with login, logout, and
protected route middleware.

## Files to Create
- app/middleware/auth.js
- app/routes/authRoutes.js
- app/services/authService.js

## Implementation Steps
1. Create JWT utilities...
2. Create auth middleware...
3. Create auth routes...

Approve this plan? (y/n)
```

**Output**: Saved to `specs/[feature]-plan.md`

### 4.3 `/build` - Implement Features

**When to Use**: After plan is approved

**What It Does**:
1. Reads the approved plan
2. Creates/modifies files
3. Implements logic
4. Adds error handling
5. Creates basic tests

**Example**:
```
> /build

Reading plan: specs/jwt-auth-plan.md

Creating: app/middleware/auth.js
[Shows code preview]
Approve? (y/n)

Creating: app/routes/authRoutes.js
[Shows code preview]
Approve? (y/n)

Implementation complete!
Files created: 3
Tests added: 5
```

### 4.4 `/review` - Code Quality Review

**When to Use**: After implementation, before committing

**What It Does**:
1. Checks code quality
2. Verifies logic
3. Security analysis
4. Performance check
5. Generates report

**Example**:
```
> /review

Reviewing recent changes...

# Code Review Report

| Category | Score | Issues |
|----------|-------|--------|
| Code Quality | 8/10 | 2 |
| Security | 7/10 | 1 |
| Testing | 9/10 | 0 |

**Overall Score: 8/10**

## Issues Found

### High Priority
1. Missing input validation in authRoutes.js:25

## What's Good
- Clean function structure
- Comprehensive error handling
```

**Output**: Saved to `specs/reviews/[date]-review.md`

### 4.5 `/fix` - Address Issues

**When to Use**: After review identifies issues

**What It Does**:
1. Reads review findings
2. Prioritizes by severity
3. Implements fixes
4. Verifies each fix
5. Re-runs affected tests

**Example**:
```
> /fix

Reading review: specs/reviews/2026-01-01-review.md

Issues to fix: 3

Fixing: Missing input validation
[Shows fix preview]
Apply? (y/n)

Fixed: 3/3 issues
All tests passing
```

---

## 5. Workflow Commands

### 5.1 `/cycle` - Complete Development Cycle

**When to Use**: For end-to-end feature development

**What It Does**: Runs the complete Plan-Build-Review-Fix cycle

**Options**:
- `--quick` - Skip deep review
- `--thorough` - Deep review + security audit

**Example**:
```
> /cycle Add password reset feature

## Phase 1: Planning
[Planner creates plan]
Approve plan? (y/n)

## Phase 2: Building
[Builder implements]
Created 4 files

## Phase 3: Review
Score: 7/10 - Issues found

## Phase 4: Fix
[Fixer addresses issues]

## Phase 3: Review (Iteration 2)
Score: 9/10 - Passed!

# Cycle Complete!
Quality: 9/10
Ready to commit
```

### 5.2 `/feature` - Feature Development Workflow

**When to Use**: For comprehensive feature development with all steps

**What It Does**:
1. Research (optional)
2. Specification
3. Planning
4. Implementation
5. Testing
6. Review
7. Fix
8. Security audit (optional)
9. Documentation (optional)
10. Finalization

**Options**:
- `--with-docs` - Include documentation step
- `--with-security` - Include security audit

**Example**:
```
> /feature --with-security Add user profiles

## Step 1: Research
[doc-fetcher researches patterns]

## Step 2: Specification
[Creates feature spec]
Confirm? (y/n)

## Step 3-6: [Development phases]

## Step 8: Security Audit
[security-auditor checks for vulnerabilities]

# Feature Complete!
```

### 5.3 `/bugfix` - Bug Investigation Workflow

**When to Use**: When a bug is reported

**What It Does**:
1. Intake bug report
2. Investigate root cause
3. Plan fix approach
4. Implement fix
5. Add regression test
6. Verify resolution

**Example**:
```
> /bugfix Login fails after password change

## Phase 1: Intake
Bug: Login fails after password change
Severity: High

## Phase 2: Investigate
[reviewer investigates]
Root cause: Password hash not saved to database

## Phase 3: Plan Fix
Approach: Add await user.save() after hash update
Approve? (y/n)

## Phase 4: Implement
[fixer applies fix + regression test]

## Phase 5: Verify
- Bug fixed: ✓
- Test added: ✓
- All tests pass: ✓

# Bug Fixed!
```

---

## 6. Orchestration Commands

### 6.1 `/orchestrate` - Multi-Agent Coordination

**When to Use**: For complex tasks requiring multiple agents

**What It Does**:
1. Analyzes task complexity
2. Decomposes into subtasks
3. Assigns agents
4. Manages dependencies
5. Runs parallel when possible
6. Aggregates results

**Options**:
- `--parallel` - Maximize parallel execution
- `--sequential` - Force sequential execution
- `--plan-only` - Show plan without executing

**Example**:
```
> /orchestrate Add e-commerce checkout flow

# Orchestration Plan

| Task | Agent | Depends On |
|------|-------|------------|
| Research patterns | doc-fetcher | - |
| Design architecture | planner | 1 |
| Implement cart | builder | 2 |
| Implement payment | builder | 2 |
| Write tests | test-writer | 3,4 |
| Security audit | security-auditor | 3,4 |
| Review all | reviewer | 5,6 |

Executing...

[■■■■■■■■□□] 80% Complete

# Orchestration Complete!
Agents used: 5
Subtasks: 7
Duration: 15 minutes
```

### 6.2 `/delegate` - Direct Agent Invocation

**When to Use**: When you need a specific agent

**Syntax**: `/delegate [agent] [task]`

**Available Agents**:

| Agent | Use For |
|-------|---------|
| `planner` | Architecture, planning |
| `builder` | Code implementation |
| `reviewer` | Code review |
| `fixer` | Bug fixes |
| `test-writer` | Test creation |
| `doc-fetcher` | Documentation |
| `security-auditor` | Security review |
| `refactorer` | Code improvement |

**Examples**:
```
> /delegate planner Design the API structure

> /delegate security-auditor Audit the auth module

> /delegate test-writer Add tests for userService

> /delegate refactorer Clean up the utils folder
```

---

## 7. Working with Agents

### 7.1 Agent Overview

Each agent is a specialist:

| Agent | Specialty | Model | Best For |
|-------|-----------|-------|----------|
| **orchestrator** | Coordination | opus | Complex multi-step tasks |
| **planner** | Strategy | opus | Architecture decisions |
| **builder** | Implementation | sonnet | Writing code |
| **reviewer** | Quality | opus | Finding issues |
| **fixer** | Resolution | sonnet | Bug fixes |
| **test-writer** | Testing | sonnet | Test coverage |
| **doc-fetcher** | Research | haiku | Finding docs |
| **security-auditor** | Security | opus | Vulnerability detection |
| **refactorer** | Improvement | sonnet | Code cleanup |

### 7.2 When to Use Which Agent

**Use planner when**:
- Starting a new feature
- Making architecture decisions
- Comparing approaches

**Use builder when**:
- Implementing from a plan
- Creating new files
- Adding features

**Use reviewer when**:
- After implementation
- Before committing
- Periodic quality checks

**Use fixer when**:
- After review finds issues
- Bugs are reported
- Quick patches needed

**Use test-writer when**:
- New code needs tests
- Coverage is low
- Edge cases need testing

**Use doc-fetcher when**:
- Need API documentation
- Researching libraries
- Finding best practices

**Use security-auditor when**:
- Handling sensitive data
- Authentication/authorization
- Before production release

**Use refactorer when**:
- Code is messy
- Patterns are inconsistent
- Technical debt cleanup

### 7.3 Agent Workflows

**Feature Development**:
```
planner → builder → test-writer → reviewer → fixer
```

**Security-First Development**:
```
planner → security-auditor → builder → security-auditor → reviewer
```

**Bug Fix**:
```
reviewer (investigate) → fixer → test-writer → reviewer (verify)
```

---

## 8. Using Skills

### 8.1 What Are Skills?

Skills are knowledge modules that provide patterns and best practices:

| Skill | Provides |
|-------|----------|
| **git-workflow** | Git patterns, commit conventions |
| **testing** | Test patterns, coverage strategies |
| **code-review** | Review checklists, quality criteria |
| **project-workflow** | Development workflows, processes |

### 8.2 Skill Triggers

Skills activate automatically when relevant keywords appear:

| Skill | Triggers |
|-------|----------|
| git-workflow | git, branch, commit, merge, PR |
| testing | test, tests, coverage, unit test |
| code-review | review, audit, quality check |
| project-workflow | workflow, cycle, process |

### 8.3 Using Skills Explicitly

You can reference skills directly:

```
> Following the git-workflow skill, create a feature branch
> for user authentication

> Using the testing skill patterns, write comprehensive
> tests for the validation module
```

---

## 9. The Plan-Build-Review-Fix Cycle

### 9.1 Overview

This is the core workflow for all development:

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│   ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐│
│   │  PLAN   │───►│  BUILD  │───►│ REVIEW  │───►│   FIX   ││
│   │ planner │    │ builder │    │reviewer │    │  fixer  ││
│   └─────────┘    └─────────┘    └─────────┘    └────┬────┘│
│        ▲                                            │      │
│        │              Loop until                    │      │
│        └────────────  score ≥ 7/10 ◄────────────────┘      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 9.2 Phase Details

**PLAN Phase**:
- Understand requirements
- Analyze existing code
- Research solutions
- Create implementation plan
- Get user approval

**BUILD Phase**:
- Follow the plan
- Create/modify files
- Implement logic
- Add error handling
- Create basic tests

**REVIEW Phase**:
- Check code quality
- Verify logic
- Security analysis
- Performance check
- Generate report with score

**FIX Phase**:
- Read findings
- Prioritize by severity
- Implement fixes
- Verify each fix
- Loop back to review

### 9.3 Quality Gates

| Phase | Gate | Requirement |
|-------|------|-------------|
| PLAN | User approval | Must approve before building |
| BUILD | Syntax valid | No errors, patterns followed |
| REVIEW | Score ≥ 7/10 | Must pass to complete |
| FIX | All critical fixed | No critical issues remaining |

### 9.4 Manual vs Automatic

**Manual (step by step)**:
```
> /plan [feature]
[Review and approve]
> /build
[Review and approve]
> /review
[Read report]
> /fix
[Verify fixes]
```

**Automatic (complete cycle)**:
```
> /cycle [feature]
[Runs all phases automatically]
```

---

## 10. Advanced Workflows

### 10.1 Parallel Agent Execution

For complex tasks, agents can run in parallel:

```
> /orchestrate --parallel Add analytics dashboard

Parallel execution:
├── Group A: [planner, doc-fetcher] ──► Group B
├── Group B: [builder-charts, builder-data]
├── Group C: [test-writer, security-auditor]
└── Group D: [reviewer]
```

### 10.2 Feature Branch Workflow

```
1. /prime
2. /plan [feature]
3. git checkout -b feature/[name]
4. /cycle [feature]
5. git commit -m "feat: [feature]"
6. Create PR
```

### 10.3 Security-First Development

```
1. /plan [feature]
2. /delegate security-auditor Review the plan
3. /build
4. /delegate security-auditor Audit implementation
5. /review
6. /fix
```

### 10.4 Test-Driven Development

```
1. /plan [feature]
2. /delegate test-writer Write tests first
3. /build (tests should now pass)
4. /review
5. /fix
```

---

## 11. Best Practices

### 11.1 Always Start with Prime

```
> /prime
```

This ensures Claude has full project context.

### 11.2 Plan Before Building

For anything non-trivial:
```
> /plan [feature]
```

Review the plan before proceeding.

### 11.3 Review Everything

Run reviews:
- After implementation
- Before committing
- Periodically for maintenance

### 11.4 Use the Right Granularity

| Task Complexity | Command |
|-----------------|---------|
| Simple fix | `/fix` |
| Single function | `/build` |
| Small feature | `/cycle` |
| Large feature | `/feature` |
| Complex multi-part | `/orchestrate` |

### 11.5 Iterate Until Quality

Don't accept low review scores:
```
Review score: 5/10 ← Too low
/fix
Review score: 7/10 ← Acceptable
/fix
Review score: 9/10 ← Excellent
```

---

## 12. Troubleshooting

### 12.1 Common Issues

**"Claude doesn't understand my project"**
```
> /prime
```
Always reload context first.

**"Command not found"**
- Check command spelling
- Ensure you're in project directory
- Commands start with `/`

**"Review score is low"**
- Run `/fix` to address issues
- Re-run review after fixes
- Iterate until score ≥ 7

**"Agent isn't doing what I want"**
- Be more specific in your request
- Provide examples
- Break into smaller tasks

### 12.2 Getting Help

```
> What commands are available?
> Show me how to use /cycle
> Explain what the reviewer agent does
```

---

## 13. Quick Reference

### Command Cheat Sheet

```bash
# Starting up
/prime              # Load context (always first!)

# Core workflow
/plan [feature]     # Create plan
/build              # Implement
/review             # Quality check
/fix                # Address issues

# Complete workflows
/cycle [feature]    # Full PBRF cycle
/feature [feature]  # Complete feature workflow
/bugfix [bug]       # Bug investigation

# Orchestration
/orchestrate [task] # Multi-agent coordination
/delegate [agent] [task]  # Direct agent access

# Setup
/setup               # Initialize in new project
```

### Agent Quick Reference

```bash
# Planning
/delegate planner [task]

# Building
/delegate builder [task]

# Reviewing
/delegate reviewer [task]

# Fixing
/delegate fixer [task]

# Testing
/delegate test-writer [task]

# Research
/delegate doc-fetcher [task]

# Security
/delegate security-auditor [task]

# Refactoring
/delegate refactorer [task]
```

### Workflow Templates

**New Feature**:
```
/prime
/feature --with-docs Add [feature]
```

**Bug Fix**:
```
/prime
/bugfix [bug description]
```

**Code Cleanup**:
```
/prime
/delegate refactorer Clean up [area]
/review
```

**Security Audit**:
```
/prime
/delegate security-auditor Full security review
/fix
```

---

*Last updated: 2026-01-01*
*Version: 2.0.0*
