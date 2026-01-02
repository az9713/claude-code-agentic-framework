# Application Layer

This folder contains the actual application code - the business logic, utilities, and features.

## Purpose

- Store all application source code
- Organize code by feature/domain
- Separate from agentic layer configuration

## Recommended Structure

```
app/
├── README.md           # This file
├── index.js            # Main entry point (if applicable)
├── config/             # Configuration files
│   └── settings.js
├── utils/              # Utility functions
│   ├── validators.js
│   └── formatters.js
├── models/             # Data models
│   └── user.js
├── services/           # Business logic
│   └── auth.js
└── features/           # Feature modules
    ├── users/
    └── products/
```

## Coding Standards

### File Naming
- Use `kebab-case` for files: `user-service.js`
- Or `camelCase`: `userService.js`
- Be consistent throughout

### Function Naming
- Use `camelCase`: `calculateTotal`
- Use descriptive names: `getUserById` not `getUser`

### Documentation
- Add JSDoc comments for public functions
- Include examples where helpful

### Error Handling
- Always handle potential errors
- Provide meaningful error messages
- Never silently fail

## Example File Structure

```javascript
// app/utils/validators.js

/**
 * Validates an email address format
 * @param {string} email - The email to validate
 * @returns {boolean} True if valid, false otherwise
 * @example
 * isValidEmail('user@example.com') // true
 * isValidEmail('invalid-email') // false
 */
function isValidEmail(email) {
  // Implementation
}

module.exports = { isValidEmail };
```

## Getting Started

1. Create your first utility: `app/utils/helpers.js`
2. Add your first feature: `app/features/`
3. Write tests: `tests/`
