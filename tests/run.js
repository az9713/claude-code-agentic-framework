/**
 * Simple Test Runner
 *
 * Runs all test files in the tests directory and reports results.
 *
 * Usage:
 *   node tests/run.js           # Run all tests
 *   node tests/run.js --verbose # Run with detailed output
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const testsDir = __dirname;
const testFilePattern = /\.test\.js$/;
const verbose = process.argv.includes('--verbose');

// Colors for output (works in most terminals)
const colors = {
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  reset: '\x1b[0m',
  bold: '\x1b[1m'
};

function log(message, color = '') {
  console.log(`${color}${message}${colors.reset}`);
}

function findTestFiles(dir) {
  const files = [];

  try {
    const entries = fs.readdirSync(dir, { withFileTypes: true });

    for (const entry of entries) {
      const fullPath = path.join(dir, entry.name);

      if (entry.isDirectory() && entry.name !== 'node_modules') {
        files.push(...findTestFiles(fullPath));
      } else if (entry.isFile() && testFilePattern.test(entry.name)) {
        files.push(fullPath);
      }
    }
  } catch (error) {
    log(`Warning: Could not read directory ${dir}`, colors.yellow);
  }

  return files;
}

function runTest(testFile) {
  const relativePath = path.relative(testsDir, testFile);

  if (verbose) {
    log(`\nRunning: ${relativePath}`, colors.bold);
  }

  try {
    const output = execSync(`node "${testFile}"`, {
      encoding: 'utf-8',
      stdio: verbose ? 'inherit' : 'pipe'
    });

    return { file: relativePath, success: true, output };
  } catch (error) {
    return {
      file: relativePath,
      success: false,
      output: error.stdout || error.message
    };
  }
}

function main() {
  log('\n========================================', colors.bold);
  log('         Running Test Suite', colors.bold);
  log('========================================\n', colors.bold);

  const testFiles = findTestFiles(testsDir);

  if (testFiles.length === 0) {
    log('No test files found.', colors.yellow);
    log('Test files should be named *.test.js');
    log('\nCreate your first test in tests/unit/example.test.js');
    process.exit(0);
  }

  log(`Found ${testFiles.length} test file(s)\n`);

  const results = [];

  for (const testFile of testFiles) {
    results.push(runTest(testFile));
  }

  // Summary
  log('\n========================================', colors.bold);
  log('              Results', colors.bold);
  log('========================================\n', colors.bold);

  const passed = results.filter(r => r.success);
  const failed = results.filter(r => !r.success);

  for (const result of results) {
    const status = result.success ? '✓' : '✗';
    const color = result.success ? colors.green : colors.red;
    log(`${status} ${result.file}`, color);

    if (!result.success && result.output) {
      log(`  Error: ${result.output.split('\n')[0]}`, colors.red);
    }
  }

  log('\n----------------------------------------');
  log(`Total: ${results.length} | `, colors.bold);
  log(`Passed: ${passed.length}`, colors.green);
  log(`Failed: ${failed.length}`, failed.length > 0 ? colors.red : colors.green);
  log('----------------------------------------\n');

  process.exit(failed.length > 0 ? 1 : 0);
}

main();
