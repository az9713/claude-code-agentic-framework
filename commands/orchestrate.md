---
name: orchestrate
description: Coordinate complex multi-agent workflows for large-scale tasks. The orchestrator manages agent delegation, parallel execution, and result aggregation.
---
# Orchestrate Command - Multi-Agent Coordination

## Purpose

Coordinate complex workflows that require multiple agents working together. The orchestrator manages task decomposition, agent delegation, parallel execution where possible, and result aggregation.

## When to Use

- Large features requiring multiple specialized agents
- Complex tasks with dependencies between steps
- Parallel workstreams that need coordination
- When explicit agent coordination is needed
- Tasks too complex for a single agent

## Syntax

```
/orchestrate [task description]
/orchestrate --parallel [task]     # Maximize parallelism
/orchestrate --sequential [task]   # Force sequential execution
/orchestrate --plan-only [task]    # Show plan, don't execute
```

## Instructions

When this command is invoked:

### Step 1: Task Analysis

The orchestrator analyzes the task to determine:

1. **Decomposition**: Break into subtasks
2. **Dependencies**: Map what depends on what
3. **Agent Assignment**: Which agent for each subtask
4. **Execution Order**: Parallel vs. sequential

```markdown
# Orchestration Plan

## Task
[Original task description]

## Subtasks

| ID | Subtask | Agent | Depends On | Parallel Group |
|----|---------|-------|------------|----------------|
| 1 | Research API patterns | doc-fetcher | - | A |
| 2 | Design architecture | planner | - | A |
| 3 | Implement core | builder | 1, 2 | B |
| 4 | Implement tests | test-writer | 3 | C |
| 5 | Security audit | security-auditor | 3 | C |
| 6 | Review all | reviewer | 4, 5 | D |

## Execution Diagram
```
[doc-fetcher]──┐
               ├──►[builder]──►[test-writer]──┐
[planner]──────┘               [security]─────┴──►[reviewer]
     │                              │
     └────────── Group A ───────────┘
                Group B
                           Group C
                                              Group D
```
```

### Step 2: Delegation

For each subtask, the orchestrator:

1. **Prepares context**: Gathers all information the agent needs
2. **Delegates**: Hands off to the specialized agent
3. **Monitors**: Tracks progress and status
4. **Collects**: Gathers results when complete

Delegation template:
```
Agent: [agent-name]
Task: [specific task]

Context:
- [Relevant background]
- [Previous agent outputs]
- [Constraints]

Expected Output:
- [What to produce]
- [Format requirements]
```

### Step 3: Execution

Execute subtasks following the dependency graph:

```
┌─────────────────────────────────────────────────────────┐
│                    ORCHESTRATION                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌─────────┐  ┌─────────┐                               │
│  │ Task 1  │  │ Task 2  │  ← Parallel Group A           │
│  │(fetcher)│  │(planner)│                               │
│  └────┬────┘  └────┬────┘                               │
│       │            │                                     │
│       └─────┬──────┘                                     │
│             ▼                                            │
│       ┌─────────┐                                        │
│       │ Task 3  │  ← Sequential (depends on 1,2)        │
│       │(builder)│                                        │
│       └────┬────┘                                        │
│            │                                             │
│       ┌────┴────┐                                        │
│       ▼         ▼                                        │
│  ┌─────────┐  ┌─────────┐                               │
│  │ Task 4  │  │ Task 5  │  ← Parallel Group C           │
│  │(tester) │  │(security)│                              │
│  └────┬────┘  └────┬────┘                               │
│       │            │                                     │
│       └─────┬──────┘                                     │
│             ▼                                            │
│       ┌─────────┐                                        │
│       │ Task 6  │  ← Final (depends on 4,5)             │
│       │(reviewer)│                                       │
│       └─────────┘                                        │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Step 4: Progress Tracking

Real-time status updates:

```
Orchestration Progress: [Task Name]

[■■■■■■■■□□] 80% Complete

Status:
✓ Task 1: Research API patterns (doc-fetcher) - Complete
✓ Task 2: Design architecture (planner) - Complete
✓ Task 3: Implement core (builder) - Complete
► Task 4: Implement tests (test-writer) - In Progress
► Task 5: Security audit (security-auditor) - In Progress
○ Task 6: Review all (reviewer) - Waiting

Estimated remaining: [time estimate]
```

### Step 5: Error Handling

When an agent fails:

1. **Capture error**: Log what went wrong
2. **Assess impact**: What downstream tasks are affected?
3. **Recovery options**:
   - Retry with more context
   - Delegate to different agent
   - Ask user for guidance
   - Skip and continue (if optional)

```
Error in Task 3 (builder):
"Unable to resolve dependency X"

Options:
1. Retry with additional context
2. Ask user for guidance
3. Skip and mark as blocked
4. Abort orchestration

> [User selects option]
```

### Step 6: Result Aggregation

Collect and organize all outputs:

```markdown
# Orchestration Complete

## Summary
- Task: [Original task]
- Duration: [Total time]
- Agents Used: [List]
- Subtasks: X completed, Y skipped

## Results by Agent

### doc-fetcher
- Output: ai_docs/api-research.md
- Status: ✓ Complete

### planner
- Output: specs/feature-plan.md
- Status: ✓ Complete

### builder
- Output: app/feature/* (5 files)
- Status: ✓ Complete

### test-writer
- Output: tests/feature.test.js (15 tests)
- Status: ✓ Complete

### security-auditor
- Output: Security report (2 medium issues)
- Status: ✓ Complete

### reviewer
- Output: specs/reviews/[date]-review.md
- Score: 8/10
- Status: ✓ Complete

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
1. Address security findings
2. Manual testing
3. Commit changes
```

## Available Agents

| Agent | Capabilities | Best For |
|-------|--------------|----------|
| orchestrator | Coordination, delegation | Complex workflows |
| planner | Research, design, planning | Architecture decisions |
| builder | Code implementation | Writing code |
| reviewer | Quality analysis | Code review |
| fixer | Issue resolution | Bug fixes |
| test-writer | Test creation | Test coverage |
| doc-fetcher | Documentation | API research |
| security-auditor | Security analysis | Security review |
| refactorer | Code improvement | Restructuring |

## Orchestration Patterns

### Feature Development
```
planner → builder → test-writer → reviewer → fixer (loop) → complete
          ↑
          doc-fetcher (parallel research)
```

### Security-First Development
```
planner → security-auditor → builder → security-auditor → reviewer
```

### Test-Driven Development
```
planner → test-writer → builder → reviewer → fixer
```

### Parallel Implementation
```
planner → [builder-A, builder-B, builder-C] → integration → reviewer
```

## Notes

- Orchestrator is the conductor, not a performer
- Minimize agent switches (context overhead)
- Prefer parallel execution where possible
- Always aggregate results clearly
- Handle failures gracefully
- Log all decisions for transparency
