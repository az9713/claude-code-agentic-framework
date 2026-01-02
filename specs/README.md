# Specifications Directory

This folder contains implementation plans and specifications created before building features.

## Purpose

- Store detailed plans before implementation
- Document design decisions
- Track feature requirements
- Serve as reference during development

## File Naming Convention

```
[feature-name]-plan.md
[feature-name]-spec.md
[date]-[feature-name].md
```

Examples:
- `user-authentication-plan.md`
- `2026-01-01-todo-list-spec.md`
- `api-redesign-plan.md`

## Template

When creating a new plan, use `/plan` command or follow this template:

```markdown
# Implementation Plan: [Feature Name]

## Overview
[Brief description]

## Requirements
- Requirement 1
- Requirement 2

## Implementation Steps
1. Step 1
2. Step 2

## Testing Strategy
- Test case 1
- Test case 2
```

## Usage

1. Create plan: `/plan` + describe what you want
2. Review and approve the plan
3. Implement: `/build`
4. Review: `/review`
