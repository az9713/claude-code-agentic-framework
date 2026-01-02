#!/bin/bash
#
# Quality Gate Hook Script
# Verifies quality before completing major operations
#
# Usage: ./quality-gate.sh
# Exit codes: 0 = passed, 1 = failed
#

echo "Running Quality Gate checks..."

PASSED=true
WARNINGS=()
ERRORS=()

# Check 1: Run tests if available
if [ -f "package.json" ] && grep -q '"test"' package.json; then
    echo "Running tests..."
    if npm test --silent 2>/dev/null; then
        echo "✓ Tests passed"
    else
        ERRORS+=("Tests failed")
        PASSED=false
    fi
elif [ -f "tests/run.js" ]; then
    echo "Running tests..."
    if node tests/run.js 2>/dev/null; then
        echo "✓ Tests passed"
    else
        ERRORS+=("Tests failed")
        PASSED=false
    fi
else
    WARNINGS+=("No test runner found")
fi

# Check 2: Lint check if available
if [ -f "package.json" ] && grep -q '"lint"' package.json; then
    echo "Running linter..."
    if npm run lint --silent 2>/dev/null; then
        echo "✓ Lint passed"
    else
        WARNINGS+=("Lint warnings present")
    fi
fi

# Check 3: Check for debug code
echo "Checking for debug code..."
DEBUG_COUNT=$(grep -r "console\.log\|debugger\|TODO\|FIXME\|XXX" --include="*.js" --include="*.ts" app/ 2>/dev/null | wc -l)
if [ "$DEBUG_COUNT" -gt 0 ]; then
    WARNINGS+=("Found $DEBUG_COUNT potential debug statements")
fi

# Check 4: Check for hardcoded secrets
echo "Checking for hardcoded secrets..."
SECRET_PATTERNS="password.*=.*['\"]|secret.*=.*['\"]|api.?key.*=.*['\"]|AKIA[0-9A-Z]{16}"
SECRET_COUNT=$(grep -rE "$SECRET_PATTERNS" --include="*.js" --include="*.ts" app/ 2>/dev/null | grep -v "\.test\." | wc -l)
if [ "$SECRET_COUNT" -gt 0 ]; then
    ERRORS+=("Found $SECRET_COUNT potential hardcoded secrets")
    PASSED=false
fi

# Check 5: Verify no .env files in commit
if git status --porcelain 2>/dev/null | grep -q "\.env"; then
    ERRORS+=("Uncommitted .env file detected")
    PASSED=false
fi

# Summary
echo ""
echo "=== Quality Gate Summary ==="

if [ ${#WARNINGS[@]} -gt 0 ]; then
    echo ""
    echo "Warnings:"
    for warn in "${WARNINGS[@]}"; do
        echo "  ⚠ $warn"
    done
fi

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo ""
    echo "Errors:"
    for err in "${ERRORS[@]}"; do
        echo "  ✗ $err"
    done
fi

echo ""
if [ "$PASSED" = true ]; then
    echo "✓ Quality Gate: PASSED"
    exit 0
else
    echo "✗ Quality Gate: FAILED"
    echo "Please fix the errors above before proceeding."
    exit 1
fi
