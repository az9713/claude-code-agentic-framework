# Git Workflow Skill

## Purpose

Enable Claude to perform Git operations following the project's conventions and best practices.

## Prerequisites

- Git installed and available in PATH
- Repository initialized (`git init` completed)
- User name and email configured
- (Optional) SSH key set up for remote operations

## Commands

### Check Current Status

```bash
git status
```

**When to use**: Before any other Git operation to understand current state
**Expected output**: List of modified, staged, and untracked files

### Create Feature Branch

```bash
git checkout -b feature/[descriptive-name]
```

**When to use**: Starting work on a new feature
**Expected output**: `Switched to a new branch 'feature/[name]'`

**Naming conventions**:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring

### Stage Changes

```bash
# Stage specific files
git add path/to/file.js

# Stage all changes
git add .

# Stage interactively (review each change)
git add -p
```

**When to use**: After making changes you want to commit
**Expected output**: Silent (no output means success)

### Review Staged Changes

```bash
git diff --staged
```

**When to use**: Before committing to verify what will be committed
**Expected output**: Diff of all staged changes

### Commit Changes

```bash
git commit -m "[type]: [brief description]"
```

**When to use**: After staging changes
**Expected output**: Commit hash and summary

**Commit message format**:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation only
- `style:` - Formatting, no code change
- `refactor:` - Code change that neither fixes bug nor adds feature
- `test:` - Adding tests
- `chore:` - Maintenance

**Examples**:
```bash
git commit -m "feat: add email validation to signup form"
git commit -m "fix: prevent crash when user list is empty"
git commit -m "docs: update installation instructions"
```

### View Commit History

```bash
# Brief history
git log --oneline -10

# Detailed history
git log -5

# History with file changes
git log --stat -5
```

**When to use**: To review recent changes or find a specific commit
**Expected output**: List of commits with hashes and messages

### Push to Remote

```bash
# First push of a new branch
git push -u origin [branch-name]

# Subsequent pushes
git push
```

**When to use**: To share commits with the remote repository
**Expected output**: Upload progress and success message

### Pull Latest Changes

```bash
git pull origin [branch-name]
```

**When to use**: To get the latest changes from remote
**Expected output**: Update summary or "Already up to date"

### Switch Branches

```bash
# Switch to existing branch
git checkout [branch-name]

# Switch to main/master
git checkout main
```

**When to use**: To work on a different branch
**Expected output**: `Switched to branch '[name]'`

### Discard Changes

```bash
# Discard changes in specific file
git checkout -- path/to/file.js

# Discard all unstaged changes
git checkout -- .

# Unstage file (keep changes)
git reset HEAD path/to/file.js
```

**When to use**: To undo unwanted changes
**Expected output**: Silent success

## Verification

Verify Git is working:
```bash
git --version
git status
```

Verify remote is configured:
```bash
git remote -v
```

## Troubleshooting

### Error: "not a git repository"

**Cause**: Current directory is not a Git repository
**Solution**:
```bash
cd /path/to/your/project
# or initialize:
git init
```

### Error: "Permission denied (publickey)"

**Cause**: SSH key not set up or not added to remote
**Solution**:
1. Check if key exists: `ls ~/.ssh/id_rsa.pub`
2. Generate if needed: `ssh-keygen -t ed25519 -C "your@email.com"`
3. Add to GitHub/GitLab: Copy output of `cat ~/.ssh/id_rsa.pub`

### Error: "Updates were rejected"

**Cause**: Remote has changes you don't have
**Solution**:
```bash
git pull --rebase origin [branch-name]
# Resolve any conflicts if they appear
git push
```

### Error: "Your local changes would be overwritten"

**Cause**: You have uncommitted changes that conflict with incoming changes
**Solution**:
```bash
# Option 1: Commit your changes first
git add .
git commit -m "WIP: save current work"
git pull

# Option 2: Stash your changes
git stash
git pull
git stash pop
```

### Error: "Merge conflict"

**Cause**: Same lines modified in both local and remote
**Solution**:
1. Open conflicted files
2. Look for `<<<<<<< HEAD` markers
3. Choose which changes to keep
4. Remove the conflict markers
5. Stage and commit the resolution

## Workflow Example

Complete feature development flow:

```bash
# 1. Start on main branch
git checkout main

# 2. Get latest changes
git pull origin main

# 3. Create feature branch
git checkout -b feature/add-validation

# 4. Make changes, then stage
git add .

# 5. Commit with descriptive message
git commit -m "feat: add email validation to contact form"

# 6. Push to remote
git push -u origin feature/add-validation

# 7. Create PR on GitHub/GitLab (done in browser)
```

## Related Skills

- Deployment workflow
- Code review process
- Release management
