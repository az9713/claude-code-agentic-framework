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
/delegate [agent-name] [task description]

Examples:
/delegate planner Design the API structure
/delegate reviewer Check this file for issues
/delegate builder Create a validation utility
/delegate security-auditor Audit the auth module
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

Usage: /delegate [agent] [task]
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
/delegate planner Design the user authentication system
/delegate planner Compare REST vs GraphQL for our API
/delegate planner Create a migration plan for the database
```

### builder
**Good for:**
- Writing new code
- Modifying existing code
- Creating utilities
- Implementing features

**Example tasks:**
```
/delegate builder Create a date formatting utility
/delegate builder Add validation to the user form
/delegate builder Implement the search functionality
```

### reviewer
**Good for:**
- Code review
- Quality assessment
- Bug finding
- Best practice check

**Example tasks:**
```
/delegate reviewer Review app/services/userService.js
/delegate reviewer Check the authentication module for issues
/delegate reviewer Analyze code quality of recent changes
```

### fixer
**Good for:**
- Bug fixes
- Addressing review findings
- Error resolution
- Quick patches

**Example tasks:**
```
/delegate fixer Fix the null pointer in getUserById
/delegate fixer Address the issues from the last review
/delegate fixer Resolve the failing tests
```

### test-writer
**Good for:**
- Unit tests
- Integration tests
- Edge case coverage
- Test utilities

**Example tasks:**
```
/delegate test-writer Write tests for the validation module
/delegate test-writer Add edge case tests for date parsing
/delegate test-writer Create integration tests for the API
```

### doc-fetcher
**Good for:**
- API documentation
- Library research
- Best practices
- External references

**Example tasks:**
```
/delegate doc-fetcher Get JWT authentication best practices
/delegate doc-fetcher Document the Express.js middleware API
/delegate doc-fetcher Research caching strategies
```

### security-auditor
**Good for:**
- Security review
- Vulnerability detection
- OWASP checks
- Compliance review

**Example tasks:**
```
/delegate security-auditor Audit the authentication system
/delegate security-auditor Check for SQL injection vulnerabilities
/delegate security-auditor Review data encryption practices
```

### refactorer
**Good for:**
- Code cleanup
- Structure improvement
- Performance optimization
- Technical debt

**Example tasks:**
```
/delegate refactorer Clean up the utility functions
/delegate refactorer Reduce complexity in the order processor
/delegate refactorer Extract common patterns into helpers
```

## Quick Reference

```bash
# Planning
/delegate planner [design/analyze/plan something]

# Building
/delegate builder [create/implement/add something]

# Reviewing
/delegate reviewer [review/check/analyze file or feature]

# Fixing
/delegate fixer [fix/resolve/address issue]

# Testing
/delegate test-writer [write/add/create tests for X]

# Research
/delegate doc-fetcher [research/document/find X]

# Security
/delegate security-auditor [audit/check/review security of X]

# Refactoring
/delegate refactorer [improve/clean/refactor X]
```

## Notes

- Delegate is for focused, single-agent tasks
- For complex multi-agent work, use `/orchestrate`
- Agent output is returned directly to you
- Failed delegations can be retried with more context
- Agents follow CLAUDE.md conventions automatically
