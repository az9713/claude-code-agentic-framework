# Tests Directory

This folder contains all test files for the application.

## Purpose

- Store unit tests
- Store integration tests
- Provide test utilities
- Document expected behavior

## Structure

```
tests/
├── README.md           # This file
├── run.js              # Simple test runner
├── unit/               # Unit tests
│   ├── validators.test.js
│   └── formatters.test.js
├── integration/        # Integration tests
│   └── api.test.js
└── fixtures/           # Test data
    └── sample-data.json
```

## File Naming Convention

- Test files: `[module-name].test.js`
- Test fixtures: `[description].json` or `[description].fixture.js`
- Test utilities: `[name].helper.js`

## Writing Tests

### Basic Test Structure

```javascript
// tests/unit/validators.test.js

const { isValidEmail } = require('../../app/utils/validators');

// Test Suite
console.log('Testing: isValidEmail');

// Test Case 1: Valid email
const result1 = isValidEmail('user@example.com');
console.assert(result1 === true, 'Should accept valid email');

// Test Case 2: Invalid email
const result2 = isValidEmail('invalid-email');
console.assert(result2 === false, 'Should reject invalid email');

// Test Case 3: Edge case - empty string
const result3 = isValidEmail('');
console.assert(result3 === false, 'Should reject empty string');

console.log('All tests passed!');
```

### Test Categories

| Category | What to Test | Location |
|----------|-------------|----------|
| Unit | Individual functions | `tests/unit/` |
| Integration | Multiple components | `tests/integration/` |
| Edge Cases | Boundary conditions | Within each test file |

## Running Tests

### Run All Tests
```bash
node tests/run.js
```

### Run Specific Test
```bash
node tests/unit/validators.test.js
```

## Best Practices

1. **Test one thing per test case**
2. **Use descriptive names** for test functions
3. **Cover edge cases**: null, undefined, empty, max values
4. **Keep tests independent**: don't rely on order
5. **Use fixtures** for complex test data

## Test Coverage Goals

- All utility functions: 100% coverage
- All public APIs: 90%+ coverage
- Edge cases: Documented and tested
- Error paths: All error conditions tested
