# Skills Directory

This folder contains custom tool definitions that teach Claude how to use specific tools and commands in your project.

## What Are Skills?

Skills are detailed instructions for performing specific technical tasks. They bridge the gap between Claude's general knowledge and your project's specific tooling.

## When to Create a Skill

Create a skill when:
- A task requires specific commands or tools
- The same sequence is repeated often
- The process has common pitfalls to avoid
- New team members need to learn a process

## File Organization

```
skills/
├── README.md           # This file
├── git-workflow.md     # Git operations
├── database/           # Database-related skills
│   ├── migrations.md
│   └── queries.md
└── deployment/         # Deployment skills
    └── staging.md
```

## Skill Template

```markdown
# [Skill Name]

## Purpose
What this skill enables Claude to do.

## Prerequisites
- Required software
- Required permissions
- Required environment

## Commands

### [Action Name]
\`\`\`bash
command here
\`\`\`
**When to use**: [explanation]
**Expected output**: [what success looks like]

## Verification
How to confirm success:
\`\`\`bash
verification command
\`\`\`

## Troubleshooting

### Error: [Error Message]
**Cause**: [why]
**Solution**: [how to fix]
```

## Available Skills

| Skill | File | Purpose |
|-------|------|---------|
| Git Workflow | `git-workflow.md` | Git operations |
| (Add more as you create them) | | |

## Using Skills

Skills are automatically available when Claude needs to perform the relevant task. You can also explicitly request:

```
> Use the git workflow skill to create a feature branch
```

## Best Practices

1. **Include exact commands**: Copy-paste ready
2. **Show expected output**: So success is recognizable
3. **Cover common errors**: Save troubleshooting time
4. **Keep skills focused**: One topic per skill
5. **Update when tools change**: Keep skills current
