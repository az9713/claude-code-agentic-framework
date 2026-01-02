# Architecture: Codebase Singularity

## System Design and Technical Architecture

This document provides comprehensive architectural documentation for the Codebase Singularity plugin, including system design, component interactions, data flows, and design decisions.

---

## Table of Contents

1. [System Overview](#1-system-overview)
2. [Layer Architecture](#2-layer-architecture)
3. [Component Architecture](#3-component-architecture)
4. [Agent Architecture](#4-agent-architecture)
5. [Command Flow Architecture](#5-command-flow-architecture)
6. [Orchestration Architecture](#6-orchestration-architecture)
7. [Quality Gate Architecture](#7-quality-gate-architecture)
8. [Hook System Architecture](#8-hook-system-architecture)
9. [Data Flow Diagrams](#9-data-flow-diagrams)
10. [File System Layout](#10-file-system-layout)
11. [Design Decisions](#11-design-decisions)
12. [Extension Points](#12-extension-points)

---

## 1. System Overview

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         CODEBASE SINGULARITY                                 │
│                         Class 3, Grade 1+                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      ORCHESTRATION LAYER                             │    │
│  │  ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐        │    │
│  │  │Orchestrate│  │  Delegate │  │  Feature  │  │  Bugfix   │        │    │
│  │  │  Command  │  │  Command  │  │  Command  │  │  Command  │        │    │
│  │  └─────┬─────┘  └─────┬─────┘  └─────┬─────┘  └─────┬─────┘        │    │
│  │        │              │              │              │               │    │
│  │        └──────────────┴──────────────┴──────────────┘               │    │
│  │                              │                                       │    │
│  │                    ┌─────────▼─────────┐                            │    │
│  │                    │   ORCHESTRATOR    │                            │    │
│  │                    │      AGENT        │                            │    │
│  │                    └─────────┬─────────┘                            │    │
│  └──────────────────────────────┼──────────────────────────────────────┘    │
│                                 │                                            │
│  ┌──────────────────────────────┼──────────────────────────────────────┐    │
│  │                      WORKFLOW LAYER                                  │    │
│  │                                                                      │    │
│  │    ┌────────┐    ┌────────┐    ┌────────┐    ┌────────┐            │    │
│  │    │  PLAN  │───►│ BUILD  │───►│ REVIEW │───►│  FIX   │            │    │
│  │    └────────┘    └────────┘    └────────┘    └───┬────┘            │    │
│  │         ▲                                        │                  │    │
│  │         └────────── Loop until score ≥ 7 ◄───────┘                  │    │
│  │                                                                      │    │
│  └──────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐    │
│  │                      FOUNDATION LAYER                                 │    │
│  │                                                                       │    │
│  │  ┌─────────────────────────────────────────────────────────────┐    │    │
│  │  │                     SPECIALIZED AGENTS                       │    │    │
│  │  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │    │    │
│  │  │  │ Planner │ │ Builder │ │Reviewer │ │  Fixer  │           │    │    │
│  │  │  │ (opus)  │ │(sonnet) │ │ (opus)  │ │(sonnet) │           │    │    │
│  │  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘           │    │    │
│  │  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │    │    │
│  │  │  │  Test   │ │   Doc   │ │Security │ │Refactor │           │    │    │
│  │  │  │ Writer  │ │ Fetcher │ │ Auditor │ │   er    │           │    │    │
│  │  │  │(sonnet) │ │ (haiku) │ │ (opus)  │ │(sonnet) │           │    │    │
│  │  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘           │    │    │
│  │  └─────────────────────────────────────────────────────────────┘    │    │
│  │                                                                       │    │
│  │  ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐         │    │
│  │  │  Skills   │  │   Hooks   │  │    MCP    │  │  Memory   │         │    │
│  │  │ (4 total) │  │(lifecycle)│  │ (servers) │  │(CLAUDE.md)│         │    │
│  │  └───────────┘  └───────────┘  └───────────┘  └───────────┘         │    │
│  │                                                                       │    │
│  └──────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Classification System

```
CLASS 3: ORCHESTRATION    ─── Multi-agent coordination
    │                         Parallel execution
    │                         Task decomposition
    │
CLASS 2: WORKFLOW         ─── E2E workflows (P-B-R-F)
    │                         Quality gates
    │                         Portable structure
    │
CLASS 1: FOUNDATION       ─── Grade 4: Hooks (feedback loops)
                              Grade 3: Skills + MCP
                              Grade 2: Specialized agents
                              Grade 1: Memory (CLAUDE.md)
```

---

## 2. Layer Architecture

### 2.1 Agentic vs Application Layer

```
┌─────────────────────────────────────────────────────────────────┐
│                       AGENTIC LAYER                              │
│                                                                  │
│  Components that teach AI to operate your codebase:              │
│                                                                  │
│  • Plugin manifest (.claude-plugin/plugin.json)                  │
│  • Commands (commands/*.md)                                      │
│  • Agents (agents/*.md)                                          │
│  • Skills (skills/*/SKILL.md)                                    │
│  • Hooks (hooks/hooks.json + scripts/)                           │
│  • Memory (CLAUDE.md)                                            │
│  • MCP Configuration (.mcp.json)                                 │
│  • Specs (specs/plans/, specs/reviews/)                          │
│  • AI Docs (ai_docs/)                                            │
│                                                                  │
├─────────────────────────────────────────────────────────────────┤
│                      APPLICATION LAYER                           │
│                                                                  │
│  Your actual code that runs your application:                    │
│                                                                  │
│  • Source code (app/, src/, lib/)                                │
│  • Tests (tests/)                                                │
│  • Configuration (package.json, tsconfig.json, etc.)             │
│  • Dependencies (node_modules/, vendor/)                         │
│  • Build artifacts (dist/, build/)                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 Layer Interaction

```
                    User Request
                         │
                         ▼
              ┌──────────────────┐
              │  AGENTIC LAYER   │
              │                  │
              │  1. Parse intent │
              │  2. Select agent │
              │  3. Execute      │
              │  4. Verify       │
              └────────┬─────────┘
                       │
                       ▼
              ┌──────────────────┐
              │ APPLICATION LAYER│
              │                  │
              │  • Read files    │
              │  • Write files   │
              │  • Run commands  │
              │  • Execute tests │
              └────────┬─────────┘
                       │
                       ▼
                    Results
```

---

## 3. Component Architecture

### 3.1 Plugin Component Hierarchy

```
Plugin
├── Manifest (plugin.json)
│   ├── name
│   ├── version
│   ├── entryPoints
│   │   ├── commands → commands/
│   │   ├── agents → agents/
│   │   ├── skills → skills/
│   │   └── hooks → hooks/hooks.json
│   ├── memory → CLAUDE.md
│   └── mcp → .mcp.json
│
├── Commands (11)
│   ├── Core Workflow
│   │   ├── prime.md
│   │   ├── plan.md
│   │   ├── build.md
│   │   ├── review.md
│   │   └── fix.md
│   ├── E2E Workflow
│   │   ├── cycle.md
│   │   ├── feature.md
│   │   └── bugfix.md
│   ├── Orchestration
│   │   ├── orchestrate.md
│   │   └── delegate.md
│   └── Utility
│       └── init.md
│
├── Agents (9)
│   ├── 00-orchestrator.md (opus)
│   ├── 01-planner.md (opus)
│   ├── 02-builder.md (sonnet)
│   ├── 03-reviewer.md (opus)
│   ├── 04-fixer.md (sonnet)
│   ├── 05-test-writer.md (sonnet)
│   ├── 06-doc-fetcher.md (haiku)
│   ├── 07-security-auditor.md (opus)
│   └── 08-refactorer.md (sonnet)
│
├── Skills (4)
│   ├── git-workflow/
│   ├── testing/
│   ├── code-review/
│   └── project-workflow/
│
├── Hooks
│   ├── hooks.json (configuration)
│   └── scripts/
│       ├── auto-lint.sh
│       ├── protect-files.sh
│       ├── log-subagent.sh
│       └── quality-gate.sh
│
└── Support Files
    ├── CLAUDE.md (memory)
    ├── .mcp.json (MCP servers)
    └── templates/settings.json
```

### 3.2 Component Dependencies

```
                    ┌─────────────┐
                    │  Commands   │
                    └──────┬──────┘
                           │ invoke
                           ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Skills    │◄───│   Agents    │───►│    Hooks    │
└─────────────┘    └──────┬──────┘    └─────────────┘
                          │ use
                          ▼
              ┌───────────────────────┐
              │        Tools          │
              │ (Read, Write, Edit,   │
              │  Bash, Glob, Grep,    │
              │  Task, WebSearch...)  │
              └───────────┬───────────┘
                          │ access
                          ▼
              ┌───────────────────────┐
              │    MCP Servers        │
              │ (filesystem, github,  │
              │  memory, etc.)        │
              └───────────────────────┘
```

---

## 4. Agent Architecture

### 4.1 Agent Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                        AGENT DEFINITION                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   YAML FRONTMATTER                       │    │
│  │  ---                                                     │    │
│  │  name: agent-name                                        │    │
│  │  description: What this agent does                       │    │
│  │  tools:                                                  │    │
│  │    - Tool1                                               │    │
│  │    - Tool2                                               │    │
│  │  model: opus|sonnet|haiku                                │    │
│  │  ---                                                     │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                   PROMPT CONTENT                         │    │
│  │                                                          │    │
│  │  # Agent Name                                            │    │
│  │                                                          │    │
│  │  ## Role                                                 │    │
│  │  [Role description]                                      │    │
│  │                                                          │    │
│  │  ## Responsibilities                                     │    │
│  │  - Responsibility 1                                      │    │
│  │  - Responsibility 2                                      │    │
│  │                                                          │    │
│  │  ## Process                                              │    │
│  │  1. Step 1                                               │    │
│  │  2. Step 2                                               │    │
│  │                                                          │    │
│  │  ## Output Format                                        │    │
│  │  [Expected output structure]                             │    │
│  │                                                          │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Agent Hierarchy

```
                         ┌──────────────────┐
                         │   ORCHESTRATOR   │
                         │     (opus)       │
                         │                  │
                         │ Coordinates all  │
                         │ other agents     │
                         └────────┬─────────┘
                                  │
            ┌─────────────────────┼─────────────────────┐
            │                     │                     │
            ▼                     ▼                     ▼
    ┌───────────────┐    ┌───────────────┐    ┌───────────────┐
    │    PLANNER    │    │    BUILDER    │    │   REVIEWER    │
    │    (opus)     │    │   (sonnet)    │    │    (opus)     │
    │               │    │               │    │               │
    │  • Planning   │    │  • Code impl  │    │  • Quality    │
    │  • Research   │    │  • Features   │    │  • Scoring    │
    │  • Design     │    │  • Refactors  │    │  • Findings   │
    └───────┬───────┘    └───────┬───────┘    └───────┬───────┘
            │                    │                    │
            │            ┌───────┴───────┐            │
            │            │               │            │
            ▼            ▼               ▼            ▼
    ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
    │ DOC-FETCHER  │ │ TEST-WRITER  │ │  REFACTORER  │ │    FIXER     │
    │   (haiku)    │ │   (sonnet)   │ │   (sonnet)   │ │   (sonnet)   │
    └──────────────┘ └──────────────┘ └──────────────┘ └──────┬───────┘
                                                              │
                                                       ┌──────┴───────┐
                                                       ▼              ▼
                                               ┌──────────────┐ ┌──────────────┐
                                               │   SECURITY   │ │   FUTURE     │
                                               │   AUDITOR    │ │   AGENTS     │
                                               │    (opus)    │ │    (...)     │
                                               └──────────────┘ └──────────────┘
```

### 4.3 Agent Tool Allocation

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         AGENT TOOL MATRIX                                │
├──────────────────┬──────┬───────┬──────┬──────┬──────┬───────┬────────┤
│      Agent       │ Read │ Write │ Edit │ Bash │ Task │Web*   │ Model  │
├──────────────────┼──────┼───────┼──────┼──────┼──────┼───────┼────────┤
│ orchestrator     │  ✓   │   ✓   │  -   │  -   │  ✓   │   -   │ opus   │
│ planner          │  ✓   │   -   │  -   │  -   │  -   │   ✓   │ opus   │
│ builder          │  ✓   │   ✓   │  ✓   │  ✓   │  -   │   -   │ sonnet │
│ reviewer         │  ✓   │   -   │  -   │  -   │  -   │   -   │ opus   │
│ fixer            │  ✓   │   ✓   │  ✓   │  ✓   │  -   │   -   │ sonnet │
│ test-writer      │  ✓   │   ✓   │  ✓   │  -   │  -   │   -   │ sonnet │
│ doc-fetcher      │  ✓   │   ✓   │  -   │  -   │  -   │   ✓   │ haiku  │
│ security-auditor │  ✓   │   -   │  -   │  -   │  -   │   -   │ opus   │
│ refactorer       │  ✓   │   ✓   │  ✓   │  -   │  -   │   -   │ sonnet │
└──────────────────┴──────┴───────┴──────┴──────┴──────┴───────┴────────┘

*Web = WebSearch + WebFetch
All agents have access to Glob and Grep
```

---

## 5. Command Flow Architecture

### 5.1 Command Execution Flow

```
                         User Input
                    /project:command args
                             │
                             ▼
                  ┌─────────────────────┐
                  │  Command Resolver   │
                  │                     │
                  │ 1. Parse command    │
                  │ 2. Load .md file    │
                  │ 3. Extract YAML     │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │  Context Loader     │
                  │                     │
                  │ 1. Read CLAUDE.md   │
                  │ 2. Load relevant    │
                  │    project context  │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │ Command Processor   │
                  │                     │
                  │ Execute instructions│
                  │ from command .md    │
                  └──────────┬──────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
        ┌──────────┐  ┌──────────┐  ┌──────────┐
        │ Direct   │  │  Agent   │  │  Multi-  │
        │Execution │  │Delegation│  │  Agent   │
        └────┬─────┘  └────┬─────┘  └────┬─────┘
             │             │             │
             └─────────────┴─────────────┘
                           │
                           ▼
                  ┌─────────────────────┐
                  │     Output          │
                  │                     │
                  │ • Files created     │
                  │ • Reports generated │
                  │ • Status displayed  │
                  └─────────────────────┘
```

### 5.2 Plan-Build-Review-Fix Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        PLAN-BUILD-REVIEW-FIX CYCLE                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────────┐                                                       │
│  │   /project:plan  │                                                       │
│  │                  │                                                       │
│  │  Input:          │                                                       │
│  │  • Feature desc  │                                                       │
│  │                  │                                                       │
│  │  Agent: planner  │                                                       │
│  │                  │                                                       │
│  │  Output:         │───────────────────┐                                   │
│  │  • Plan file     │                   │                                   │
│  └──────────────────┘                   │                                   │
│                                         ▼                                   │
│                             ┌──────────────────────┐                        │
│                             │ specs/plans/[date]-  │                        │
│                             │ [feature].md         │                        │
│                             └──────────┬───────────┘                        │
│                                        │                                    │
│  ┌──────────────────┐                  │                                    │
│  │  /project:build  │◄─────────────────┘                                    │
│  │                  │                                                       │
│  │  Input:          │                                                       │
│  │  • Plan file     │                                                       │
│  │                  │                                                       │
│  │  Agent: builder  │                                                       │
│  │                  │                                                       │
│  │  Output:         │───────────────────┐                                   │
│  │  • Code files    │                   │                                   │
│  └──────────────────┘                   │                                   │
│                                         ▼                                   │
│                             ┌──────────────────────┐                        │
│                             │    app/[feature]/    │                        │
│                             │    tests/[feature]/  │                        │
│                             └──────────┬───────────┘                        │
│                                        │                                    │
│  ┌──────────────────┐                  │                                    │
│  │ /project:review  │◄─────────────────┘                                    │
│  │                  │                                                       │
│  │  Input:          │                                                       │
│  │  • Code changes  │                                                       │
│  │                  │                                                       │
│  │  Agent: reviewer │                                                       │
│  │                  │                                                       │
│  │  Output:         │───────────────────┐                                   │
│  │  • Review report │                   │                                   │
│  │  • Score (1-10)  │                   │                                   │
│  └──────────────────┘                   ▼                                   │
│                             ┌──────────────────────┐                        │
│                             │specs/reviews/[date]- │                        │
│                             │review.md             │                        │
│                             └──────────┬───────────┘                        │
│                                        │                                    │
│                             ┌──────────▼───────────┐                        │
│                             │    Score ≥ 7?        │                        │
│                             └──────────┬───────────┘                        │
│                                   │         │                               │
│                                  Yes        No                              │
│                                   │         │                               │
│                                   ▼         ▼                               │
│                             ┌─────────┐ ┌─────────┐                         │
│                             │COMPLETE │ │ FIX     │                         │
│                             └─────────┘ └────┬────┘                         │
│                                              │                              │
│  ┌──────────────────┐                        │                              │
│  │   /project:fix   │◄───────────────────────┘                              │
│  │                  │                                                       │
│  │  Input:          │                                                       │
│  │  • Review report │                                                       │
│  │                  │                                                       │
│  │  Agent: fixer    │                                                       │
│  │                  │                                                       │
│  │  Output:         │                                                       │
│  │  • Fixed code    │───────────────────────────┐                           │
│  └──────────────────┘                           │                           │
│                                                 │                           │
│                                                 └───────► Back to REVIEW    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Orchestration Architecture

### 6.1 Orchestrator Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ORCHESTRATION FLOW                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Task Request                                                                │
│       │                                                                      │
│       ▼                                                                      │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      TASK ANALYSIS                                   │    │
│  │                                                                      │    │
│  │  • Parse task description                                            │    │
│  │  • Identify required capabilities                                    │    │
│  │  • Estimate complexity                                               │    │
│  └──────────────────────────────┬──────────────────────────────────────┘    │
│                                 │                                            │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      TASK DECOMPOSITION                              │    │
│  │                                                                      │    │
│  │  Complex Task ──► Subtask 1 + Subtask 2 + ... + Subtask N           │    │
│  │                                                                      │    │
│  └──────────────────────────────┬──────────────────────────────────────┘    │
│                                 │                                            │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      DEPENDENCY MAPPING                              │    │
│  │                                                                      │    │
│  │  ┌────┐     ┌────┐     ┌────┐                                       │    │
│  │  │ T1 │────►│ T3 │────►│ T5 │                                       │    │
│  │  └────┘     └────┘     └────┘                                       │    │
│  │             ▲                                                        │    │
│  │  ┌────┐    │                                                        │    │
│  │  │ T2 │────┘                                                        │    │
│  │  └────┘         ┌────┐                                              │    │
│  │                 │ T4 │─────►(depends on T3)                         │    │
│  │                 └────┘                                              │    │
│  │                                                                      │    │
│  └──────────────────────────────┬──────────────────────────────────────┘    │
│                                 │                                            │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      AGENT ASSIGNMENT                                │    │
│  │                                                                      │    │
│  │  T1: Research ────────► doc-fetcher                                 │    │
│  │  T2: Design ──────────► planner                                     │    │
│  │  T3: Implement ───────► builder                                     │    │
│  │  T4: Security ────────► security-auditor                            │    │
│  │  T5: Review ──────────► reviewer                                    │    │
│  │                                                                      │    │
│  └──────────────────────────────┬──────────────────────────────────────┘    │
│                                 │                                            │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      PARALLEL GROUPING                               │    │
│  │                                                                      │    │
│  │  Group A: [T1, T2]     ◄── No dependencies, run parallel            │    │
│  │  Group B: [T3]          ◄── Depends on A                            │    │
│  │  Group C: [T4]          ◄── Depends on B                            │    │
│  │  Group D: [T5]          ◄── Depends on C                            │    │
│  │                                                                      │    │
│  └──────────────────────────────┬──────────────────────────────────────┘    │
│                                 │                                            │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      EXECUTION                                       │    │
│  │                                                                      │    │
│  │  Group A ──► Group B ──► Group C ──► Group D                        │    │
│  │                                                                      │    │
│  │  [doc-fetcher][planner] ──► [builder] ──► [security] ──► [reviewer] │    │
│  │                                                                      │    │
│  └──────────────────────────────┬──────────────────────────────────────┘    │
│                                 │                                            │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      RESULT AGGREGATION                              │    │
│  │                                                                      │    │
│  │  • Collect all agent outputs                                         │    │
│  │  • Combine into final result                                         │    │
│  │  • Generate summary report                                           │    │
│  │                                                                      │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Parallel Execution

```
                    Time ──────────────────────────────────────►

Group A:    ┌───────────────┐ ┌───────────────┐
            │  doc-fetcher  │ │    planner    │
            └───────┬───────┘ └───────┬───────┘
                    │                 │
                    └────────┬────────┘
                             │
Group B:                     ▼
                    ┌───────────────────────┐
                    │       builder         │
                    └───────────┬───────────┘
                                │
                    ┌───────────┴───────────┐
                    │                       │
Group C:    ┌───────▼───────┐      ┌───────▼───────┐
            │ test-writer   │      │   security    │
            └───────┬───────┘      └───────┬───────┘
                    │                      │
                    └──────────┬───────────┘
                               │
Group D:                       ▼
                    ┌─────────────────────┐
                    │      reviewer       │
                    └─────────────────────┘
```

---

## 7. Quality Gate Architecture

### 7.1 Quality Gate System

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          QUALITY GATES                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        GATE 1: PLAN APPROVAL                         │    │
│  │                                                                      │    │
│  │  Trigger: After /project:plan completes                             │    │
│  │  Criteria: Human review and explicit approval                       │    │
│  │  Pass: User approves plan                                           │    │
│  │  Fail: User requests changes → back to planning                     │    │
│  │                                                                      │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                      │                                       │
│                                      ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        GATE 2: TEST PASSAGE                          │    │
│  │                                                                      │    │
│  │  Trigger: After /project:build completes                            │    │
│  │  Criteria: All tests must pass                                      │    │
│  │  Pass: All tests green                                              │    │
│  │  Fail: Test failures → fix tests first                              │    │
│  │                                                                      │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                      │                                       │
│                                      ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        GATE 3: REVIEW SCORE                          │    │
│  │                                                                      │    │
│  │  Trigger: After /project:review completes                           │    │
│  │  Criteria: Score ≥ 7/10, no critical findings                       │    │
│  │  Pass: Score meets threshold                                        │    │
│  │  Fail: Score below threshold → trigger /project:fix                 │    │
│  │                                                                      │    │
│  │  Scoring:                                                           │    │
│  │  ┌────────────────┬────────┬─────────────────────────────────────┐ │    │
│  │  │   Category     │ Weight │         Criteria                    │ │    │
│  │  ├────────────────┼────────┼─────────────────────────────────────┤ │    │
│  │  │ Correctness    │  30%   │ Does it work as specified?          │ │    │
│  │  │ Code Quality   │  25%   │ Clean, readable, maintainable?      │ │    │
│  │  │ Test Coverage  │  20%   │ Are critical paths tested?          │ │    │
│  │  │ Security       │  15%   │ Any vulnerabilities?                │ │    │
│  │  │ Performance    │  10%   │ Any obvious bottlenecks?            │ │    │
│  │  └────────────────┴────────┴─────────────────────────────────────┘ │    │
│  │                                                                      │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                      │                                       │
│                                      ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        GATE 4: SECURITY CHECK (Optional)             │    │
│  │                                                                      │    │
│  │  Trigger: After implementation, before deploy                       │    │
│  │  Criteria: No high-severity vulnerabilities                         │    │
│  │  Pass: Security auditor approval                                    │    │
│  │  Fail: Security issues → must fix before proceeding                 │    │
│  │                                                                      │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.2 Review Score Visualization

```
                    REVIEW SCORE BREAKDOWN

    ┌────────────────────────────────────────────┐
    │                                            │
    │  Correctness (30%)    ████████████░░░ 8/10 │
    │  Code Quality (25%)   ██████████░░░░░ 7/10 │
    │  Test Coverage (20%)  █████████░░░░░░ 6/10 │
    │  Security (15%)       ████████████████ 9/10│
    │  Performance (10%)    ██████████░░░░░ 7/10 │
    │                                            │
    │  ─────────────────────────────────────────│
    │  WEIGHTED SCORE:      ██████████████░░ 7.4 │
    │                                            │
    │  STATUS: ✓ PASS (≥ 7.0)                   │
    │                                            │
    └────────────────────────────────────────────┘
```

---

## 8. Hook System Architecture

### 8.1 Hook Lifecycle

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           HOOK LIFECYCLE                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│                    ┌────────────────────────────────────┐                   │
│                    │         Tool Invocation            │                   │
│                    └──────────────────┬─────────────────┘                   │
│                                       │                                      │
│                                       ▼                                      │
│                    ┌────────────────────────────────────┐                   │
│                    │        PreToolUse Hook             │                   │
│                    │                                    │                   │
│                    │  • protect-files.sh                │                   │
│                    │  • Validation logic                │                   │
│                    │                                    │                   │
│                    │  Exit 0 = Allow                    │                   │
│                    │  Exit 1 = Block                    │                   │
│                    └──────────────────┬─────────────────┘                   │
│                                       │                                      │
│                            ┌──────────┴──────────┐                          │
│                            │                     │                          │
│                       Exit 0                 Exit 1                         │
│                            │                     │                          │
│                            ▼                     ▼                          │
│                    ┌───────────────┐    ┌───────────────┐                   │
│                    │ Tool Executes │    │ Tool Blocked  │                   │
│                    └───────┬───────┘    │ (with message)│                   │
│                            │            └───────────────┘                   │
│                            ▼                                                 │
│                    ┌────────────────────────────────────┐                   │
│                    │       PostToolUse Hook             │                   │
│                    │                                    │                   │
│                    │  • auto-lint.sh                    │                   │
│                    │  • Logging                         │                   │
│                    │  • Notifications                   │                   │
│                    │                                    │                   │
│                    └────────────────────────────────────┘                   │
│                                                                              │
│  ═══════════════════════════════════════════════════════════════════════════│
│                                                                              │
│                    ┌────────────────────────────────────┐                   │
│                    │      Sub-Agent Completion          │                   │
│                    └──────────────────┬─────────────────┘                   │
│                                       │                                      │
│                                       ▼                                      │
│                    ┌────────────────────────────────────┐                   │
│                    │       SubagentStop Hook            │                   │
│                    │                                    │                   │
│                    │  • log-subagent.sh                 │                   │
│                    │  • Activity logging                │                   │
│                    │  • Metrics collection              │                   │
│                    │                                    │                   │
│                    └────────────────────────────────────┘                   │
│                                                                              │
│  ═══════════════════════════════════════════════════════════════════════════│
│                                                                              │
│                    ┌────────────────────────────────────┐                   │
│                    │        Session Ending              │                   │
│                    └──────────────────┬─────────────────┘                   │
│                                       │                                      │
│                                       ▼                                      │
│                    ┌────────────────────────────────────┐                   │
│                    │           Stop Hook                │                   │
│                    │                                    │                   │
│                    │  • quality-gate.sh                 │                   │
│                    │  • Final verification              │                   │
│                    │  • Cleanup tasks                   │                   │
│                    │                                    │                   │
│                    └────────────────────────────────────┘                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 8.2 Hook Configuration

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tools": ["Edit", "Write"],
      "script": "scripts/auto-lint.sh"
    },
    {
      "event": "PreToolUse",
      "tools": ["Edit", "Write"],
      "script": "scripts/protect-files.sh"
    },
    {
      "event": "Stop",
      "script": "scripts/quality-gate.sh"
    },
    {
      "event": "SubagentStop",
      "script": "scripts/log-subagent.sh"
    }
  ]
}
```

---

## 9. Data Flow Diagrams

### 9.1 Complete System Data Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SYSTEM DATA FLOW                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│    User Input                                                                │
│        │                                                                     │
│        ▼                                                                     │
│   ┌─────────────────┐                                                       │
│   │  Command Parser │                                                       │
│   └────────┬────────┘                                                       │
│            │                                                                 │
│            ├────────────────┬───────────────┬───────────────┐               │
│            │                │               │               │               │
│            ▼                ▼               ▼               ▼               │
│     ┌───────────┐    ┌───────────┐   ┌───────────┐   ┌───────────┐        │
│     │CLAUDE.md  │    │ commands/ │   │  agents/  │   │  skills/  │        │
│     │ (memory)  │    │   (.md)   │   │   (.md)   │   │(SKILL.md) │        │
│     └─────┬─────┘    └─────┬─────┘   └─────┬─────┘   └─────┬─────┘        │
│           │                │               │               │               │
│           └────────────────┴───────────────┴───────────────┘               │
│                                    │                                        │
│                                    ▼                                        │
│                          ┌───────────────────┐                              │
│                          │   Agent Executor  │                              │
│                          └─────────┬─────────┘                              │
│                                    │                                        │
│            ┌───────────────────────┼───────────────────────┐               │
│            │                       │                       │               │
│            ▼                       ▼                       ▼               │
│     ┌───────────┐          ┌───────────┐          ┌───────────┐           │
│     │   Tools   │          │    MCP    │          │   Hooks   │           │
│     │Read,Write │          │ Servers   │          │  Scripts  │           │
│     │Edit,Bash  │          │           │          │           │           │
│     └─────┬─────┘          └─────┬─────┘          └─────┬─────┘           │
│           │                      │                      │                  │
│           ▼                      ▼                      ▼                  │
│     ┌───────────┐          ┌───────────┐          ┌───────────┐           │
│     │Application│          │ External  │          │   Logs    │           │
│     │   Files   │          │ Services  │          │  Reports  │           │
│     │(app/, src/│          │(GitHub,   │          │(specs/)   │           │
│     │ tests/)   │          │ DB, etc.) │          │           │           │
│     └───────────┘          └───────────┘          └───────────┘           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 9.2 Plan-Build-Review-Fix Data Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PLAN-BUILD-REVIEW-FIX DATA FLOW                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌────────────┐                                                             │
│  │  Feature   │                                                             │
│  │Description │                                                             │
│  └──────┬─────┘                                                             │
│         │                                                                    │
│         ▼                                                                    │
│  ┌────────────┐      ┌────────────────────────┐                             │
│  │   PLAN     │─────►│ specs/plans/           │                             │
│  │   Agent    │      │ [date]-[feature].md    │                             │
│  └────────────┘      └───────────┬────────────┘                             │
│                                  │                                          │
│                                  ▼                                          │
│  ┌────────────┐      ┌────────────────────────┐                             │
│  │   BUILD    │─────►│ app/[feature]/         │                             │
│  │   Agent    │      │ tests/[feature]/       │                             │
│  └────────────┘      └───────────┬────────────┘                             │
│                                  │                                          │
│                                  ▼                                          │
│  ┌────────────┐      ┌────────────────────────┐                             │
│  │  REVIEW    │─────►│ specs/reviews/         │                             │
│  │   Agent    │      │ [date]-review.md       │                             │
│  └────────────┘      │ (Score: X/10)          │                             │
│                      └───────────┬────────────┘                             │
│                                  │                                          │
│                        ┌─────────┴─────────┐                                │
│                        │                   │                                │
│                   Score ≥ 7           Score < 7                             │
│                        │                   │                                │
│                        ▼                   ▼                                │
│                 ┌────────────┐      ┌────────────┐                          │
│                 │  COMPLETE  │      │    FIX     │                          │
│                 └────────────┘      │   Agent    │                          │
│                                     └──────┬─────┘                          │
│                                            │                                │
│                                            ▼                                │
│                                     ┌────────────┐                          │
│                                     │ Fixed Code │                          │
│                                     └──────┬─────┘                          │
│                                            │                                │
│                                            └────────► Back to REVIEW        │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 10. File System Layout

### 10.1 Complete Directory Structure

```
codebase_singularity/
│
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
│
├── commands/                    # Workflow commands
│   ├── prime.md                 # Context activation
│   ├── plan.md                  # Planning workflow
│   ├── build.md                 # Build workflow
│   ├── review.md                # Review workflow
│   ├── fix.md                   # Fix workflow
│   ├── cycle.md                 # P-B-R-F cycle
│   ├── feature.md               # Feature development
│   ├── bugfix.md                # Bug investigation
│   ├── orchestrate.md           # Multi-agent coordination
│   ├── delegate.md              # Direct agent invocation
│   └── init.md                  # Initialize framework
│
├── agents/                      # Specialized agents
│   ├── 00-orchestrator.md       # Master coordinator
│   ├── 01-planner.md            # Planning agent
│   ├── 02-builder.md            # Build agent
│   ├── 03-reviewer.md           # Review agent
│   ├── 04-fixer.md              # Fix agent
│   ├── 05-test-writer.md        # Test creation
│   ├── 06-doc-fetcher.md        # Documentation
│   ├── 07-security-auditor.md   # Security analysis
│   └── 08-refactorer.md         # Refactoring
│
├── skills/                      # Skill modules
│   ├── git-workflow/
│   │   └── SKILL.md
│   ├── testing/
│   │   └── SKILL.md
│   ├── code-review/
│   │   └── SKILL.md
│   └── project-workflow/
│       └── SKILL.md
│
├── hooks/
│   └── hooks.json               # Hook configuration
│
├── scripts/                     # Hook scripts
│   ├── auto-lint.sh
│   ├── protect-files.sh
│   ├── log-subagent.sh
│   └── quality-gate.sh
│
├── templates/
│   └── settings.json            # Settings template
│
├── specs/                       # Plans and reviews
│   ├── plans/                   # Implementation plans
│   │   └── [date]-[feature].md
│   └── reviews/                 # Code reviews
│       └── [date]-review.md
│
├── ai_docs/                     # AI reference docs
│   └── [library]/
│       └── [topic].md
│
├── docs/                        # Human documentation
│   ├── USER_GUIDE.md
│   ├── DEVELOPER_GUIDE.md
│   ├── QUICKSTART.md
│   ├── ARCHITECTURE.md          # This file
│   ├── COMMANDS_REFERENCE.md
│   ├── AGENTS_REFERENCE.md
│   ├── HOOKS_GUIDE.md
│   └── CONFIGURATION_GUIDE.md
│
├── CLAUDE.md                    # Agent memory
├── .mcp.json                    # MCP configuration
└── README.md                    # Project readme
```

---

## 11. Design Decisions

### 11.1 Why YAML Frontmatter?

**Decision**: Use YAML frontmatter for agents and commands.

**Rationale**:
- Standard format recognized by many tools
- Separates metadata from content
- Easy to parse programmatically
- Human-readable

**Alternative Considered**: JSON configuration files
**Why Rejected**: Less readable, harder to maintain alongside markdown content.

### 11.2 Why Separate Agent Files?

**Decision**: One file per agent.

**Rationale**:
- Single responsibility principle
- Easy to modify individual agents
- Clear agent boundaries
- Version control friendly

**Alternative Considered**: Single agents.json file
**Why Rejected**: Harder to read and maintain large prompt content.

### 11.3 Why Model-Based Agent Assignment?

**Decision**: Assign specific models (opus/sonnet/haiku) to agents.

**Rationale**:
- Match model capability to task complexity
- Cost optimization (haiku for simple tasks)
- Speed optimization (sonnet for implementation)
- Quality assurance (opus for review)

```
opus   → Complex reasoning, coordination, review
sonnet → Code generation, implementation
haiku  → Documentation fetching, simple tasks
```

### 11.4 Why 7/10 Quality Threshold?

**Decision**: Quality gate passes at score ≥ 7/10.

**Rationale**:
- 7/10 represents "good quality" on standard scales
- Allows for minor improvements without blocking
- Prevents low-quality code from passing
- Industry standard threshold for acceptable work

### 11.5 Why Hooks Instead of Built-in Automation?

**Decision**: Use shell script hooks for automation.

**Rationale**:
- Flexibility (any shell command)
- No framework lock-in
- Easy to customize per project
- Transparent operation (scripts are readable)

**Alternative Considered**: Built-in automation rules
**Why Rejected**: Less flexible, harder to customize.

---

## 12. Extension Points

### 12.1 Adding New Agents

```
agents/
├── existing-agents...
└── XX-new-agent.md              # Add new agent here

Requirements:
1. YAML frontmatter with name, description, tools, model
2. Prompt content with role, responsibilities, process
3. Update CLAUDE.md to reference new agent
4. Update delegate command if needed
```

### 12.2 Adding New Commands

```
commands/
├── existing-commands...
└── new-command.md               # Add new command here

Requirements:
1. YAML frontmatter with name, description
2. Markdown content with instructions
3. Update CLAUDE.md to reference new command
```

### 12.3 Adding New Skills

```
skills/
├── existing-skills/
└── new-skill/
    └── SKILL.md                 # Add skill definition

Requirements:
1. YAML frontmatter with name, description, triggers
2. Commands section with usage examples
3. Troubleshooting section
4. Update CLAUDE.md to reference new skill
```

### 12.4 Adding New Hooks

```
scripts/
├── existing-scripts...
└── new-hook.sh                  # Add hook script

hooks/hooks.json:
{
  "hooks": [
    // existing hooks...
    {
      "event": "EventType",
      "tools": ["Tool1", "Tool2"],
      "script": "scripts/new-hook.sh",
      "description": "What this hook does"
    }
  ]
}

Requirements:
1. Shell script in scripts/
2. Entry in hooks.json
3. Proper exit codes (0=success, 1=block)
4. Make script executable (chmod +x)
```

### 12.5 Adding MCP Servers

```json
// .mcp.json
{
  "mcpServers": {
    "existing-servers": {...},
    "new-server": {
      "command": "npx",
      "args": ["-y", "@namespace/mcp-server-new"],
      "env": {
        "API_KEY": "${NEW_SERVER_API_KEY}"
      },
      "description": "Description of new server"
    }
  }
}

Requirements:
1. Valid MCP server package
2. Environment variables configured
3. Test server connectivity
```

---

## Conclusion

This architecture documentation provides a complete technical reference for the Codebase Singularity plugin. Key architectural features:

1. **Three-Layer Classification**: Class 1-3 with grades
2. **Two-Layer Design**: Agentic + Application layers
3. **Nine Specialized Agents**: Each with specific roles and models
4. **Quality Gates**: Automated quality assurance
5. **Hook System**: Flexible lifecycle automation
6. **Extensible Design**: Clear extension points

For implementation details, see `DEVELOPER_GUIDE.md`.
For usage instructions, see `USER_GUIDE.md`.

---

*Last updated: 2026-01-01*
*Version: 1.0.0 - Class 3, Grade 1+*
