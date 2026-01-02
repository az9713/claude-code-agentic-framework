# Agents Reference: Codebase Singularity

## Complete Reference for All 9 Specialized Agents

This document provides detailed documentation for every agent in the Codebase Singularity plugin.

---

## Table of Contents

1. [Agent Overview](#agent-overview)
2. [Orchestrator](#orchestrator)
3. [Planner](#planner)
4. [Builder](#builder)
5. [Reviewer](#reviewer)
6. [Fixer](#fixer)
7. [Test Writer](#test-writer)
8. [Doc Fetcher](#doc-fetcher)
9. [Security Auditor](#security-auditor)
10. [Refactorer](#refactorer)
11. [Agent Comparison Matrix](#agent-comparison-matrix)
12. [Creating Custom Agents](#creating-custom-agents)

---

## Agent Overview

### Agent Hierarchy

```
                         ┌──────────────────┐
                         │   ORCHESTRATOR   │
                         │     (opus)       │
                         └────────┬─────────┘
                                  │
            ┌─────────────────────┼─────────────────────┐
            │                     │                     │
            ▼                     ▼                     ▼
    ┌───────────────┐    ┌───────────────┐    ┌───────────────┐
    │    PLANNER    │    │    BUILDER    │    │   REVIEWER    │
    │    (opus)     │    │   (sonnet)    │    │    (opus)     │
    └───────┬───────┘    └───────┬───────┘    └───────┬───────┘
            │                    │                    │
            │            ┌───────┴───────┐            │
            ▼            ▼               ▼            ▼
    ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
    │ DOC-FETCHER  │ │ TEST-WRITER  │ │  REFACTORER  │ │    FIXER     │
    │   (haiku)    │ │   (sonnet)   │ │   (sonnet)   │ │   (sonnet)   │
    └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘
                                                              │
                                                       ┌──────┴───────┐
                                                       ▼
                                               ┌──────────────┐
                                               │   SECURITY   │
                                               │   AUDITOR    │
                                               │    (opus)    │
                                               └──────────────┘
```

### Quick Reference

| Agent | Model | File | Primary Use |
|-------|-------|------|-------------|
| orchestrator | opus | `00-orchestrator.md` | Multi-agent coordination |
| planner | opus | `01-planner.md` | Planning and architecture |
| builder | sonnet | `02-builder.md` | Code implementation |
| reviewer | opus | `03-reviewer.md` | Quality analysis |
| fixer | sonnet | `04-fixer.md` | Issue resolution |
| test-writer | sonnet | `05-test-writer.md` | Test creation |
| doc-fetcher | haiku | `06-doc-fetcher.md` | Documentation research |
| security-auditor | opus | `07-security-auditor.md` | Security analysis |
| refactorer | sonnet | `08-refactorer.md` | Code improvement |

### Model Selection Rationale

| Model | Cost | Speed | Use For |
|-------|------|-------|---------|
| **opus** | High | Slower | Complex reasoning, coordination, review |
| **sonnet** | Medium | Balanced | Code generation, implementation |
| **haiku** | Low | Fastest | Documentation, simple tasks |

---

## Orchestrator

**File**: `agents/00-orchestrator.md`

**Model**: opus

**Purpose**: Master coordinator that manages multi-agent workflows.

### Specification

```yaml
---
name: orchestrator
description: Master coordinator that manages multi-agent workflows, decomposes complex tasks, delegates to specialized agents, and aggregates results.
tools:
  - Read
  - Write
  - Glob
  - Grep
  - Task
model: opus
---
```

### Responsibilities

1. **Task Analysis**
   - Parse complex task descriptions
   - Identify required capabilities
   - Estimate complexity

2. **Task Decomposition**
   - Break complex tasks into subtasks
   - Map dependencies between subtasks
   - Identify parallel opportunities

3. **Agent Assignment**
   - Select appropriate agent for each subtask
   - Match agent capabilities to requirements
   - Consider model costs

4. **Execution Management**
   - Schedule subtasks (parallel/sequential)
   - Monitor progress
   - Handle errors and retries

5. **Result Aggregation**
   - Collect outputs from all agents
   - Combine into coherent result
   - Generate summary report

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read files for context |
| Write | Write coordination files |
| Glob | Find files by pattern |
| Grep | Search file contents |
| Task | Invoke sub-agents |

### When to Use

- Complex multi-step tasks
- Tasks requiring multiple specialists
- When explicit coordination is needed
- Large-scale refactoring
- End-to-end feature implementation

### Example Invocation

```
/project:delegate orchestrator Implement complete user authentication
```

### Output Format

```markdown
# Orchestration Complete

## Summary
- Task: [Description]
- Agents Used: [List]
- Subtasks: X completed

## Results by Agent
[Detailed agent outputs]

## Quality Metrics
| Metric | Score |
|--------|-------|
| Completeness | 100% |
| Code Quality | 8/10 |

## Next Steps
[Recommendations]
```

---

## Planner

**File**: `agents/01-planner.md`

**Model**: opus

**Purpose**: Strategic planning, architecture design, and research.

### Specification

```yaml
---
name: planner
description: Strategic planner that researches requirements, designs architecture, creates detailed implementation plans, and identifies risks.
tools:
  - Read
  - Glob
  - Grep
  - WebSearch
  - WebFetch
model: opus
---
```

### Responsibilities

1. **Requirements Analysis**
   - Understand user requirements
   - Identify edge cases
   - Clarify ambiguities

2. **Research**
   - Research best practices
   - Explore existing patterns
   - Evaluate alternatives

3. **Architecture Design**
   - Design system structure
   - Define interfaces
   - Plan data flow

4. **Task Planning**
   - Create detailed task breakdown
   - Estimate complexity
   - Identify dependencies

5. **Risk Assessment**
   - Identify potential risks
   - Plan mitigations
   - Note assumptions

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read existing code |
| Glob | Find relevant files |
| Grep | Search for patterns |
| WebSearch | Research online |
| WebFetch | Fetch documentation |

### When to Use

- Before implementing new features
- For architecture decisions
- When comparing approaches
- For technical research
- When requirements are unclear

### Example Invocation

```
/project:delegate planner Design the API structure for user management
```

### Output Format

```markdown
# Plan: [Feature Name]

## Overview
[Brief description]

## Requirements
1. [Requirement 1]
2. [Requirement 2]

## Architecture
[Design description with diagrams]

## Tasks
1. [ ] Task 1
2. [ ] Task 2

## Files to Create/Modify
- `path/to/file.js` - [Purpose]

## Dependencies
- [External dependencies]

## Risks
- [Risk 1]: [Mitigation]

## Estimated Complexity
[Low/Medium/High]
```

### Output Location

Plans are saved to: `specs/plans/[date]-[feature].md`

---

## Builder

**File**: `agents/02-builder.md`

**Model**: sonnet

**Purpose**: Code implementation following plans.

### Specification

```yaml
---
name: builder
description: Code implementer that builds features following plans, writes clean code, follows patterns, and creates tests.
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

### Responsibilities

1. **Code Implementation**
   - Write new code
   - Follow existing patterns
   - Implement features

2. **File Management**
   - Create new files
   - Modify existing files
   - Organize code structure

3. **Testing**
   - Run tests after changes
   - Ensure no regressions
   - Add basic tests

4. **Documentation**
   - Add code comments
   - Document functions
   - Update changelogs

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read existing code |
| Write | Create new files |
| Edit | Modify existing files |
| Bash | Run commands |
| Glob | Find files |
| Grep | Search code |

### Key Behaviors

- **Pattern Following**: Matches existing code style
- **Incremental**: Implements in small steps
- **Test-Aware**: Runs tests after changes
- **Self-Documenting**: Adds comments where helpful

### When to Use

- Implementing planned features
- Writing new code
- Modifying existing code
- Creating utilities

### Example Invocation

```
/project:delegate builder Create a validation utility for user input
```

### Output

- New files in `app/` or `src/`
- Modified existing files
- Tests in `tests/`
- Documentation updates

---

## Reviewer

**File**: `agents/03-reviewer.md`

**Model**: opus

**Purpose**: Quality analysis and code review.

### Specification

```yaml
---
name: reviewer
description: Quality analyst that reviews code for correctness, quality, security, and maintainability, producing scored reports.
tools:
  - Read
  - Grep
  - Glob
model: opus
---
```

### Responsibilities

1. **Code Analysis**
   - Read and understand code
   - Check against requirements
   - Verify functionality

2. **Quality Assessment**
   - Evaluate code quality
   - Check for best practices
   - Identify code smells

3. **Issue Identification**
   - Find bugs and issues
   - Categorize by severity
   - Provide fix recommendations

4. **Scoring**
   - Calculate quality score
   - Apply weighted criteria
   - Determine pass/fail

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read code to review |
| Grep | Search for patterns |
| Glob | Find files to review |

### Scoring Criteria

| Category | Weight | Description |
|----------|--------|-------------|
| Correctness | 30% | Does it work as specified? |
| Code Quality | 25% | Clean, readable, maintainable? |
| Test Coverage | 20% | Are critical paths tested? |
| Security | 15% | Any vulnerabilities? |
| Performance | 10% | Any obvious bottlenecks? |

### Severity Levels

| Level | Description | Impact |
|-------|-------------|--------|
| **Critical** | Must fix immediately | Blocks deployment |
| **Major** | Should fix soon | Significant impact |
| **Minor** | Nice to fix | Small impact |

### When to Use

- After implementation
- Before committing code
- For code audits
- To assess quality

### Example Invocation

```
/project:delegate reviewer Review the authentication module
```

### Output Format

```markdown
# Code Review: [Date]

## Summary
[Brief assessment]

## Score: X/10

## Findings

### Critical
- [ ] [Issue]: [Location] - [Recommendation]

### Major
- [ ] [Issue]: [Location] - [Recommendation]

### Minor
- [ ] [Issue]: [Location] - [Recommendation]

## Positive Highlights
- [Good practice]

## Recommendations
1. [Recommendation 1]
```

### Output Location

Reviews are saved to: `specs/reviews/[date]-review.md`

---

## Fixer

**File**: `agents/04-fixer.md`

**Model**: sonnet

**Purpose**: Issue resolution and bug fixing.

### Specification

```yaml
---
name: fixer
description: Issue resolver that addresses review findings, fixes bugs, and ensures code quality while maintaining existing functionality.
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

### Responsibilities

1. **Issue Analysis**
   - Parse review findings
   - Understand root causes
   - Plan fixes

2. **Priority Handling**
   - Fix critical first
   - Then major issues
   - Then minor issues

3. **Code Fixing**
   - Apply fixes
   - Maintain functionality
   - Avoid regressions

4. **Verification**
   - Test fixes
   - Ensure no side effects
   - Document changes

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read code and reviews |
| Write | Create new files |
| Edit | Apply fixes |
| Bash | Run tests |
| Glob | Find files |
| Grep | Search for issues |

### Fix Process

1. Read review findings
2. Prioritize by severity
3. Fix each issue:
   - Understand the problem
   - Apply minimal fix
   - Verify fix works
4. Run all tests
5. Report completion

### When to Use

- After code review
- For bug fixes
- To address technical debt
- For quick patches

### Example Invocation

```
/project:delegate fixer Address the issues from the last review
```

### Output

- Fixed code files
- Updated tests
- Resolution report

---

## Test Writer

**File**: `agents/05-test-writer.md`

**Model**: sonnet

**Purpose**: Test creation and coverage improvement.

### Specification

```yaml
---
name: test-writer
description: Test specialist that creates comprehensive unit tests, integration tests, and edge case coverage.
tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
model: sonnet
---
```

### Responsibilities

1. **Test Planning**
   - Identify test cases
   - Find edge cases
   - Plan coverage

2. **Unit Tests**
   - Test individual functions
   - Cover success cases
   - Cover error cases

3. **Integration Tests**
   - Test module interactions
   - Test workflows
   - Test APIs

4. **Edge Cases**
   - Null/undefined handling
   - Boundary conditions
   - Error scenarios

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read code to test |
| Write | Create test files |
| Edit | Update existing tests |
| Glob | Find files |
| Grep | Search for patterns |

### Test Types

| Type | Purpose | Location |
|------|---------|----------|
| Unit | Test individual functions | `tests/unit/` |
| Integration | Test module interactions | `tests/integration/` |
| E2E | Test full workflows | `tests/e2e/` |

### Coverage Targets

- **Minimum**: 70% coverage
- **Target**: 80% coverage
- **Ideal**: 90%+ coverage

### When to Use

- After building features
- To improve coverage
- For edge case testing
- For regression tests

### Example Invocation

```
/project:delegate test-writer Write tests for the validation module
```

### Output Format

```javascript
// tests/unit/validators.test.js

describe('Validators', () => {
  describe('isValidEmail', () => {
    test('should return true for valid email', () => {
      expect(isValidEmail('test@example.com')).toBe(true);
    });

    test('should return false for invalid email', () => {
      expect(isValidEmail('invalid')).toBe(false);
    });

    test('should handle null input', () => {
      expect(isValidEmail(null)).toBe(false);
    });
  });
});
```

---

## Doc Fetcher

**File**: `agents/06-doc-fetcher.md`

**Model**: haiku

**Purpose**: Documentation research and caching.

### Specification

```yaml
---
name: doc-fetcher
description: Documentation researcher that finds, fetches, and caches external documentation for libraries and best practices.
tools:
  - Read
  - Write
  - WebFetch
  - WebSearch
  - Glob
model: haiku
---
```

### Responsibilities

1. **Research**
   - Find documentation
   - Search for best practices
   - Locate tutorials

2. **Fetching**
   - Download documentation
   - Convert to markdown
   - Extract relevant sections

3. **Caching**
   - Save to ai_docs/
   - Organize by topic
   - Maintain index

4. **Summarization**
   - Extract key points
   - Create quick references
   - Note important APIs

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read existing docs |
| Write | Save fetched docs |
| WebFetch | Fetch web content |
| WebSearch | Search online |
| Glob | Find doc files |

### Why Haiku Model?

- Documentation fetching is straightforward
- No complex reasoning required
- Cost-effective for high-volume fetching
- Speed is more important than depth

### When to Use

- Researching new libraries
- Finding best practices
- Documenting APIs
- Building knowledge base

### Example Invocation

```
/project:delegate doc-fetcher Research JWT authentication best practices
```

### Output Location

Documentation is saved to: `ai_docs/[library]/[topic].md`

### Output Format

```markdown
# [Topic] Documentation

## Source
[URL or reference]

## Summary
[Key points]

## API Reference
[Relevant API details]

## Examples
[Code examples]

## Best Practices
[Recommendations]
```

---

## Security Auditor

**File**: `agents/07-security-auditor.md`

**Model**: opus

**Purpose**: Security analysis and vulnerability detection.

### Specification

```yaml
---
name: security-auditor
description: Security specialist that audits code for vulnerabilities, compliance issues, and security best practices.
tools:
  - Read
  - Grep
  - Glob
model: opus
---
```

### Responsibilities

1. **Vulnerability Detection**
   - Find security issues
   - Identify OWASP Top 10
   - Detect common flaws

2. **Compliance Check**
   - Verify best practices
   - Check authentication
   - Review authorization

3. **Risk Assessment**
   - Categorize severity
   - Estimate impact
   - Prioritize fixes

4. **Recommendations**
   - Suggest fixes
   - Provide examples
   - Reference standards

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read code to audit |
| Grep | Search for patterns |
| Glob | Find files to audit |

### Security Checks

| Category | Checks |
|----------|--------|
| **Injection** | SQL, NoSQL, Command, XSS |
| **Authentication** | Weak passwords, session management |
| **Authorization** | Access control, privilege escalation |
| **Data Exposure** | Sensitive data handling, encryption |
| **Configuration** | Security headers, CORS, defaults |
| **Dependencies** | Vulnerable packages |

### Severity Levels

| Level | Description | Action |
|-------|-------------|--------|
| **Critical** | Immediate exploitation risk | Block deployment |
| **High** | Serious vulnerability | Fix before release |
| **Medium** | Potential risk | Fix soon |
| **Low** | Minor concern | Fix when convenient |
| **Info** | Best practice suggestion | Consider improving |

### When to Use

- Before deployment
- After major changes
- For compliance audits
- Regular security reviews

### Example Invocation

```
/project:delegate security-auditor Audit the authentication system
```

### Output Format

```markdown
# Security Audit Report

## Summary
[Overview of findings]

## Risk Level: [Critical/High/Medium/Low]

## Findings

### Critical
- **[Vulnerability]**
  - Location: `file.js:42`
  - Risk: [Description]
  - Fix: [Recommendation]

### High
- [Similar format]

### Medium
- [Similar format]

### Low
- [Similar format]

## Compliance Status
- [ ] OWASP Top 10 addressed
- [ ] Authentication secure
- [ ] Authorization implemented
- [ ] Data encrypted

## Recommendations
1. [Priority fix 1]
2. [Priority fix 2]
```

---

## Refactorer

**File**: `agents/08-refactorer.md`

**Model**: sonnet

**Purpose**: Code improvement and technical debt reduction.

### Specification

```yaml
---
name: refactorer
description: Code improver that refactors for better quality, reduces complexity, extracts patterns, and improves maintainability.
tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
model: sonnet
---
```

### Responsibilities

1. **Code Analysis**
   - Identify code smells
   - Find duplication
   - Spot complexity

2. **Refactoring**
   - Extract methods
   - Simplify logic
   - Improve naming

3. **Pattern Extraction**
   - Create utilities
   - Build helpers
   - Reduce duplication

4. **Quality Improvement**
   - Improve readability
   - Enhance maintainability
   - Optimize performance

### Tools Available

| Tool | Purpose |
|------|---------|
| Read | Read code to refactor |
| Write | Create new files |
| Edit | Apply refactoring |
| Glob | Find files |
| Grep | Search for patterns |

### Refactoring Types

| Type | Description |
|------|-------------|
| **Extract Method** | Pull code into named function |
| **Inline** | Replace function with its body |
| **Rename** | Improve variable/function names |
| **Move** | Relocate code to better location |
| **Simplify** | Reduce complexity |
| **Extract Class** | Create new class from code |

### Code Smells Addressed

- Long methods
- Duplicate code
- Complex conditionals
- Deep nesting
- Poor naming
- Large classes
- Feature envy

### When to Use

- Technical debt reduction
- Before major changes
- After rapid development
- Regular maintenance

### Example Invocation

```
/project:delegate refactorer Clean up the utility functions
```

### Output

- Refactored code
- New utility files (if extracted)
- Documentation updates

---

## Agent Comparison Matrix

### Capabilities Matrix

| Agent | Creates Code | Reviews Code | Researches | Coordinates |
|-------|-------------|--------------|------------|-------------|
| orchestrator | - | - | - | ✓ |
| planner | - | - | ✓ | - |
| builder | ✓ | - | - | - |
| reviewer | - | ✓ | - | - |
| fixer | ✓ | - | - | - |
| test-writer | ✓ | - | - | - |
| doc-fetcher | - | - | ✓ | - |
| security-auditor | - | ✓ | - | - |
| refactorer | ✓ | ✓ | - | - |

### Tool Access Matrix

| Agent | Read | Write | Edit | Bash | Task | Web* |
|-------|------|-------|------|------|------|------|
| orchestrator | ✓ | ✓ | - | - | ✓ | - |
| planner | ✓ | - | - | - | - | ✓ |
| builder | ✓ | ✓ | ✓ | ✓ | - | - |
| reviewer | ✓ | - | - | - | - | - |
| fixer | ✓ | ✓ | ✓ | ✓ | - | - |
| test-writer | ✓ | ✓ | ✓ | - | - | - |
| doc-fetcher | ✓ | ✓ | - | - | - | ✓ |
| security-auditor | ✓ | - | - | - | - | - |
| refactorer | ✓ | ✓ | ✓ | - | - | - |

*Web = WebSearch + WebFetch
All agents have access to Glob and Grep

### When to Use Each Agent

| Scenario | Recommended Agent |
|----------|-------------------|
| Plan a new feature | planner |
| Implement a feature | builder |
| Review code quality | reviewer |
| Fix bugs or issues | fixer |
| Write tests | test-writer |
| Research documentation | doc-fetcher |
| Audit for security | security-auditor |
| Improve code quality | refactorer |
| Complex multi-step task | orchestrator |

---

## Creating Custom Agents

### Agent Template

```yaml
---
name: custom-agent
description: Description of what this agent does
tools:
  - Tool1
  - Tool2
model: opus|sonnet|haiku
---

# Custom Agent

## Role
You are a [role description]. Your expertise is in [domain].

## Responsibilities
- Responsibility 1
- Responsibility 2
- Responsibility 3

## Constraints
- What you MUST NOT do
- Boundaries of your work
- Limitations to observe

## Process
1. First, you...
2. Then, you...
3. Next, you...
4. Finally, you...

## Input
What information you need:
- Input 1: [description]
- Input 2: [description]

## Output
What you produce:
- Output 1: [format and location]
- Output 2: [format and location]

## Examples

### Example Input
[Sample input]

### Example Output
[Expected output]
```

### Steps to Create

1. **Create file**: `agents/XX-agent-name.md`
2. **Define frontmatter**: name, description, tools, model
3. **Write prompt**: role, responsibilities, process
4. **Update CLAUDE.md**: Add reference to new agent
5. **Test agent**: Use `/project:delegate agent-name [task]`

### Best Practices

1. **Single Responsibility**: One agent, one focus
2. **Clear Constraints**: Define what agent should NOT do
3. **Specific Process**: Step-by-step instructions
4. **Example Output**: Show expected format
5. **Appropriate Model**: Match complexity to capability

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
