# Commands Reference: Codebase Singularity

## Complete Reference for All 11 Commands

This document provides detailed documentation for every command in the Codebase Singularity plugin.

---

## Table of Contents

1. [Command Overview](#command-overview)
2. [Core Workflow Commands](#core-workflow-commands)
   - [prime](#prime)
   - [plan](#plan)
   - [build](#build)
   - [review](#review)
   - [fix](#fix)
3. [E2E Workflow Commands](#e2e-workflow-commands)
   - [cycle](#cycle)
   - [feature](#feature)
   - [bugfix](#bugfix)
4. [Orchestration Commands](#orchestration-commands)
   - [orchestrate](#orchestrate)
   - [delegate](#delegate)
5. [Utility Commands](#utility-commands)
   - [init](#init)
6. [Command Comparison Matrix](#command-comparison-matrix)

---

## Command Overview

### Command Categories

| Category | Commands | Purpose |
|----------|----------|---------|
| **Core Workflow** | prime, plan, build, review, fix | Individual workflow phases |
| **E2E Workflow** | cycle, feature, bugfix | Complete workflows |
| **Orchestration** | orchestrate, delegate | Multi-agent coordination |
| **Utility** | init | Setup and configuration |

### Quick Reference

```
/project:prime          Load project context
/project:plan [task]    Create implementation plan
/project:build          Implement from plan
/project:review         Quality analysis
/project:fix            Address issues

/project:cycle [task]   Complete P-B-R-F cycle
/project:feature [desc] Full feature development
/project:bugfix [desc]  Bug investigation and fix

/project:orchestrate [task]    Multi-agent coordination
/project:delegate [agent] [task] Direct agent invocation

/project:init           Initialize framework in new project
```

---

## Core Workflow Commands

### prime

**Full Name**: `/project:prime`

**Purpose**: Activate the Codebase Singularity by loading full project context.

**File**: `commands/prime.md`

#### Syntax

```
/project:prime
/project:prime [specific focus]
```

#### Description

The prime command is the **first command** you should run in any session. It:

1. Reads CLAUDE.md (memory file)
2. Scans project structure
3. Loads relevant context
4. Confirms readiness for work

#### Examples

```
> /project:prime
```
*Loads full project context*

```
> /project:prime Focus on the authentication module
```
*Loads context with emphasis on auth*

#### Output

```
Project Context Loaded

Classification: Class 3, Grade 1+
Working Directory: /path/to/project

Available Commands:
- /project:plan, /project:build, /project:review, /project:fix
- /project:cycle, /project:feature, /project:bugfix
- /project:orchestrate, /project:delegate

Ready for work.
```

#### When to Use

- At the start of every session
- After significant context switches
- When Claude seems to have lost context
- Before major operations

---

### plan

**Full Name**: `/project:plan`

**Purpose**: Create a detailed implementation plan before building.

**File**: `commands/plan.md`

**Agent Used**: planner (opus)

#### Syntax

```
/project:plan [task description]
```

#### Description

The plan command creates a structured implementation plan that includes:

- Task breakdown
- File structure
- Dependencies
- Risk assessment
- Estimated complexity

#### Examples

```
> /project:plan Add user authentication with JWT
```

```
> /project:plan Refactor the payment processing module
```

```
> /project:plan Create REST API for user management
```

#### Output Location

Plans are saved to: `specs/plans/[date]-[feature].md`

#### Output Format

```markdown
# Plan: [Feature Name]

## Overview
[Brief description of the feature]

## Requirements
1. [Requirement 1]
2. [Requirement 2]

## Tasks
1. [ ] Task 1
   - Details
   - Acceptance criteria
2. [ ] Task 2
   - Details
   - Acceptance criteria

## Files to Create/Modify
- `path/to/file.js` - [Description]
- `path/to/test.js` - [Description]

## Dependencies
- [External library]
- [Internal module]

## Risks
- [Risk 1] - Mitigation: [approach]
- [Risk 2] - Mitigation: [approach]

## Estimated Complexity
[Low/Medium/High]
```

#### When to Use

- Before implementing any non-trivial feature
- When you need to think through an approach
- Before making architectural decisions
- When working on complex refactoring

---

### build

**Full Name**: `/project:build`

**Purpose**: Implement code based on an existing plan.

**File**: `commands/build.md`

**Agent Used**: builder (sonnet)

#### Syntax

```
/project:build
/project:build [specific guidance]
```

#### Description

The build command implements code following an existing plan. It:

1. Reads the most recent plan from `specs/plans/`
2. Creates file structure
3. Implements code incrementally
4. Runs tests
5. Documents changes

#### Examples

```
> /project:build
```
*Builds from most recent plan*

```
> /project:build Focus on the core module first
```
*Builds with specific priority*

#### Behavior

- Follows existing code patterns
- Implements in small increments
- Runs tests after each major change
- Documents new code with comments
- Reports progress

#### Output

- New files created in `app/` or `src/`
- Tests created in `tests/`
- Changelog update

#### When to Use

- After `/project:plan` completes
- When you have an approved plan
- To continue interrupted implementation

---

### review

**Full Name**: `/project:review`

**Purpose**: Analyze code quality and produce a review report.

**File**: `commands/review.md`

**Agent Used**: reviewer (opus)

#### Syntax

```
/project:review
/project:review [specific files or focus]
```

#### Description

The review command performs comprehensive code review:

1. Analyzes recent changes
2. Checks code quality
3. Identifies issues
4. Produces a scored report

#### Examples

```
> /project:review
```
*Reviews recent changes*

```
> /project:review app/services/
```
*Reviews specific directory*

```
> /project:review Focus on security
```
*Reviews with security emphasis*

#### Output Location

Reviews are saved to: `specs/reviews/[date]-review.md`

#### Output Format

```markdown
# Code Review: [Date]

## Summary
[Brief assessment of the code]

## Score: X/10

## Findings

### Critical
- [ ] [Issue 1]
  - Location: `file.js:42`
  - Problem: [description]
  - Recommendation: [fix]

### Major
- [ ] [Issue 2]
  - Location: `file.js:78`
  - Problem: [description]
  - Recommendation: [fix]

### Minor
- [ ] [Issue 3]
  - Location: `file.js:123`
  - Problem: [description]
  - Recommendation: [fix]

## Positive Highlights
- [Good practice found]
- [Well-implemented feature]

## Recommendations
1. [Recommendation 1]
2. [Recommendation 2]
```

#### Scoring Criteria

| Category | Weight | Description |
|----------|--------|-------------|
| Correctness | 30% | Does it work as specified? |
| Code Quality | 25% | Clean, readable, maintainable? |
| Test Coverage | 20% | Are critical paths tested? |
| Security | 15% | Any vulnerabilities? |
| Performance | 10% | Any obvious bottlenecks? |

#### Quality Gate

- **Pass**: Score ≥ 7/10
- **Fail**: Score < 7/10 (triggers fix phase)

#### When to Use

- After `/project:build` completes
- Before committing code
- For periodic code audits
- When you want quality assessment

---

### fix

**Full Name**: `/project:fix`

**Purpose**: Address issues identified in code review.

**File**: `commands/fix.md`

**Agent Used**: fixer (sonnet)

#### Syntax

```
/project:fix
/project:fix [specific focus]
```

#### Description

The fix command resolves issues from the most recent review:

1. Reads review report
2. Prioritizes by severity
3. Fixes each issue
4. Verifies fixes
5. Triggers re-review

#### Examples

```
> /project:fix
```
*Fixes all issues from latest review*

```
> /project:fix --critical-only
```
*Fixes only critical issues*

```
> /project:fix Focus on security issues
```
*Prioritizes security fixes*

#### Behavior

- Fixes in priority order: Critical → Major → Minor
- Verifies each fix
- May add tests for regression prevention
- Documents fixes made

#### Output

- Fixed code files
- Updated tests (if needed)
- Resolution report

#### When to Use

- After `/project:review` with score < 7
- When there are known issues to fix
- As part of the build-review-fix loop

---

## E2E Workflow Commands

### cycle

**Full Name**: `/project:cycle`

**Purpose**: Execute complete Plan-Build-Review-Fix workflow.

**File**: `commands/cycle.md`

**Agents Used**: planner, builder, reviewer, fixer

#### Syntax

```
/project:cycle [task description]
```

#### Description

The cycle command runs the complete development workflow:

```
PLAN → BUILD → REVIEW → FIX (loop until score ≥ 7)
```

#### Examples

```
> /project:cycle Add user registration
```

```
> /project:cycle Implement caching layer
```

```
> /project:cycle Refactor database access
```

#### Workflow

1. **Plan Phase**
   - Creates implementation plan
   - Waits for user approval

2. **Build Phase**
   - Implements from plan
   - Runs tests

3. **Review Phase**
   - Analyzes code quality
   - Produces scored report

4. **Fix Phase** (if score < 7)
   - Addresses issues
   - Returns to Review

5. **Completion**
   - When score ≥ 7
   - Summary report

#### Output

- Plan in `specs/plans/`
- Code in `app/` or `src/`
- Tests in `tests/`
- Review in `specs/reviews/`

#### When to Use

- For complete feature implementation
- When you want automatic quality assurance
- For consistent development process

---

### feature

**Full Name**: `/project:feature`

**Purpose**: Full feature development with requirements gathering.

**File**: `commands/feature.md`

**Agents Used**: planner, builder, reviewer, fixer, test-writer

#### Syntax

```
/project:feature [feature description]
```

#### Description

The feature command is an enhanced cycle that includes:

1. Requirements gathering (may ask questions)
2. Detailed planning
3. User approval gate
4. Implementation with tests
5. Quality review
6. Fix loop until passing

#### Examples

```
> /project:feature Add user notifications with email and in-app support
```

```
> /project:feature Create admin dashboard for user management
```

#### Differences from Cycle

| Aspect | cycle | feature |
|--------|-------|---------|
| Requirements | Assumes complete | May ask questions |
| Planning | Basic | Detailed with alternatives |
| Tests | Included | Comprehensive |
| Documentation | Basic | Full |

#### When to Use

- For new features
- When requirements need clarification
- For user-facing functionality
- When comprehensive tests needed

---

### bugfix

**Full Name**: `/project:bugfix`

**Purpose**: Structured bug investigation and fix.

**File**: `commands/bugfix.md`

**Agents Used**: reviewer (investigation), planner, fixer

#### Syntax

```
/project:bugfix [bug description]
/project:bugfix --issue [issue-number]
/project:bugfix --regression [feature]
```

#### Description

The bugfix command follows a systematic approach:

1. **Intake**: Gather bug information
2. **Investigate**: Reproduce and locate
3. **Plan**: Design fix approach
4. **Implement**: Fix with test-first approach
5. **Verify**: Confirm fix and no regressions

#### Examples

```
> /project:bugfix Login fails after password change
```

```
> /project:bugfix --issue 234
```

```
> /project:bugfix --regression authentication
```

#### Investigation Checklist

- [ ] Can reproduce consistently
- [ ] Located the failing code
- [ ] Understood root cause
- [ ] Identified all affected areas
- [ ] Checked for related issues

#### Output Format

```markdown
# Bug Fix Complete

## Bug
[Original description]

## Root Cause
[What caused the bug]

## Fix Applied
- File: `path/to/file.js`
- Change: [Description]

## Tests Added
- `test/unit/file.test.js`
  - "should handle [edge case]"

## Verification
- [x] Original bug fixed
- [x] Regression test passes
- [x] All tests pass
- [x] No new issues
```

#### When to Use

- For reported bugs
- For test failures
- For production issues
- When you need systematic debugging

---

## Orchestration Commands

### orchestrate

**Full Name**: `/project:orchestrate`

**Purpose**: Coordinate multiple agents for complex tasks.

**File**: `commands/orchestrate.md`

**Agent Used**: orchestrator (opus)

#### Syntax

```
/project:orchestrate [task description]
/project:orchestrate --parallel [task]
/project:orchestrate --sequential [task]
/project:orchestrate --plan-only [task]
```

#### Description

The orchestrate command coordinates multiple specialized agents:

1. **Analyze**: Decompose task into subtasks
2. **Map**: Identify dependencies
3. **Assign**: Select agent for each subtask
4. **Execute**: Run tasks (parallel where possible)
5. **Aggregate**: Combine results

#### Examples

```
> /project:orchestrate Implement complete authentication system
```

```
> /project:orchestrate --parallel Create data export feature
```

```
> /project:orchestrate --plan-only Design API structure
```

#### Execution Modes

| Mode | Description |
|------|-------------|
| Default | Optimize parallel/sequential automatically |
| `--parallel` | Maximize parallelism |
| `--sequential` | Force sequential execution |
| `--plan-only` | Show plan without executing |

#### Task Decomposition Example

```
Task: Implement authentication system

Subtasks:
| ID | Subtask | Agent | Depends On | Parallel Group |
|----|---------|-------|------------|----------------|
| 1 | Research auth patterns | doc-fetcher | - | A |
| 2 | Design architecture | planner | - | A |
| 3 | Implement core | builder | 1, 2 | B |
| 4 | Security audit | security-auditor | 3 | C |
| 5 | Write tests | test-writer | 3 | C |
| 6 | Review all | reviewer | 4, 5 | D |
```

#### Output

```markdown
# Orchestration Complete

## Summary
- Task: [Original task]
- Duration: [Total time]
- Agents Used: [List]
- Subtasks: X completed, Y skipped

## Results by Agent
[Agent outputs]

## Overall Quality
| Metric | Score |
|--------|-------|
| Completeness | 100% |
| Code Quality | 8/10 |
| Security | 7/10 |
| Test Coverage | 85% |

## Files Changed
[Summary of all files]

## Next Steps
[Recommendations]
```

#### When to Use

- Complex multi-step tasks
- Tasks requiring multiple specialists
- When explicit coordination needed
- For maximum efficiency on large tasks

---

### delegate

**Full Name**: `/project:delegate`

**Purpose**: Directly invoke a specific agent.

**File**: `commands/delegate.md`

#### Syntax

```
/project:delegate [agent-name] [task description]
```

#### Description

The delegate command invokes a specific agent for a focused task:

1. Parse agent name and task
2. Validate agent exists
3. Prepare context
4. Execute agent
5. Return results

#### Available Agents

| Agent | Model | Specialty |
|-------|-------|-----------|
| `planner` | opus | Planning, architecture, research |
| `builder` | sonnet | Code implementation |
| `reviewer` | opus | Code review, quality analysis |
| `fixer` | sonnet | Issue resolution, bug fixes |
| `test-writer` | sonnet | Test creation |
| `doc-fetcher` | haiku | Documentation research |
| `security-auditor` | opus | Security analysis |
| `refactorer` | sonnet | Code improvement |

#### Examples

```
> /project:delegate planner Design the API structure
```

```
> /project:delegate reviewer Check app/services/ for issues
```

```
> /project:delegate builder Create a validation utility
```

```
> /project:delegate security-auditor Audit the auth module
```

```
> /project:delegate test-writer Write tests for the API
```

```
> /project:delegate doc-fetcher Research JWT best practices
```

```
> /project:delegate refactorer Clean up the utility functions
```

#### Output Format

```markdown
## Agent: [agent-name]

### Task
[Original task]

### Result
[Agent output]

### Files Created/Modified
- [file list if any]

### Status
✓ Complete / ⚠ Partial / ✗ Failed

### Next Steps
[Suggested follow-up if any]
```

#### When to Use

- Focused, single-agent tasks
- Quick targeted operations
- Testing agent behavior
- When workflow commands are overkill

---

## Utility Commands

### init

**Full Name**: `/project:init`

**Purpose**: Initialize the Codebase Singularity framework in a new project.

**File**: `commands/init.md`

#### Syntax

```
/project:init
/project:init [project-type]
```

#### Description

The init command sets up the framework structure in any project:

1. Create CLAUDE.md (memory file)
2. Create commands/ directory
3. Create agents/ directory
4. Create specs/ directories
5. Create ai_docs/ directory
6. Configure hooks (optional)

#### Examples

```
> /project:init
```
*Standard initialization*

```
> /project:init node
```
*Initialize for Node.js project*

```
> /project:init python
```
*Initialize for Python project*

#### Files Created

```
project/
├── CLAUDE.md              # Project memory
├── commands/
│   ├── prime.md
│   ├── plan.md
│   ├── build.md
│   ├── review.md
│   └── fix.md
├── agents/
│   └── (optional specialized agents)
├── specs/
│   ├── plans/
│   └── reviews/
└── ai_docs/
```

#### Output

```
Codebase Singularity Initialized

Created:
✓ CLAUDE.md
✓ commands/ (5 commands)
✓ specs/plans/
✓ specs/reviews/
✓ ai_docs/

Next Steps:
1. Edit CLAUDE.md with project details
2. Run /project:prime to activate
3. Start developing with /project:plan
```

#### When to Use

- Setting up new projects
- Adding framework to existing projects
- Onboarding new team members

---

## Command Comparison Matrix

### Overview Comparison

| Command | Agents Used | Output | Human Input |
|---------|-------------|--------|-------------|
| prime | None | Context loaded | None |
| plan | planner | Plan file | Task description |
| build | builder | Code files | None (uses plan) |
| review | reviewer | Review report | None |
| fix | fixer | Fixed code | None (uses review) |
| cycle | All 4 | Complete feature | Task + approval |
| feature | All + test-writer | Complete feature | Task + questions |
| bugfix | reviewer, planner, fixer | Bug fix | Bug description |
| orchestrate | Multiple | Complex feature | Task description |
| delegate | Single specific | Agent output | Agent + task |
| init | None | Project structure | None |

### When to Use Which

| Scenario | Recommended Command |
|----------|-------------------|
| Start of session | `/project:prime` |
| Need to think through approach | `/project:plan` |
| Have a plan, ready to code | `/project:build` |
| Want quality assessment | `/project:review` |
| Have review findings to address | `/project:fix` |
| Complete feature with quality gates | `/project:cycle` |
| New feature with unclear requirements | `/project:feature` |
| Reported bug to investigate | `/project:bugfix` |
| Complex multi-step task | `/project:orchestrate` |
| Single focused task | `/project:delegate` |
| New project setup | `/project:init` |

### Complexity Comparison

```
Simple ◄─────────────────────────────────────────────────► Complex

prime  delegate  plan  build  review  fix  cycle  bugfix  feature  orchestrate
  │        │       │      │      │      │     │      │       │         │
  └────────┴───────┴──────┴──────┴──────┴─────┴──────┴───────┴─────────┘
     Single    Direct   Core Workflow    E2E Workflows    Multi-Agent
     Action    Agent                                      Coordination
```

---

## Best Practices

### Command Sequencing

**Standard Development Flow**:
```
1. /project:prime           # Load context
2. /project:plan [feature]  # Plan first
3. /project:build           # Implement
4. /project:review          # Check quality
5. /project:fix             # Address issues (if needed)
```

**Quick Fix Flow**:
```
1. /project:prime
2. /project:delegate fixer [issue]
3. /project:review
```

**Investigation Flow**:
```
1. /project:prime
2. /project:bugfix [description]
```

**Complex Feature Flow**:
```
1. /project:prime
2. /project:feature [description]
```

### Tips

1. **Always prime first**: Load context before work
2. **Plan before build**: Think before coding
3. **Review everything**: Quality gates catch issues
4. **Use appropriate scope**: delegate for small, orchestrate for large
5. **Document as you go**: Plans and reviews provide history

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
