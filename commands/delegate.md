---
name: delegate
description: Directly invoke a specific agent for a targeted task. Useful when you know exactly which agent you need.
---
# Delegate Command - Direct Agent Invocation

## Purpose

Directly invoke a specific specialized agent for a targeted task. Use this when you know exactly which agent you need and want direct control over the delegation.

## When to Use

- You need a specific agent's capabilities
- Quick, focused task for one agent
- Bypassing orchestration for simple tasks
- Testing agent behavior
- When workflow commands are overkill

## Syntax

```
/project:delegate [agent-name] [task description]

Examples:
/project:delegate planner Design the API structure
/project:delegate reviewer Check this file for issues
/project:delegate builder Create a validation utility
/project:delegate security-auditor Audit the auth module
```

## Available Agents

| Agent | Name | Model | Capabilities |
|-------|------|-------|--------------|
| 🎯 orchestrator | orchestrator | opus | Multi-agent coordination |
| 📋 planner | planner | opus | Planning, architecture, research |
| 🔨 builder | builder | sonnet | Code implementation |
| 🔍 reviewer | reviewer | opus | Code review, quality analysis |
| 🔧 fixer | fixer | sonnet | Bug fixes, issue resolution |
| 🧪 test-writer | test-writer | sonnet | Test creation |
| 📚 doc-fetcher | doc-fetcher | haiku | Documentation research |
| 🔒 security-auditor | security-auditor | opus | Security analysis |
| ♻️ refactorer | refactorer | sonnet | Code improvement |

## Instructions

When this command is invoked:

### Step 1: Parse Request

Extract:
1. Agent name
2. Task description
3. Any context from conversation

### Step 2: Validate Agent

Check that:
- Agent name is valid
- Agent is enabled in settings
- Task matches agent capabilities

If invalid:
```
Unknown agent: "[name]"

Available agents:
- planner: Planning and architecture
- builder: Code implementation
- reviewer: Code review
- fixer: Issue resolution
- test-writer: Test creation
- doc-fetcher: Documentation
- security-auditor: Security analysis
- refactorer: Code improvement

Usage: /project:delegate [agent] [task]
```

### Step 3: Prepare Context

Gather relevant context for the agent:

```
Agent: [agent-name]
Task: [task description]

Project Context:
- Working directory: [path]
- Relevant files: [from conversation or inferred]
- Previous work: [if any]

Constraints:
- Follow project conventions (CLAUDE.md)
- Save outputs to appropriate locations
- Report completion status
```

### Step 4: Delegate

Invoke the agent with the Task tool:

```javascript
Task({
  subagent_type: "[agent-name]",
  prompt: [prepared context + task]
})
```

### Step 5: Report Results

Show agent output and status:

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

## Agent Capabilities Detail

### planner
**Good for:**
- Creating implementation plans
- Architecture design
- Requirement analysis
- Research and comparison

**Example tasks:**
```
/project:delegate planner Design the user authentication system
/project:delegate planner Compare REST vs GraphQL for our API
/project:delegate planner Create a migration plan for the database
```

### builder
**Good for:**
- Writing new code
- Modifying existing code
- Creating utilities
- Implementing features

**Example tasks:**
```
/project:delegate builder Create a date formatting utility
/project:delegate builder Add validation to the user form
/project:delegate builder Implement the search functionality
```

### reviewer
**Good for:**
- Code review
- Quality assessment
- Bug finding
- Best practice check

**Example tasks:**
```
/project:delegate reviewer Review app/services/userService.js
/project:delegate reviewer Check the authentication module for issues
/project:delegate reviewer Analyze code quality of recent changes
```

### fixer
**Good for:**
- Bug fixes
- Addressing review findings
- Error resolution
- Quick patches

**Example tasks:**
```
/project:delegate fixer Fix the null pointer in getUserById
/project:delegate fixer Address the issues from the last review
/project:delegate fixer Resolve the failing tests
```

### test-writer
**Good for:**
- Unit tests
- Integration tests
- Edge case coverage
- Test utilities

**Example tasks:**
```
/project:delegate test-writer Write tests for the validation module
/project:delegate test-writer Add edge case tests for date parsing
/project:delegate test-writer Create integration tests for the API
```

### doc-fetcher
**Good for:**
- API documentation
- Library research
- Best practices
- External references

**Example tasks:**
```
/project:delegate doc-fetcher Get JWT authentication best practices
/project:delegate doc-fetcher Document the Express.js middleware API
/project:delegate doc-fetcher Research caching strategies
```

### security-auditor
**Good for:**
- Security review
- Vulnerability detection
- OWASP checks
- Compliance review

**Example tasks:**
```
/project:delegate security-auditor Audit the authentication system
/project:delegate security-auditor Check for SQL injection vulnerabilities
/project:delegate security-auditor Review data encryption practices
```

### refactorer
**Good for:**
- Code cleanup
- Structure improvement
- Performance optimization
- Technical debt

**Example tasks:**
```
/project:delegate refactorer Clean up the utility functions
/project:delegate refactorer Reduce complexity in the order processor
/project:delegate refactorer Extract common patterns into helpers
```

## Quick Reference

```bash
# Planning
/project:delegate planner [design/analyze/plan something]

# Building
/project:delegate builder [create/implement/add something]

# Reviewing
/project:delegate reviewer [review/check/analyze file or feature]

# Fixing
/project:delegate fixer [fix/resolve/address issue]

# Testing
/project:delegate test-writer [write/add/create tests for X]

# Research
/project:delegate doc-fetcher [research/document/find X]

# Security
/project:delegate security-auditor [audit/check/review security of X]

# Refactoring
/project:delegate refactorer [improve/clean/refactor X]
```

## Notes

- Delegate is for focused, single-agent tasks
- For complex multi-agent work, use `/project:orchestrate`
- Agent output is returned directly to you
- Failed delegations can be retried with more context
- Agents follow CLAUDE.md conventions automatically
