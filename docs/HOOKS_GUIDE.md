# Hooks Guide: Codebase Singularity

## Complete Reference for Event-Driven Automation

**Version**: 1.0.0
**Classification**: Class 1, Grade 4 (Feedback Loops)
**Last Updated**: 2026-01-01

---

## Table of Contents

- [Overview](#overview)
- [Hook Architecture](#hook-architecture)
- [Hook Events](#hook-events)
- [Hook Configuration](#hook-configuration)
- [Built-in Hooks](#built-in-hooks)
- [Environment Variables](#environment-variables)
- [Script Reference](#script-reference)
- [Creating Custom Hooks](#creating-custom-hooks)
- [Advanced Patterns](#advanced-patterns)
- [Troubleshooting](#troubleshooting)

---

## Overview

Hooks provide event-driven automation for the Codebase Singularity framework. They execute scripts in response to agent and tool activities, enabling:

- **Auto-formatting**: Lint files after editing
- **Protection**: Prevent modifications to sensitive files
- **Logging**: Track agent activity for debugging
- **Quality Gates**: Enforce standards before completion
- **Custom Workflows**: Trigger any automation

### How Hooks Work

```
┌─────────────────────────────────────────────────────────────┐
│                     Hook Execution Flow                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Event Occurs       Hook Matches       Script Runs           │
│       │                  │                  │                │
│       ▼                  ▼                  ▼                │
│  ┌─────────┐      ┌───────────┐      ┌───────────┐          │
│  │ Edit    │ ───► │ Check     │ ───► │ Execute   │          │
│  │ Called  │      │ hooks.json│      │ script.sh │          │
│  └─────────┘      └───────────┘      └───────────┘          │
│                                            │                 │
│                                            ▼                 │
│                                      ┌───────────┐          │
│                                      │ Result    │          │
│                                      │ (0 or 1)  │          │
│                                      └───────────┘          │
│                                            │                 │
│                        ┌───────────────────┴─────────────┐  │
│                        │                                 │  │
│                        ▼                                 ▼  │
│                   Exit 0                            Exit 1  │
│                   (Continue)                        (Block) │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Hook Architecture

### Directory Structure

```
project/
├── hooks/
│   └── hooks.json         # Hook configuration
├── scripts/
│   ├── auto-lint.sh       # Post-edit formatter
│   ├── protect-files.sh   # Pre-edit protection
│   ├── log-subagent.sh    # Agent activity logger
│   ├── auto-review.sh     # Feedback loop trigger
│   └── quality-gate.sh    # Quality verification
└── logs/
    ├── subagent.log       # Agent activity log
    ├── feedback-loop.log  # Feedback loop activity
    └── agent-stats.json   # Agent statistics
```

### Execution Context

Hooks run in a shell environment with access to:

- Project root directory
- Environment variables
- Full filesystem access
- Network (for external checks)

### Exit Codes

| Exit Code | Meaning | Effect |
|-----------|---------|--------|
| 0 | Success | Operation continues |
| 1 | Failure/Block | Operation blocked (PreToolUse) or logged (PostToolUse) |
| Other | Error | Logged but doesn't block |

---

## Hook Events

### PreToolUse

**Triggered**: Before a tool executes
**Purpose**: Validate, protect, or modify behavior
**Can Block**: Yes (exit 1)

```json
{
  "name": "protect-files",
  "event": "PreToolUse",
  "tools": ["Edit", "Write"],
  "command": "bash scripts/protect-files.sh \"$FILE_PATH\""
}
```

**Use Cases**:
- Prevent editing sensitive files
- Validate file permissions
- Check file ownership
- Verify before destructive operations

### PostToolUse

**Triggered**: After a tool completes successfully
**Purpose**: Transform, validate, or log results
**Can Block**: No (informational only)

```json
{
  "name": "auto-lint",
  "event": "PostToolUse",
  "tools": ["Edit", "Write"],
  "command": "bash scripts/auto-lint.sh \"$FILE_PATH\""
}
```

**Use Cases**:
- Auto-format edited files
- Run type checks
- Update documentation
- Sync changes

### Stop

**Triggered**: When agent is about to complete
**Purpose**: Final validation before completion
**Can Block**: Yes (exit 1)

```json
{
  "name": "quality-gate",
  "event": "Stop",
  "command": "bash scripts/quality-gate.sh"
}
```

**Use Cases**:
- Run test suite
- Check for debug code
- Verify no secrets exposed
- Validate coverage

### SubagentStop

**Triggered**: When a subagent completes
**Purpose**: Track and log agent activity
**Can Block**: No (informational only)

```json
{
  "name": "log-subagent",
  "event": "SubagentStop",
  "command": "bash scripts/log-subagent.sh \"$AGENT_NAME\" \"$STATUS\""
}
```

**Use Cases**:
- Log agent completions
- Track performance metrics
- Build activity dashboards
- Debug orchestration

---

## Hook Configuration

### Configuration File

Location: `hooks/hooks.json`

```json
{
  "hooks": [
    {
      "name": "hook-name",
      "event": "PreToolUse|PostToolUse|Stop|SubagentStop",
      "tools": ["Edit", "Write"],
      "command": "bash script.sh \"$VARIABLE\"",
      "description": "Human-readable description",
      "enabled": true,
      "timeout": 30000
    }
  ]
}
```

### Configuration Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Unique identifier for the hook |
| `event` | string | Yes | Event that triggers the hook |
| `tools` | array | No* | Tools that trigger the hook (for Pre/PostToolUse) |
| `command` | string | Yes | Shell command to execute |
| `description` | string | No | Human-readable explanation |
| `enabled` | boolean | No | Whether hook is active (default: true) |
| `timeout` | number | No | Max execution time in ms (default: 30000) |

*Required for PreToolUse and PostToolUse events

### Tool Names

Available tools for filtering:

| Tool | Description |
|------|-------------|
| `Edit` | File editing operations |
| `Write` | File creation/overwriting |
| `Read` | File reading |
| `Bash` | Shell command execution |
| `Glob` | File pattern matching |
| `Grep` | Content searching |
| `Task` | Subagent spawning |
| `WebFetch` | URL fetching |
| `WebSearch` | Web searching |

---

## Built-in Hooks

The framework includes five pre-configured hooks:

### 1. Auto-Lint Hook

**Purpose**: Automatically format files after editing
**Event**: PostToolUse
**Status**: Enabled

```json
{
  "name": "auto-lint",
  "event": "PostToolUse",
  "tools": ["Edit", "Write"],
  "command": "bash ${PROJECT_ROOT}/scripts/auto-lint.sh \"$FILE_PATH\"",
  "description": "Auto-format files after editing",
  "enabled": true,
  "timeout": 30000
}
```

**Supported Formatters**:

| Extension | Formatter (Primary) | Fallback |
|-----------|---------------------|----------|
| js, jsx, ts, tsx | Prettier | npx prettier |
| json | Prettier | jq |
| py | Black | autopep8 |
| md | Prettier | - |
| css, scss, less | Prettier | - |
| html, htm | Prettier | - |
| yaml, yml | Prettier | - |

### 2. Protect Files Hook

**Purpose**: Prevent editing of sensitive/protected files
**Event**: PreToolUse
**Status**: Enabled

```json
{
  "name": "protect-files",
  "event": "PreToolUse",
  "tools": ["Edit", "Write"],
  "command": "bash ${PROJECT_ROOT}/scripts/protect-files.sh \"$FILE_PATH\"",
  "description": "Prevent editing protected files (.env, lock files)",
  "enabled": true,
  "timeout": 5000
}
```

**Protected Files**:

| Pattern | Reason |
|---------|--------|
| `.env*` | Environment secrets |
| `*-lock.json`, `*.lock` | Dependency locks |
| `.git/*` | Git internals |
| `id_rsa`, `id_ed25519` | SSH keys |
| `*.pem`, `*.key` | Certificates/keys |
| `credentials.json`, `secrets.json` | Secrets files |

**Protected Directories**:

| Directory | Reason |
|-----------|--------|
| `.git/` | Git repository |
| `node_modules/` | Dependencies |
| `.next/`, `dist/`, `build/` | Build outputs |
| `__pycache__/`, `.venv/`, `venv/` | Python artifacts |

**Content Detection**:

| Pattern | Action |
|---------|--------|
| Private key markers | Block |
| AWS credentials (AKIA...) | Warning |

### 3. Log Subagent Hook

**Purpose**: Track subagent activity for debugging/metrics
**Event**: SubagentStop
**Status**: Enabled

```json
{
  "name": "log-subagent",
  "event": "SubagentStop",
  "command": "bash ${PROJECT_ROOT}/scripts/log-subagent.sh \"$AGENT_NAME\" \"$STATUS\"",
  "description": "Log subagent activity for orchestration tracking",
  "enabled": true,
  "timeout": 5000
}
```

**Log Output**:

```json
{
  "timestamp": "2026-01-01T12:00:00Z",
  "agent": "builder",
  "status": "success",
  "session": "abc123"
}
```

**Log Location**: `logs/subagent.log`

### 4. Auto-Review Hook (Feedback Loop)

**Purpose**: Implement Class 1, Grade 4 feedback loop - automatically trigger review after code changes
**Event**: SubagentStop
**Status**: Enabled

```json
{
  "name": "auto-review",
  "event": "SubagentStop",
  "command": "bash ${PROJECT_ROOT}/scripts/auto-review.sh \"$AGENT_NAME\" \"$STATUS\"",
  "description": "Class 1 Grade 4 feedback loop - trigger review after builder/fixer complete",
  "enabled": true,
  "timeout": 10000
}
```

**Trigger Agents**: This hook fires after these agents complete:
- `builder` - After code implementation
- `fixer` - After fixing issues
- `refactorer` - After code improvements

**Feedback Loop Flow**:

```
Builder completes successfully
       │
       ▼
auto-review hook fires
       │
       ▼
Prompts user to run /project:review
       │
       ▼
If issues found → run /project:fix
       │
       ▼
Fixer completes → auto-review fires again
       │
       ▼
Loop until quality passes (max 3 iterations)
```

**Loop Protection**: Maximum 3 review iterations to prevent infinite loops.

**Log Location**: `logs/feedback-loop.log`

**Why This Matters**: This implements IndyDevDan's Class 1, Grade 4 concept - agents should automatically review work done by other agents, creating a self-correcting feedback loop.

### 5. Quality Gate Hook

**Purpose**: Verify quality before completing operations
**Event**: Stop
**Status**: Disabled (enable for strict enforcement)

```json
{
  "name": "quality-gate",
  "event": "Stop",
  "command": "bash ${PROJECT_ROOT}/scripts/quality-gate.sh",
  "description": "Verify quality before completing major operations",
  "enabled": false,
  "timeout": 60000
}
```

**Checks Performed**:

| Check | Severity | Description |
|-------|----------|-------------|
| Tests | Error | Run npm test or tests/run.js |
| Lint | Warning | Run npm run lint |
| Debug Code | Warning | Find console.log, debugger, TODO |
| Secrets | Error | Find hardcoded passwords/API keys |
| .env in Git | Error | Detect uncommitted .env files |

---

## Environment Variables

Hooks receive these environment variables:

### File Context

| Variable | Description | Available In |
|----------|-------------|--------------|
| `$FILE_PATH` | Full path of file being edited | Pre/PostToolUse |
| `$TOOL_NAME` | Name of tool being used | Pre/PostToolUse |

### Agent Context

| Variable | Description | Available In |
|----------|-------------|--------------|
| `$AGENT_NAME` | Name of subagent | SubagentStop |
| `$STATUS` | Completion status (success/failure) | SubagentStop |

### Environment Context

| Variable | Description | Available In |
|----------|-------------|--------------|
| `$PROJECT_ROOT` | Root directory of project | All hooks |
| `$SESSION_ID` | Current session identifier | All hooks |

### Using Variables

Variables are expanded before command execution:

```json
{
  "command": "bash ${PROJECT_ROOT}/scripts/hook.sh \"$FILE_PATH\" \"$TOOL_NAME\""
}
```

In script:

```bash
#!/bin/bash
FILE_PATH="$1"
TOOL_NAME="$2"

echo "Tool $TOOL_NAME operated on $FILE_PATH"
```

---

## Script Reference

### auto-lint.sh

**Purpose**: Auto-format files based on extension
**Exit Code**: Always 0 (non-blocking)

```bash
#!/bin/bash
FILE_PATH="$1"

# Skip if no path or file deleted
if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

# Get extension and format accordingly
EXT="${FILE_PATH##*.}"
case "$EXT" in
    js|jsx|ts|tsx)
        prettier --write "$FILE_PATH" 2>/dev/null
        ;;
    py)
        black --quiet "$FILE_PATH" 2>/dev/null
        ;;
    # ... more cases
esac

exit 0
```

### protect-files.sh

**Purpose**: Block edits to sensitive files
**Exit Code**: 0 (allow) or 1 (block)

```bash
#!/bin/bash
FILE_PATH="$1"
FILENAME=$(basename "$FILE_PATH")

# Protected patterns
PROTECTED_FILES=(".env" "*.lock" "*.key" "*.pem")

# Check against patterns
for pattern in "${PROTECTED_FILES[@]}"; do
    if [[ "$FILENAME" == $pattern ]]; then
        echo "BLOCKED: Cannot edit protected file: $FILENAME"
        exit 1
    fi
done

exit 0
```

### log-subagent.sh

**Purpose**: Log agent activity to file
**Exit Code**: Always 0

```bash
#!/bin/bash
AGENT_NAME="$1"
STATUS="$2"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

LOG_DIR="${PROJECT_ROOT:-.}/logs"
mkdir -p "$LOG_DIR"

echo "{\"timestamp\": \"$TIMESTAMP\", \"agent\": \"$AGENT_NAME\", \"status\": \"$STATUS\"}" >> "$LOG_DIR/subagent.log"

exit 0
```

### auto-review.sh

**Purpose**: Implement Class 1, Grade 4 feedback loop
**Exit Code**: Always 0 (informational)

```bash
#!/bin/bash
AGENT_NAME="$1"
STATUS="$2"

# Only trigger for builder/fixer/refactorer agents
REVIEW_TRIGGER_AGENTS=("builder" "fixer" "refactorer")

for agent in "${REVIEW_TRIGGER_AGENTS[@]}"; do
    if [ "$AGENT_NAME" == "$agent" ] && [ "$STATUS" == "success" ]; then
        echo "FEEDBACK LOOP: Agent '$AGENT_NAME' completed."
        echo "Recommendation: Run /project:review"
        exit 0
    fi
done

exit 0
```

### quality-gate.sh

**Purpose**: Verify code quality before completion
**Exit Code**: 0 (pass) or 1 (fail)

```bash
#!/bin/bash
PASSED=true

# Run tests
if npm test --silent 2>/dev/null; then
    echo "✓ Tests passed"
else
    PASSED=false
fi

# Check for secrets
if grep -rE "password.*=.*['\"]" app/ 2>/dev/null | grep -v "\.test\." | wc -l; then
    PASSED=false
fi

if [ "$PASSED" = true ]; then
    exit 0
else
    exit 1
fi
```

---

## Creating Custom Hooks

### Step 1: Create the Script

Create a script in `scripts/`:

```bash
#!/bin/bash
# scripts/custom-hook.sh
# Description: What this hook does

# Get parameters
FILE_PATH="$1"

# Your logic here
echo "Processing: $FILE_PATH"

# Exit code determines behavior
exit 0
```

Make it executable:

```bash
chmod +x scripts/custom-hook.sh
```

### Step 2: Add to Configuration

Add to `hooks/hooks.json`:

```json
{
  "hooks": [
    {
      "name": "custom-hook",
      "event": "PostToolUse",
      "tools": ["Edit", "Write"],
      "command": "bash ${PROJECT_ROOT}/scripts/custom-hook.sh \"$FILE_PATH\"",
      "description": "My custom hook",
      "enabled": true,
      "timeout": 30000
    }
  ]
}
```

### Step 3: Test the Hook

1. Enable the hook
2. Perform the triggering action
3. Check the output/logs

### Example: Notify on File Changes

```bash
#!/bin/bash
# scripts/notify-changes.sh
FILE_PATH="$1"
CHANNEL="${SLACK_WEBHOOK_URL:-}"

if [ -n "$CHANNEL" ]; then
    curl -X POST "$CHANNEL" \
        -H "Content-Type: application/json" \
        -d "{\"text\": \"File changed: $FILE_PATH\"}" \
        2>/dev/null
fi

exit 0
```

### Example: Type Check After Edit

```bash
#!/bin/bash
# scripts/type-check.sh
FILE_PATH="$1"
EXT="${FILE_PATH##*.}"

if [[ "$EXT" == "ts" || "$EXT" == "tsx" ]]; then
    npx tsc --noEmit "$FILE_PATH" 2>&1
    if [ $? -ne 0 ]; then
        echo "TypeScript errors detected"
    fi
fi

exit 0
```

### Example: Backup Before Destructive Operations

```bash
#!/bin/bash
# scripts/backup-before-edit.sh
FILE_PATH="$1"
BACKUP_DIR="${PROJECT_ROOT}/.backups"

mkdir -p "$BACKUP_DIR"

if [ -f "$FILE_PATH" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BASENAME=$(basename "$FILE_PATH")
    cp "$FILE_PATH" "$BACKUP_DIR/${BASENAME}.${TIMESTAMP}.bak"
    echo "Backed up: $FILE_PATH"
fi

exit 0
```

---

## Advanced Patterns

### Conditional Execution

Run hooks only under certain conditions:

```bash
#!/bin/bash
# Only run in production mode
if [ "$NODE_ENV" != "production" ]; then
    exit 0
fi

# Actual hook logic
# ...
```

### Chain Multiple Actions

Run multiple tools in sequence:

```bash
#!/bin/bash
FILE_PATH="$1"

# Format
prettier --write "$FILE_PATH"

# Lint
eslint --fix "$FILE_PATH"

# Type check
tsc --noEmit "$FILE_PATH"

exit 0
```

### Parallel Execution

Run checks in parallel:

```bash
#!/bin/bash

# Start background jobs
npm test &
TEST_PID=$!

npm run lint &
LINT_PID=$!

# Wait for all
wait $TEST_PID
TEST_STATUS=$?

wait $LINT_PID
LINT_STATUS=$?

# Aggregate results
if [ $TEST_STATUS -ne 0 ] || [ $LINT_STATUS -ne 0 ]; then
    exit 1
fi

exit 0
```

### External Service Integration

Call external APIs:

```bash
#!/bin/bash
# Report to monitoring service

curl -X POST "https://api.monitoring.service/event" \
    -H "Authorization: Bearer $MONITORING_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"event\": \"file_modified\",
        \"file\": \"$FILE_PATH\",
        \"agent\": \"$AGENT_NAME\",
        \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"
    }" 2>/dev/null

exit 0
```

### Caching Results

Cache expensive operations:

```bash
#!/bin/bash
CACHE_DIR="${PROJECT_ROOT}/.cache"
CACHE_FILE="$CACHE_DIR/lint-cache.json"

mkdir -p "$CACHE_DIR"

# Check cache freshness (1 hour)
if [ -f "$CACHE_FILE" ]; then
    AGE=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
    if [ $AGE -lt 3600 ]; then
        echo "Using cached result"
        exit 0
    fi
fi

# Run actual check
npm run lint

# Update cache
date +%s > "$CACHE_FILE"

exit 0
```

---

## Troubleshooting

### Hook Not Running

**Symptom**: Hook doesn't execute when expected

**Solutions**:

1. Check `enabled` is `true`:
   ```json
   "enabled": true
   ```

2. Verify event matches:
   ```json
   "event": "PostToolUse"  // Not "posttooluse"
   ```

3. Check tool filter:
   ```json
   "tools": ["Edit"]  // Not ["edit"] - case sensitive
   ```

4. Verify script exists and is executable:
   ```bash
   chmod +x scripts/my-hook.sh
   ```

### Hook Timing Out

**Symptom**: Hook gets killed before completion

**Solutions**:

1. Increase timeout:
   ```json
   "timeout": 60000  // 60 seconds
   ```

2. Optimize script:
   - Remove unnecessary operations
   - Use caching
   - Run expensive checks in background

3. Split into smaller hooks

### Hook Blocking Unexpectedly

**Symptom**: PreToolUse hook blocks valid operations

**Solutions**:

1. Check exit codes:
   ```bash
   # Debug: show what would happen
   echo "Would exit with: $EXIT_CODE"
   exit 0  # Temporarily always allow
   ```

2. Review protection patterns:
   ```bash
   # Be more specific
   if [[ "$FILENAME" == ".env" ]]; then  # Not "*env*"
   ```

3. Add exclusions:
   ```bash
   # Allow .env.example
   if [[ "$FILENAME" == ".env.example" ]]; then
       exit 0
   fi
   ```

### Variable Not Available

**Symptom**: `$FILE_PATH` or other variable is empty

**Solutions**:

1. Verify event type (only certain events have certain variables)

2. Quote variables:
   ```json
   "command": "bash script.sh \"$FILE_PATH\""
   ```

3. Provide defaults in script:
   ```bash
   FILE_PATH="${1:-unknown}"
   ```

### Debugging Hooks

Add debug output:

```bash
#!/bin/bash
# Enable debug mode
set -x

# Log all inputs
echo "FILE_PATH: $FILE_PATH"
echo "TOOL_NAME: $TOOL_NAME"
echo "PROJECT_ROOT: $PROJECT_ROOT"

# Your logic
# ...

# Show exit code
echo "Exiting with: $?"
```

Check logs:

```bash
# View recent hook activity
tail -f logs/subagent.log

# Check for errors
grep -i error logs/*.log
```

---

## Quick Reference

### Hook Events

| Event | Trigger | Can Block | Variables |
|-------|---------|-----------|-----------|
| PreToolUse | Before tool | Yes | FILE_PATH, TOOL_NAME |
| PostToolUse | After tool | No | FILE_PATH, TOOL_NAME |
| Stop | Agent completes | Yes | - |
| SubagentStop | Subagent completes | No | AGENT_NAME, STATUS |

### Exit Codes

| Code | PreToolUse | PostToolUse | Stop | SubagentStop |
|------|------------|-------------|------|--------------|
| 0 | Continue | Log success | Complete | Log success |
| 1 | Block | Log failure | Block | Log failure |

### Configuration Template

```json
{
  "hooks": [
    {
      "name": "my-hook",
      "event": "PostToolUse",
      "tools": ["Edit", "Write"],
      "command": "bash ${PROJECT_ROOT}/scripts/my-hook.sh \"$FILE_PATH\"",
      "description": "What this hook does",
      "enabled": true,
      "timeout": 30000
    }
  ]
}
```

### Script Template

```bash
#!/bin/bash
# scripts/template.sh
# Description: Template for custom hooks

set -e  # Exit on error

# Get parameters
FILE_PATH="$1"

# Validate input
if [ -z "$FILE_PATH" ]; then
    echo "No file path provided"
    exit 0
fi

# Your logic here
echo "Processing: $FILE_PATH"

# Exit with appropriate code
exit 0
```

---

## Related Documentation

- [DEVELOPER_GUIDE.md](./DEVELOPER_GUIDE.md) - Architecture and implementation
- [CONFIGURATION_GUIDE.md](./CONFIGURATION_GUIDE.md) - All configuration options
- [AGENTS_REFERENCE.md](./AGENTS_REFERENCE.md) - Agent specifications
- [COMMANDS_REFERENCE.md](./COMMANDS_REFERENCE.md) - Command reference

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
