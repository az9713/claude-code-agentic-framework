# AI Documentation Cache

This folder stores documentation fetched by AI agents for reference during development.

## Purpose

- Cache external documentation locally
- Reduce repeated API calls
- Provide consistent context for agents
- Store library/framework references

## Structure

```
ai_docs/
├── README.md           # This file
├── [library-name]/     # One folder per library/framework
│   ├── index.md        # Overview and quick reference
│   ├── [topic].md      # Specific topic documentation
│   └── examples.md     # Code examples
└── [language-name]/    # Language-specific docs
    └── [topic].md
```

## How to Add Documentation

Ask Claude to fetch documentation:

```
> Fetch the official documentation for [library/framework]
> and save the key sections to ai_docs/
```

Or manually:
1. Create a folder for the library
2. Add markdown files with relevant content
3. Keep files under 50KB each
4. Include a source link at the top

## Maintenance

- Update docs when libraries are upgraded
- Remove docs for unused libraries
- Keep only essential sections, not entire docs

## Example Entry

```markdown
# Express.js Quick Reference

Source: https://expressjs.com/

## Basic Usage

const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000);
```
