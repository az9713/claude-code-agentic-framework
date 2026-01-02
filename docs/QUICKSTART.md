# Quick Start Guide: Codebase Singularity

## Get Running in 5 Minutes + 20 Hands-On Use Cases

**Time to Complete**: 60-90 minutes
**Difficulty**: Beginner to Advanced
**What You'll Learn**: From first interaction to full autonomous workflows

---

## Table of Contents

- [Part 1: 5-Minute Setup](#part-1-5-minute-setup)
- [Part 2: Your First Interaction](#part-2-your-first-interaction)
- [Part 3: 10 Beginner Use Cases](#part-3-10-beginner-use-cases)
- [Part 4: 10 Advanced Use Cases](#part-4-10-advanced-use-cases)
- [Part 5: What's Next](#part-5-whats-next)
- [Troubleshooting Quick Fixes](#troubleshooting-quick-fixes)

---

## Part 1: 5-Minute Setup

### Step 1: Open Your Terminal (1 minute)

**Windows**: Press `Win`, type `cmd`, press `Enter`
**Mac**: Press `Cmd+Space`, type `Terminal`, press `Enter`
**Linux**: Press `Ctrl+Alt+T`

### Step 2: Navigate to Your Project (1 minute)

```bash
cd /path/to/your/project
```

### Step 3: Verify Claude is Installed (1 minute)

```bash
claude --version
```

If not installed:
```bash
npm install -g @anthropic-ai/claude-code
```

### Step 4: Start Claude (1 minute)

```bash
claude
```

You'll see the welcome screen with a `>` prompt.

### Step 5: Load Project Context (1 minute)

```
> /prime
```

**You're ready to go!**

---

## Part 2: Your First Interaction

Try this right now:

```
> Hello! Give me a 3-sentence summary of what this project is about.
```

**Expected Response**:
```
This project implements the Codebase Singularity - a framework where AI agents
operate your codebase autonomously. It includes 9 specialized agents, 11 workflow
commands, and quality gates that ensure code meets standards before completion.
Currently at Class 3, Grade 1+ - the highest level of the agentic framework.
```

### Quick Command Reference

| Command | What It Does |
|---------|--------------|
| `/prime` | Load full project context |
| `/plan` | Create an implementation plan |
| `/build` | Implement from a plan |
| `/review` | Quality analysis |
| `/fix` | Address review findings |
| `/cycle` | Complete Plan-Build-Review-Fix |
| `/feature` | Full feature development |
| `/bugfix` | Bug investigation and fix |
| `/orchestrate` | Multi-agent coordination |
| `/delegate` | Direct agent invocation |
| `/init` | Initialize in new project |

---

## Part 3: 10 Beginner Use Cases

Complete these in order for the best learning experience. Each use case demonstrates a core framework capability.

---

### Use Case 1: Prime Your Session

**Goal**: Load project context and activate the agentic layer.
**Time**: 2 minutes

```
> /prime
```

Claude will:
1. Read CLAUDE.md (project memory)
2. Load available commands and agents
3. Understand project structure and standards
4. Be ready to work with full context

**What You Learned**: Always start with `/prime` - it's the foundation of the agentic layer.

---

### Use Case 2: Plan Before You Build

**Goal**: Experience the planning phase with the planner agent.
**Time**: 5 minutes

```
> /plan Add input validation to user forms
```

The **planner agent** (using opus model) will:
- Analyze requirements
- Break down into tasks
- Identify files to modify
- Assess risks and dependencies
- Save plan to `specs/`

**What You Learned**: The framework enforces "plan first" - no cowboy coding.

---

### Use Case 3: Build from a Plan

**Goal**: Implement code using the builder agent.
**Time**: 7 minutes

After creating a plan:

```
> /build
```

The **builder agent** (using sonnet model) will:
1. Read the plan from `specs/`
2. Implement each task incrementally
3. Follow project coding standards
4. Create tests alongside code

**What You Learned**: Building from plans ensures nothing is missed.

---

### Use Case 4: Review Your Code

**Goal**: Get quality analysis from the reviewer agent.
**Time**: 5 minutes

```
> /review
```

The **reviewer agent** (using opus model) will produce:
- Quality score (1-10)
- Critical/Major/Minor findings
- Security concerns
- Test coverage gaps
- Specific recommendations

Review is saved to `specs/reviews/`.

**What You Learned**: The reviewer catches issues before they reach production.

---

### Use Case 5: Fix Review Findings

**Goal**: Address issues using the fixer agent.
**Time**: 5 minutes

After running `/review`:

```
> /fix
```

The **fixer agent** (using sonnet model) will:
1. Read findings from the review
2. Prioritize by severity (critical first)
3. Fix each issue systematically
4. Document changes made

**What You Learned**: Fix addresses review findings automatically.

---

### Use Case 6: Delegate to a Specific Agent

**Goal**: Learn direct agent invocation.
**Time**: 5 minutes

```
> /delegate test-writer Write tests for app/utils/validators.js
```

Available agents for delegation:
- `planner` - Architecture and design
- `builder` - Code implementation
- `reviewer` - Quality analysis
- `fixer` - Issue resolution
- `test-writer` - Test creation
- `doc-fetcher` - Documentation research
- `security-auditor` - Security review
- `refactorer` - Code improvement

**What You Learned**: Delegate gives you direct access to specialized agents.

---

### Use Case 7: The Review-Fix Loop

**Goal**: Experience iterative quality improvement.
**Time**: 10 minutes

Run review, then fix, then review again:

```
> /review
```

Note the score (e.g., 5/10). Then:

```
> /fix
```

Then review again:

```
> /review
```

The score should improve. This loop continues until quality gate passes (score >= 7).

**What You Learned**: The framework enforces quality through iteration.

---

### Use Case 8: Security Audit

**Goal**: Use the security-auditor agent.
**Time**: 5 minutes

```
> /delegate security-auditor Audit authentication handling
```

The **security-auditor agent** (using opus model) checks for:
- Injection vulnerabilities
- Authentication weaknesses
- Data exposure risks
- OWASP Top 10 issues

**What You Learned**: Security is a first-class concern with a dedicated agent.

---

### Use Case 9: Fetch Documentation

**Goal**: Use the doc-fetcher agent.
**Time**: 5 minutes

```
> /delegate doc-fetcher Research JWT best practices and save to ai_docs/
```

The **doc-fetcher agent** (using haiku model) will:
1. Search for relevant documentation
2. Extract key information
3. Save to `ai_docs/` for future reference
4. Summarize findings

**What You Learned**: Doc-fetcher builds a knowledge base for your project.

---

### Use Case 10: Complete Plan-Build-Review-Fix Cycle

**Goal**: Experience the full workflow in one command.
**Time**: 15 minutes

```
> /cycle Add error logging utility
```

This single command runs the complete cycle:
1. **Plan** - Planner agent designs the implementation
2. **Build** - Builder agent implements the code
3. **Review** - Reviewer agent analyzes quality
4. **Fix** - Fixer agent addresses issues
5. **Loop** - Repeat until score >= 7/10

**What You Learned**: The cycle command automates the entire development workflow.

---

## Part 4: 10 Advanced Use Cases

These showcase the full power of the Codebase Singularity.

---

### Use Case 11: The Complete Cycle

**Goal**: Experience the full Plan-Build-Review-Fix workflow.
**Time**: 15 minutes

```
> /cycle Add user input sanitization to all form handlers
```

This single command:
1. **Plans** the implementation
2. **Builds** the code
3. **Reviews** for quality
4. **Fixes** any issues
5. **Loops** until quality gate passes (score ≥ 7/10)

**What You Learned**: One command for complete feature development.

---

### Use Case 12: Delegate to Specific Agents

**Goal**: Use specialized agents directly.
**Time**: 10 minutes

```
> /delegate planner Design a REST API structure for user management
```

```
> /delegate security-auditor Audit the authentication module
```

```
> /delegate test-writer Write comprehensive tests for the API
```

Available agents:
- `planner` - Architecture and planning (opus)
- `builder` - Code implementation (sonnet)
- `reviewer` - Quality analysis (opus)
- `fixer` - Issue resolution (sonnet)
- `test-writer` - Test creation (sonnet)
- `doc-fetcher` - Documentation research (haiku)
- `security-auditor` - Security analysis (opus)
- `refactorer` - Code improvement (sonnet)

**What You Learned**: Direct delegation for focused tasks.

---

### Use Case 13: Multi-Agent Orchestration

**Goal**: Coordinate multiple agents on a complex task.
**Time**: 20 minutes

```
> /orchestrate Implement a complete authentication system with:
> - User registration
> - Login/logout
> - Password reset
> - Session management
> - Security best practices
```

The orchestrator will:
1. Decompose into subtasks
2. Assign agents to each subtask
3. Run tasks in parallel where possible
4. Aggregate results
5. Handle errors

**What You Learned**: Complex features need multi-agent coordination.

---

### Use Case 14: Feature Development Workflow

**Goal**: Use the end-to-end feature command.
**Time**: 15 minutes

```
> /feature Add a notification system that:
> - Supports email and in-app notifications
> - Has user preferences for notification types
> - Includes a notification queue
> - Has retry logic for failed sends
```

This workflow:
1. Gathers requirements (may ask questions)
2. Creates detailed plan
3. Gets your approval
4. Builds with tests
5. Reviews for quality
6. Fixes issues until passing

**What You Learned**: Feature command handles the entire lifecycle.

---

### Use Case 15: Bug Investigation Workflow

**Goal**: Use structured bug investigation.
**Time**: 10 minutes

```
> /bugfix Users report that login fails after password change
```

The bugfix workflow:
1. **Intake**: Gathers bug information
2. **Investigate**: Reproduces and locates bug
3. **Plan**: Designs the fix approach
4. **Implement**: Fixes with test-first approach
5. **Verify**: Confirms fix and no regressions

**What You Learned**: Systematic debugging prevents quick-fix thinking.

---

### Use Case 16: Parallel Agent Execution

**Goal**: Run multiple agents simultaneously.
**Time**: 15 minutes

```
> /orchestrate --parallel Create a data export feature
```

With `--parallel` flag:
- Independent tasks run concurrently
- Results are aggregated when all complete
- Faster than sequential execution

Example parallel groups:
```
Group A: [doc-fetcher] [planner]     ← Run simultaneously
Group B: [builder]                    ← Wait for A
Group C: [test-writer] [security]     ← Run simultaneously
Group D: [reviewer]                   ← Wait for C
```

**What You Learned**: Parallel execution speeds up complex tasks.

---

### Use Case 17: Security-First Development

**Goal**: Build with security as the priority.
**Time**: 15 minutes

```
> /delegate security-auditor Review security requirements for payment processing
```

Then:

```
> /orchestrate Implement payment processing following security audit
```

Pattern: `security-auditor → planner → builder → security-auditor → reviewer`

**What You Learned**: Security checks before and after implementation.

---

### Use Case 18: Test-Driven Development

**Goal**: Write tests before implementation.
**Time**: 15 minutes

```
> /delegate planner Design the test cases for a caching layer
```

Then:

```
> /delegate test-writer Write failing tests for the caching layer
```

Then:

```
> /delegate builder Implement the caching layer to pass all tests
```

Pattern: `planner → test-writer → builder → reviewer → fixer`

**What You Learned**: Tests define expected behavior before code exists.

---

### Use Case 19: Documentation Research

**Goal**: Have Claude research and cache documentation.
**Time**: 10 minutes

```
> /delegate doc-fetcher Research JWT authentication best practices
> and save to ai_docs/
```

```
> /delegate doc-fetcher Get the official Express.js middleware documentation
```

Documentation is cached in `ai_docs/` for future reference.

**What You Learned**: Doc-fetcher builds a knowledge base for the project.

---

### Use Case 20: Initialize in New Project

**Goal**: Set up the framework in any project.
**Time**: 5 minutes

```
> /init
```

This creates:
- `CLAUDE.md` - Memory file
- `commands/` - Workflow commands
- `agents/` - Agent definitions
- `specs/` - Plans and reviews
- `ai_docs/` - Documentation cache

**What You Learned**: The framework is portable to any project.

---

## Part 5: What's Next

### You've Completed the Guide!

You now know how to:

**Beginner Skills**:
- ✅ Navigate and explore projects
- ✅ Create new functions and files
- ✅ Fix bugs methodically
- ✅ Write unit tests
- ✅ Use review and fix commands

**Advanced Skills**:
- ✅ Execute complete Plan-Build-Review-Fix cycles
- ✅ Delegate to specialized agents
- ✅ Orchestrate multi-agent workflows
- ✅ Use feature and bugfix workflows
- ✅ Implement security-first development
- ✅ Practice test-driven development

### Mastery Challenges

Try these on your own:

1. **Build a REST API**: Use `/feature` to create a complete API
2. **Migrate a codebase**: Use orchestration to refactor legacy code
3. **Security audit**: Use the security-auditor on an existing project
4. **Custom agent**: Create a new agent for your specific needs
5. **Custom command**: Create a workflow for your team's process

### Deep Dive Topics

When you're ready, explore:

- **Agent customization**: `agents/` directory
- **Hooks and automation**: `hooks/` directory
- **Skills development**: `skills/` directory
- **MCP integration**: `.mcp.json`

See `docs/DEVELOPER_GUIDE.md` for technical details.

---

## Troubleshooting Quick Fixes

### "Claude doesn't understand my project"

```
> /prime
```
This reloads all project context.

### "Command not found"

Make sure commands exist in `commands/` directory:
```bash
ls commands/
```

### "Agent not working"

Check available agents:
```
> /delegate
```
(Without arguments shows available agents)

### "Quality gate keeps failing"

Lower your standards temporarily:
```
> Accept review scores of 5 or higher for now
```

Or focus on critical issues only:
```
> /fix --critical-only
```

### "Orchestration is too slow"

Use parallel mode:
```
> /orchestrate --parallel [task]
```

### "Changes aren't what I wanted"

Press `3` (No) and be more specific:
```
> Let me be clearer. I need [detailed explanation]
```

### "Too complex, start over"

```
> Let's start fresh. Here's exactly what I need: [clear requirements]
```

---

## Quick Reference Card

### Core Commands
```
/prime      - Load context
/plan       - Create plan
/build      - Implement plan
/review     - Quality check
/fix        - Address issues
```

### Workflow Commands
```
/cycle      - Full P-B-R-F cycle
/feature    - Feature development
/bugfix     - Bug investigation
```

### Orchestration
```
/orchestrate [task]           - Multi-agent
/orchestrate --parallel [task] - Parallel execution
/delegate [agent] [task]       - Direct delegation
```

### Available Agents
```
planner           - Planning (opus)
builder           - Implementation (sonnet)
reviewer          - Quality analysis (opus)
fixer             - Issue resolution (sonnet)
test-writer       - Test creation (sonnet)
doc-fetcher       - Documentation (haiku)
security-auditor  - Security analysis (opus)
refactorer        - Code improvement (sonnet)
orchestrator      - Multi-agent coordination (opus)
```

### Quality Gate
```
Score ≥ 7/10 = PASS
Score < 7/10 = Loop back to FIX
```

---

## Congratulations!

You've mastered the Codebase Singularity framework. You can now:

- Let AI agents operate your codebase autonomously
- Coordinate multiple specialized agents
- Execute complete development workflows
- Maintain quality through automated gates

**Welcome to the future of development!**

---

**Documentation Links:**
- Full User Guide: `docs/USER_GUIDE.md`
- Developer Guide: `docs/DEVELOPER_GUIDE.md`
- Architecture: `docs/ARCHITECTURE.md`
- Project Memory: `CLAUDE.md`

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
