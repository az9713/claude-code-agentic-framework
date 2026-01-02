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
> /project:prime
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
| `/project:prime` | Load full project context |
| `/project:plan` | Create an implementation plan |
| `/project:build` | Implement from a plan |
| `/project:review` | Quality analysis |
| `/project:fix` | Address review findings |
| `/project:cycle` | Complete Plan-Build-Review-Fix |
| `/project:feature` | Full feature development |
| `/project:bugfix` | Bug investigation and fix |
| `/project:orchestrate` | Multi-agent coordination |
| `/project:delegate` | Direct agent invocation |
| `/project:init` | Initialize in new project |

---

## Part 3: 10 Beginner Use Cases

Complete these in order for the best learning experience.

---

### Use Case 1: Explore Your Project

**Goal**: Understand your codebase quickly.
**Time**: 3 minutes

```
> Give me an overview of this project's structure.
> List all folders and explain what each one is for.
```

Then dive deeper:

```
> Tell me about the agents/ folder. What agents are available?
```

And ask about specifics:

```
> What is the orchestrator agent and what does it do?
```

**What You Learned**: Claude can map out any codebase in minutes.

---

### Use Case 2: Explain Code Like I'm New

**Goal**: Understand unfamiliar code.
**Time**: 5 minutes

```
> Explain the code in commands/cycle.md like I'm a complete beginner.
> What does this command do step by step?
```

Ask follow-ups:

```
> What does "quality gate" mean in that context?
> Why do we loop until the score is 7 or higher?
```

**What You Learned**: Claude can explain any code at any level.

---

### Use Case 3: Create Your First Function

**Goal**: Have Claude write code for you.
**Time**: 5 minutes

```
> Create a file called app/utils/validators.js with these functions:
> 1. isValidEmail - checks if a string is a valid email
> 2. isValidPhone - checks if a string is a valid US phone number
> 3. isValidPassword - password with 8+ chars, uppercase, number
```

Review the proposal, then approve or request changes.

**What You Learned**: Specific instructions = better results.

---

### Use Case 4: Fix a Simple Bug

**Goal**: Experience debugging workflow.
**Time**: 5 minutes

```
> Create app/buggy.js with a function that calculates factorial,
> but make it have a bug where factorial(1) returns 0.
```

Then:

```
> There's a bug in app/buggy.js. When I call factorial(1),
> I get 0 instead of 1. Find and fix the bug.
```

**What You Learned**: Describe symptoms, Claude finds root cause.

---

### Use Case 5: Add Input Validation

**Goal**: Make code more robust.
**Time**: 5 minutes

```
> Read app/buggy.js. Update it to handle:
> - null or undefined input
> - Wrong type (string instead of number)
> - Negative numbers
> Each case should return a clear error message.
```

**What You Learned**: Good code handles bad input gracefully.

---

### Use Case 6: Write Unit Tests

**Goal**: Ensure code works correctly.
**Time**: 7 minutes

```
> Create tests/validators.test.js that tests all functions
> in app/utils/validators.js. Include tests for:
> - Valid inputs (should pass)
> - Invalid inputs (should fail)
> - Edge cases (empty strings, null)
```

**What You Learned**: Tests document expected behavior.

---

### Use Case 7: Use the Review Command

**Goal**: Get quality analysis.
**Time**: 5 minutes

```
> /project:review
```

Claude will analyze your code and produce a report with:
- Score (1-10)
- Critical/Major/Minor findings
- Specific recommendations

**What You Learned**: Reviews catch issues before they become problems.

---

### Use Case 8: Use the Fix Command

**Goal**: Address review findings automatically.
**Time**: 5 minutes

After running `/project:review`:

```
> /project:fix
```

Claude will:
1. Read the review findings
2. Prioritize by severity
3. Fix each issue
4. Verify the fixes

**What You Learned**: The fix command automates issue resolution.

---

### Use Case 9: Plan a Feature

**Goal**: Create a structured plan before building.
**Time**: 5 minutes

```
> /project:plan Add a simple TODO list manager with:
> - Add/delete todos
> - Mark complete
> - Save to JSON file
```

Review the plan Claude creates. It should include:
- Task breakdown
- Files to create
- Dependencies
- Risk assessment

**What You Learned**: Plan first, build second.

---

### Use Case 10: Build from Plan

**Goal**: Implement a planned feature.
**Time**: 10 minutes

After creating a plan:

```
> /project:build
```

Claude will:
1. Read the plan
2. Create files incrementally
3. Run tests
4. Document changes

**What You Learned**: Building from a plan ensures completeness.

---

## Part 4: 10 Advanced Use Cases

These showcase the full power of the Codebase Singularity.

---

### Use Case 11: The Complete Cycle

**Goal**: Experience the full Plan-Build-Review-Fix workflow.
**Time**: 15 minutes

```
> /project:cycle Add user input sanitization to all form handlers
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
> /project:delegate planner Design a REST API structure for user management
```

```
> /project:delegate security-auditor Audit the authentication module
```

```
> /project:delegate test-writer Write comprehensive tests for the API
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
> /project:orchestrate Implement a complete authentication system with:
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
> /project:feature Add a notification system that:
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
> /project:bugfix Users report that login fails after password change
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
> /project:orchestrate --parallel Create a data export feature
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
> /project:delegate security-auditor Review security requirements for payment processing
```

Then:

```
> /project:orchestrate Implement payment processing following security audit
```

Pattern: `security-auditor → planner → builder → security-auditor → reviewer`

**What You Learned**: Security checks before and after implementation.

---

### Use Case 18: Test-Driven Development

**Goal**: Write tests before implementation.
**Time**: 15 minutes

```
> /project:delegate planner Design the test cases for a caching layer
```

Then:

```
> /project:delegate test-writer Write failing tests for the caching layer
```

Then:

```
> /project:delegate builder Implement the caching layer to pass all tests
```

Pattern: `planner → test-writer → builder → reviewer → fixer`

**What You Learned**: Tests define expected behavior before code exists.

---

### Use Case 19: Documentation Research

**Goal**: Have Claude research and cache documentation.
**Time**: 10 minutes

```
> /project:delegate doc-fetcher Research JWT authentication best practices
> and save to ai_docs/
```

```
> /project:delegate doc-fetcher Get the official Express.js middleware documentation
```

Documentation is cached in `ai_docs/` for future reference.

**What You Learned**: Doc-fetcher builds a knowledge base for the project.

---

### Use Case 20: Initialize in New Project

**Goal**: Set up the framework in any project.
**Time**: 5 minutes

```
> /project:init
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

1. **Build a REST API**: Use `/project:feature` to create a complete API
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
> /project:prime
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
> /project:delegate
```
(Without arguments shows available agents)

### "Quality gate keeps failing"

Lower your standards temporarily:
```
> Accept review scores of 5 or higher for now
```

Or focus on critical issues only:
```
> /project:fix --critical-only
```

### "Orchestration is too slow"

Use parallel mode:
```
> /project:orchestrate --parallel [task]
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
/project:prime      - Load context
/project:plan       - Create plan
/project:build      - Implement plan
/project:review     - Quality check
/project:fix        - Address issues
```

### Workflow Commands
```
/project:cycle      - Full P-B-R-F cycle
/project:feature    - Feature development
/project:bugfix     - Bug investigation
```

### Orchestration
```
/project:orchestrate [task]           - Multi-agent
/project:orchestrate --parallel [task] - Parallel execution
/project:delegate [agent] [task]       - Direct delegation
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
