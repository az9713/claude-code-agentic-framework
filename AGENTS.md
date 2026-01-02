# AGENTS.md

Universal instructions for AI coding agents working on this project.

> This file follows the [agents.md](https://agents.md) standard - a cross-platform format for AI agent instructions adopted by 60,000+ open-source projects.

---

## Project Overview

**Codebase Singularity** is an agentic layer framework that enables AI agents to operate codebases autonomously through structured workflows.

- **Type**: Claude Code Plugin / Agentic Framework
- **Classification**: Class 3, Grade 1+ (Full Orchestration)
- **Purpose**: Plan-Build-Review-Fix development cycles with multi-agent coordination

### Core Concept

The "Agentic Layer" wraps around application code, providing:
- Project memory (`CLAUDE.md`)
- Workflow commands (11 commands in `commands/`)
- Specialized agents (9 agents in `agents/`)
- Skills and tools (`skills/`, `.mcp.json`)
- Automation hooks (`hooks/`)

---

## Build and Test Commands

```bash
# No build step required - this is a configuration-based framework

# Run tests
node tests/run.js

# Verify structure
ls -la commands/ agents/ skills/ hooks/
```

---

## Code Style Guidelines

### Markdown Files
- Use ATX-style headers (`#`, `##`, `###`)
- Include YAML frontmatter for commands and agents
- Keep line length reasonable (no hard limit)
- Use fenced code blocks with language identifiers

### JSON Files
- 2-space indentation
- No trailing commas
- Use double quotes for strings

### Shell Scripts
- Bash-compatible (#!/bin/bash)
- Include header comments explaining purpose
- Use exit codes: 0 = success, 1 = failure/block
- Quote variables: `"$VAR"` not `$VAR`

### General
- Follow existing patterns in the codebase
- Prefer explicit over clever code
- No hardcoded secrets or credentials

---

## Project Structure

```
├── CLAUDE.md              # Claude-specific memory (read first)
├── AGENTS.md              # This file - universal agent instructions
├── .claude-plugin/        # Plugin manifest
├── commands/              # 11 workflow commands
│   ├── prime.md           # Load project context
│   ├── plan.md            # Create implementation plans
│   ├── build.md           # Implement from plans
│   ├── review.md          # Quality analysis
│   ├── fix.md             # Address issues
│   ├── cycle.md           # Full Plan-Build-Review-Fix
│   ├── feature.md         # Feature development workflow
│   ├── bugfix.md          # Bug investigation workflow
│   ├── orchestrate.md     # Multi-agent coordination
│   ├── delegate.md        # Direct agent invocation
│   └── setup.md            # Initialize in new projects
├── agents/                # 9 specialized agents
│   ├── 00-orchestrator.md # Coordinates other agents
│   ├── 01-planner.md      # Plans implementations
│   ├── 02-builder.md      # Writes code
│   ├── 03-reviewer.md     # Reviews quality
│   ├── 04-fixer.md        # Fixes issues
│   ├── 05-test-writer.md  # Creates tests
│   ├── 06-doc-fetcher.md  # Fetches documentation
│   ├── 07-security-auditor.md # Security analysis
│   └── 08-refactorer.md   # Improves code
├── skills/                # Reusable knowledge modules
├── hooks/                 # Automation configuration
├── scripts/               # Hook implementation scripts
├── specs/                 # Generated plans and reviews
├── ai_docs/               # Cached documentation
├── app/                   # Application code (user's code goes here)
└── tests/                 # Test files
```

---

## Working with This Framework

### For Claude Code Users

Use the slash commands:

```
/prime              # Always run first - loads context
/plan [feature]     # Create implementation plan
/build              # Build from the plan
/review             # Get quality analysis
/fix                # Fix review findings
/cycle [feature]    # Complete workflow in one command
```

### For Other AI Agents

1. Read `CLAUDE.md` first for project context
2. Check `specs/` for any pending plans or reviews
3. Follow the Plan-Build-Review-Fix pattern:
   - Plan before implementing
   - Review after building
   - Fix until quality passes
4. Quality gate: Score must be >= 7/10

### Agent Delegation

Specialized agents handle specific tasks:

| Agent | Use For |
|-------|---------|
| planner | Architecture, design, planning |
| builder | Code implementation |
| reviewer | Quality analysis, code review |
| fixer | Bug fixes, issue resolution |
| test-writer | Test creation |
| doc-fetcher | Documentation research |
| security-auditor | Security analysis |
| refactorer | Code improvement |
| orchestrator | Complex multi-step tasks |

---

## Security Considerations

### Protected Files (Do Not Modify)

- `.env`, `.env.*` - Environment secrets
- `*-lock.json`, `*.lock` - Dependency locks
- `*.pem`, `*.key` - Certificates and keys
- `credentials.json`, `secrets.json` - Credentials
- `.git/` - Git internals

### Security Guidelines

- Never hardcode passwords, API keys, or tokens
- Never commit `.env` files
- Run security-auditor before finalizing changes
- Check for OWASP Top 10 vulnerabilities
- Validate and sanitize all inputs

---

## Testing Instructions

### Running Tests

```bash
node tests/run.js
```

### Test Requirements

- All new features need tests
- Tests should cover: valid inputs, invalid inputs, edge cases
- Run tests before committing

### Quality Gate

The review process assigns a score from 1-10:
- **Score >= 7**: Pass - ready for merge
- **Score < 7**: Fail - continue fixing and re-review

---

## Commit and PR Guidelines

### Commit Format

Use conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Examples:
```
feat(auth): add password reset functionality
fix(api): handle null response from external service
docs(readme): update installation instructions
```

### PR Requirements

1. Pass quality gate (score >= 7)
2. All tests passing
3. No security issues from security-auditor
4. Clear description of changes

### Commit Footer

Include when generated by AI:

```
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Additional Notes

### File Precedence

When working in subdirectories:
1. Check for local `AGENTS.md` first
2. Fall back to root `AGENTS.md`
3. The closest file takes precedence

### Framework vs Application Code

- **Agentic Layer** (`commands/`, `agents/`, `skills/`, `hooks/`): Framework configuration
- **Application Layer** (`app/`, `tests/`): Your actual application code

The Agentic Layer operates ON the Application Layer, not within it.

### Getting Help

- See `docs/QUICKSTART.md` for hands-on tutorials
- See `docs/USER_GUIDE.md` for detailed usage
- See `docs/AGENTIC_LAYER.md` for concept explanation

---

*This file is part of the Class 1, Grade 1 Agentic Layer foundation alongside `prime.md` and `CLAUDE.md`.*
