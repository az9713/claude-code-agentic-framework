# Configuration Guide: Codebase Singularity

## Complete Reference for All Settings and Options

**Version**: 1.0.0
**Classification**: Class 3, Grade 1+
**Last Updated**: 2026-01-01

---

## Table of Contents

- [Overview](#overview)
- [Configuration Files](#configuration-files)
- [Plugin Configuration](#plugin-configuration)
- [Project Settings](#project-settings)
- [MCP Configuration](#mcp-configuration)
- [Hooks Configuration](#hooks-configuration)
- [Agent Configuration](#agent-configuration)
- [Command Configuration](#command-configuration)
- [Environment Variables](#environment-variables)
- [Customization Examples](#customization-examples)

---

## Overview

The Codebase Singularity framework uses a layered configuration approach:

```
┌─────────────────────────────────────────────────────────────┐
│                     Configuration Layers                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  CLAUDE.md                                           │    │
│  │  Project memory and context                          │    │
│  └─────────────────────────────────────────────────────┘    │
│                           │                                  │
│                           ▼                                  │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  .claude-plugin/plugin.json                          │    │
│  │  Plugin metadata and structure                       │    │
│  └─────────────────────────────────────────────────────┘    │
│                           │                                  │
│                           ▼                                  │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  templates/settings.json                             │    │
│  │  Project preferences and defaults                    │    │
│  └─────────────────────────────────────────────────────┘    │
│                           │                                  │
│           ┌───────────────┼───────────────┐                  │
│           ▼               ▼               ▼                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │ .mcp.json   │  │ hooks.json  │  │ agents/*.md │          │
│  │ MCP servers │  │ Hooks       │  │ Agent defs  │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Configuration Priority

When settings conflict, this is the resolution order:

1. **Command-line arguments** (highest priority)
2. **Environment variables**
3. **Project settings** (`templates/settings.json`)
4. **Plugin defaults** (lowest priority)

---

## Configuration Files

### File Locations

| File | Purpose | Required |
|------|---------|----------|
| `CLAUDE.md` | Project memory and context | Yes |
| `.claude-plugin/plugin.json` | Plugin manifest | Yes |
| `templates/settings.json` | Project preferences | No |
| `.mcp.json` | MCP server configuration | No |
| `hooks/hooks.json` | Hook configuration | No |
| `agents/*.md` | Agent definitions | Yes |
| `commands/*.md` | Command definitions | Yes |
| `skills/*/SKILL.md` | Skill modules | No |

---

## Plugin Configuration

### Location

`.claude-plugin/plugin.json`

### Full Schema

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Plugin description",
  "author": {
    "name": "Author Name",
    "email": "author@example.com",
    "url": "https://example.com"
  },
  "keywords": ["keyword1", "keyword2"],
  "license": "MIT",
  "commands": "../commands",
  "agents": "../agents",
  "skills": "../skills",
  "hooks": "../hooks/hooks.json"
}
```

### Field Reference

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Unique plugin identifier |
| `version` | string | Yes | Semantic version (x.y.z) |
| `description` | string | Yes | Human-readable description |
| `author` | object | No | Author information |
| `author.name` | string | No | Author's name |
| `author.email` | string | No | Author's email |
| `author.url` | string | No | Author's website |
| `keywords` | array | No | Search keywords |
| `license` | string | No | License identifier |
| `commands` | string | Yes | Path to commands directory |
| `agents` | string | Yes | Path to agents directory |
| `skills` | string | No | Path to skills directory |
| `hooks` | string | No | Path to hooks configuration |

### Default Configuration

```json
{
  "name": "codebase-singularity",
  "version": "1.0.0",
  "description": "Full agentic layer framework implementing the Codebase Singularity concept",
  "author": {
    "name": "Agentic Layer Framework Contributors"
  },
  "keywords": [
    "agentic-layer",
    "codebase-singularity",
    "multi-agent",
    "orchestration"
  ],
  "license": "MIT",
  "commands": "../commands",
  "agents": "../agents",
  "skills": "../skills",
  "hooks": "../hooks/hooks.json"
}
```

---

## Project Settings

### Location

`templates/settings.json`

### Full Schema

```json
{
  "project": {
    "name": "string",
    "description": "string",
    "version": "string",
    "language": "string",
    "framework": "string|null"
  },
  "agenticLayer": {
    "class": 1-3,
    "grade": 1-4,
    "version": "string"
  },
  "preferences": {
    "autoLint": true|false,
    "protectedFiles": true|false,
    "qualityGate": true|false,
    "verboseLogging": true|false,
    "autoSaveSpecs": true|false
  },
  "agents": {
    "defaultModel": "sonnet|opus|haiku",
    "fastModel": "haiku|sonnet",
    "smartModel": "opus|sonnet",
    "enabled": ["agent-names"]
  },
  "commands": {
    "enabled": ["command-names"],
    "aliases": {
      "alias": "command-name"
    }
  },
  "hooks": {
    "enabled": true|false,
    "autoLint": true|false,
    "protectFiles": true|false,
    "logSubagents": true|false,
    "qualityGate": true|false
  },
  "mcp": {
    "enabled": true|false,
    "servers": ["server-names"]
  },
  "paths": {
    "specs": "path/",
    "reviews": "path/",
    "fixes": "path/",
    "aiDocs": "path/",
    "logs": "path/",
    "app": "path/",
    "tests": "path/"
  },
  "codingStandards": {
    "style": "string",
    "maxLineLength": number,
    "maxFunctionLength": number,
    "requireTests": true|false,
    "requireDocs": true|false
  },
  "review": {
    "minScore": 1-10,
    "autoFix": true|false,
    "severityLevels": {
      "critical": "block|warn|info|ignore",
      "high": "block|warn|info|ignore",
      "medium": "block|warn|info|ignore",
      "low": "block|warn|info|ignore"
    }
  }
}
```

### Section Details

#### Project Section

Basic project information:

```json
{
  "project": {
    "name": "My Project",
    "description": "A project using the Codebase Singularity framework",
    "version": "1.0.0",
    "language": "javascript",
    "framework": "express"
  }
}
```

| Field | Options | Description |
|-------|---------|-------------|
| `language` | javascript, typescript, python, etc. | Primary language |
| `framework` | express, react, django, etc. | Framework in use |

#### Agentic Layer Section

Framework classification:

```json
{
  "agenticLayer": {
    "class": 3,
    "grade": 1,
    "version": "1.0.0"
  }
}
```

| Class | Grade | Features |
|-------|-------|----------|
| 1 | 1 | Prime prompt, memory files |
| 1 | 2 | Sub-agents |
| 1 | 3 | Skills, MCP |
| 1 | 4 | Hooks |
| 2 | 1 | Portable structure |
| 2 | 2 | E2E workflows |
| 3 | 1+ | Full orchestration |

#### Preferences Section

Global behavior toggles:

```json
{
  "preferences": {
    "autoLint": true,
    "protectedFiles": true,
    "qualityGate": false,
    "verboseLogging": false,
    "autoSaveSpecs": true
  }
}
```

| Preference | Default | Description |
|------------|---------|-------------|
| `autoLint` | true | Auto-format files after editing |
| `protectedFiles` | true | Prevent editing sensitive files |
| `qualityGate` | false | Require quality checks before completion |
| `verboseLogging` | false | Enable detailed logging |
| `autoSaveSpecs` | true | Save plans/reviews to specs/ |

#### Agents Section

Agent configuration:

```json
{
  "agents": {
    "defaultModel": "sonnet",
    "fastModel": "haiku",
    "smartModel": "opus",
    "enabled": [
      "orchestrator",
      "planner",
      "builder",
      "reviewer",
      "fixer",
      "test-writer",
      "doc-fetcher",
      "security-auditor",
      "refactorer"
    ]
  }
}
```

| Model | Use Case | Cost |
|-------|----------|------|
| `opus` | Complex reasoning, planning, review | Highest |
| `sonnet` | Implementation, fixing | Medium |
| `haiku` | Documentation, simple tasks | Lowest |

#### Commands Section

Command configuration:

```json
{
  "commands": {
    "enabled": [
      "prime", "plan", "build", "review", "fix",
      "cycle", "feature", "bugfix",
      "orchestrate", "delegate", "init"
    ],
    "aliases": {
      "p": "prime",
      "pl": "plan",
      "b": "build",
      "r": "review",
      "f": "fix"
    }
  }
}
```

| Alias | Command |
|-------|---------|
| `p` | prime |
| `pl` | plan |
| `b` | build |
| `r` | review |
| `f` | fix |

#### Paths Section

Directory structure:

```json
{
  "paths": {
    "specs": "specs/",
    "reviews": "specs/reviews/",
    "fixes": "specs/fixes/",
    "aiDocs": "ai_docs/",
    "logs": "logs/",
    "app": "app/",
    "tests": "tests/"
  }
}
```

#### Coding Standards Section

Code style preferences:

```json
{
  "codingStandards": {
    "style": "standard",
    "maxLineLength": 100,
    "maxFunctionLength": 50,
    "requireTests": true,
    "requireDocs": false
  }
}
```

| Standard | Description |
|----------|-------------|
| `style` | Style guide (standard, airbnb, google) |
| `maxLineLength` | Max characters per line |
| `maxFunctionLength` | Max lines per function |
| `requireTests` | Require tests for new code |
| `requireDocs` | Require documentation |

#### Review Section

Review configuration:

```json
{
  "review": {
    "minScore": 7,
    "autoFix": false,
    "severityLevels": {
      "critical": "block",
      "high": "warn",
      "medium": "info",
      "low": "ignore"
    }
  }
}
```

| Severity | Action | Description |
|----------|--------|-------------|
| `block` | Block | Must fix before proceeding |
| `warn` | Warn | Should fix, but can proceed |
| `info` | Info | Informational, optional fix |
| `ignore` | Ignore | Don't report |

---

## MCP Configuration

### Location

`.mcp.json`

### Full Schema

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["package-name", "arg1", "arg2"],
      "env": {
        "VAR_NAME": "${ENV_VAR}"
      },
      "description": "What this server does"
    }
  },
  "notes": {
    "key": "value"
  }
}
```

### Built-in Servers

#### Filesystem Server

Access to project files:

```json
{
  "filesystem": {
    "command": "npx",
    "args": [
      "-y",
      "@anthropic-ai/mcp-server-filesystem",
      "${PROJECT_ROOT}/app",
      "${PROJECT_ROOT}/tests",
      "${PROJECT_ROOT}/specs",
      "${PROJECT_ROOT}/ai_docs"
    ],
    "description": "File system access for project directories"
  }
}
```

**Allowed Paths**: Only directories listed in args can be accessed.

#### GitHub Server

GitHub integration:

```json
{
  "github": {
    "command": "npx",
    "args": [
      "-y",
      "@anthropic-ai/mcp-server-github"
    ],
    "env": {
      "GITHUB_TOKEN": "${GITHUB_TOKEN}"
    },
    "description": "GitHub integration for issues, PRs, and repository management"
  }
}
```

**Required**: Set `GITHUB_TOKEN` environment variable.

**Capabilities**:
- Create/read/update issues
- Create/read/update pull requests
- Read repository contents
- Create commits

#### Memory Server

Persistent memory:

```json
{
  "memory": {
    "command": "npx",
    "args": [
      "-y",
      "@anthropic-ai/mcp-server-memory"
    ],
    "description": "Persistent memory for cross-session context"
  }
}
```

**Use Cases**:
- Remember user preferences
- Store conversation context
- Track project state

### Optional Servers

#### PostgreSQL Server

```json
{
  "postgres": {
    "command": "npx",
    "args": [
      "-y",
      "@anthropic-ai/mcp-server-postgres"
    ],
    "env": {
      "DATABASE_URL": "${DATABASE_URL}"
    },
    "description": "PostgreSQL database integration"
  }
}
```

#### Redis Server

```json
{
  "redis": {
    "command": "npx",
    "args": [
      "-y",
      "@anthropic-ai/mcp-server-redis"
    ],
    "env": {
      "REDIS_URL": "${REDIS_URL}"
    },
    "description": "Redis caching integration"
  }
}
```

#### Slack Server

```json
{
  "slack": {
    "command": "npx",
    "args": [
      "-y",
      "@anthropic-ai/mcp-server-slack"
    ],
    "env": {
      "SLACK_TOKEN": "${SLACK_TOKEN}"
    },
    "description": "Slack notifications and messaging"
  }
}
```

---

## Hooks Configuration

### Location

`hooks/hooks.json`

### Full Schema

```json
{
  "hooks": [
    {
      "name": "hook-name",
      "event": "PreToolUse|PostToolUse|Stop|SubagentStop",
      "tools": ["Tool1", "Tool2"],
      "command": "bash script.sh \"$VAR\"",
      "description": "Description",
      "enabled": true,
      "timeout": 30000
    }
  ],
  "notes": {
    "events": ["descriptions"],
    "variables": ["descriptions"]
  }
}
```

### Hook Events

| Event | Trigger | Can Block | Variables |
|-------|---------|-----------|-----------|
| `PreToolUse` | Before tool executes | Yes | FILE_PATH, TOOL_NAME |
| `PostToolUse` | After tool completes | No | FILE_PATH, TOOL_NAME |
| `Stop` | Agent completing | Yes | - |
| `SubagentStop` | Subagent completing | No | AGENT_NAME, STATUS |

### Built-in Hooks

| Hook | Event | Tools | Default |
|------|-------|-------|---------|
| auto-lint | PostToolUse | Edit, Write | Enabled |
| protect-files | PreToolUse | Edit, Write | Enabled |
| log-subagent | SubagentStop | - | Enabled |
| quality-gate | Stop | - | Disabled |

### Enabling/Disabling Hooks

In `hooks.json`:

```json
{
  "hooks": [
    {
      "name": "quality-gate",
      "enabled": true  // or false
    }
  ]
}
```

See [HOOKS_GUIDE.md](./HOOKS_GUIDE.md) for detailed hook documentation.

---

## Agent Configuration

### YAML Frontmatter Schema

```yaml
---
name: agent-name
description: What this agent does
model: opus|sonnet|haiku
tools:
  - Tool1
  - Tool2
allowedTools:
  - AllowedTool
disallowedTools:
  - DisallowedTool
---
```

### Available Tools

| Tool | Description |
|------|-------------|
| Read | Read files |
| Write | Create/overwrite files |
| Edit | Modify files |
| Bash | Execute shell commands |
| Glob | Find files by pattern |
| Grep | Search file contents |
| Task | Spawn subagents |
| WebFetch | Fetch URLs |
| WebSearch | Search the web |

### Model Selection Guidelines

| Model | Use When | Examples |
|-------|----------|----------|
| opus | Complex reasoning, architecture | planner, reviewer, orchestrator |
| sonnet | Implementation, moderate complexity | builder, fixer, test-writer |
| haiku | Simple tasks, high volume | doc-fetcher |

### Example Agent Configuration

```yaml
---
name: custom-agent
description: A custom agent for specific tasks
model: sonnet
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
---

# Custom Agent

## Role
[Agent's primary role]

## Guidelines
[What this agent should do]

## Output Format
[Expected output structure]
```

See [AGENTS_REFERENCE.md](./AGENTS_REFERENCE.md) for detailed agent documentation.

---

## Command Configuration

### YAML Frontmatter Schema

```yaml
---
name: command-name
description: What this command does
allowed-tools:
  - Tool1
  - Tool2
---
```

### Example Command Configuration

```yaml
---
name: my-command
description: A custom workflow command
allowed-tools:
  - Read
  - Write
  - Task
---

# My Command

[Command instructions...]
```

See [COMMANDS_REFERENCE.md](./COMMANDS_REFERENCE.md) for detailed command documentation.

---

## Environment Variables

### Required Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `GITHUB_TOKEN` | GitHub API access | `ghp_xxxxxxxxxxxx` |

### Optional Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `PROJECT_ROOT` | Project root path | Current directory |
| `SESSION_ID` | Session identifier | Auto-generated |
| `NODE_ENV` | Environment mode | development |
| `DATABASE_URL` | Database connection | - |
| `REDIS_URL` | Redis connection | - |
| `SLACK_TOKEN` | Slack API token | - |
| `SLACK_WEBHOOK_URL` | Slack webhook | - |
| `MONITORING_TOKEN` | Monitoring service | - |

### Setting Variables

**Linux/Mac**:
```bash
export GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

**Windows (PowerShell)**:
```powershell
$env:GITHUB_TOKEN = "ghp_xxxxxxxxxxxx"
```

**Windows (CMD)**:
```cmd
set GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

**In .env file** (not committed):
```
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
DATABASE_URL=postgres://user:pass@host:5432/db
```

---

## Customization Examples

### Minimal Configuration

For small projects:

```json
// templates/settings.json
{
  "project": {
    "name": "My Small Project"
  },
  "agenticLayer": {
    "class": 1,
    "grade": 2
  },
  "agents": {
    "enabled": ["planner", "builder", "reviewer"]
  },
  "commands": {
    "enabled": ["prime", "plan", "build", "review"]
  }
}
```

### Strict Quality Configuration

For production-critical projects:

```json
{
  "preferences": {
    "qualityGate": true,
    "protectedFiles": true
  },
  "review": {
    "minScore": 8,
    "severityLevels": {
      "critical": "block",
      "high": "block",
      "medium": "warn",
      "low": "info"
    }
  },
  "codingStandards": {
    "requireTests": true,
    "requireDocs": true
  },
  "hooks": {
    "qualityGate": true
  }
}
```

### Fast Development Configuration

For rapid prototyping:

```json
{
  "preferences": {
    "qualityGate": false,
    "autoLint": true
  },
  "agents": {
    "defaultModel": "haiku",
    "smartModel": "sonnet"
  },
  "review": {
    "minScore": 5,
    "autoFix": true
  }
}
```

### Team Configuration

For collaborative projects:

```json
{
  "mcp": {
    "servers": ["filesystem", "github", "slack"]
  },
  "hooks": {
    "logSubagents": true,
    "qualityGate": true
  },
  "codingStandards": {
    "style": "airbnb",
    "maxLineLength": 80
  }
}
```

### Python Project Configuration

```json
{
  "project": {
    "language": "python",
    "framework": "django"
  },
  "paths": {
    "app": "src/",
    "tests": "tests/"
  },
  "codingStandards": {
    "style": "pep8",
    "maxLineLength": 88
  }
}
```

### TypeScript Project Configuration

```json
{
  "project": {
    "language": "typescript",
    "framework": "react"
  },
  "codingStandards": {
    "style": "standard",
    "maxLineLength": 100
  }
}
```

---

## Configuration Validation

### Required Files Check

Ensure these files exist:

1. `CLAUDE.md`
2. `.claude-plugin/plugin.json`
3. At least one agent in `agents/`
4. At least one command in `commands/`

### Common Issues

| Issue | Solution |
|-------|----------|
| Plugin not recognized | Check `.claude-plugin/plugin.json` exists |
| Agent not found | Verify agent file is in `agents/` with `.md` extension |
| Command not working | Check command is in `enabled` list |
| Hook not running | Verify `enabled: true` in hook config |
| MCP server failing | Check environment variables are set |

### Validation Command

Run `/prime` to validate configuration:

```
> /prime

✓ CLAUDE.md found
✓ Plugin manifest valid
✓ 9 agents loaded
✓ 11 commands loaded
✓ 4 skills loaded
✓ 5 hooks configured
✓ 3 MCP servers configured
```

---

## Quick Reference

### Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Project memory |
| `.claude-plugin/plugin.json` | Plugin manifest |
| `templates/settings.json` | Project settings |
| `.mcp.json` | MCP servers |
| `hooks/hooks.json` | Hook configuration |

### Key Settings

| Setting | Location | Default |
|---------|----------|---------|
| Quality gate | preferences.qualityGate | false |
| Auto-lint | preferences.autoLint | true |
| Min review score | review.minScore | 7 |
| Default model | agents.defaultModel | sonnet |

### Models

| Model | Speed | Intelligence | Cost |
|-------|-------|--------------|------|
| haiku | Fast | Basic | Low |
| sonnet | Medium | Good | Medium |
| opus | Slow | Best | High |

---

## Related Documentation

- [DEVELOPER_GUIDE.md](./DEVELOPER_GUIDE.md) - Architecture and implementation
- [HOOKS_GUIDE.md](./HOOKS_GUIDE.md) - Detailed hook documentation
- [AGENTS_REFERENCE.md](./AGENTS_REFERENCE.md) - Agent specifications
- [COMMANDS_REFERENCE.md](./COMMANDS_REFERENCE.md) - Command reference

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
