#!/bin/bash
#
# Protect Files Hook Script
# Prevents editing of protected files
#
# Usage: ./protect-files.sh <file_path>
# Exit codes: 0 = allowed, 1 = blocked
#

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# Get filename
FILENAME=$(basename "$FILE_PATH")

# Protected file patterns
PROTECTED_FILES=(
    ".env"
    ".env.local"
    ".env.production"
    ".env.development"
    "package-lock.json"
    "yarn.lock"
    "pnpm-lock.yaml"
    "Gemfile.lock"
    "Cargo.lock"
    "poetry.lock"
    "composer.lock"
    ".git/config"
    ".git/HEAD"
    "id_rsa"
    "id_ed25519"
    "*.pem"
    "*.key"
    "credentials.json"
    "secrets.json"
    "service-account.json"
)

# Protected directories
PROTECTED_DIRS=(
    ".git/"
    "node_modules/"
    ".next/"
    "dist/"
    "build/"
    "__pycache__/"
    ".venv/"
    "venv/"
)

# Check filename against protected files
for pattern in "${PROTECTED_FILES[@]}"; do
    if [[ "$FILENAME" == $pattern ]]; then
        echo "BLOCKED: Cannot edit protected file: $FILENAME"
        echo "This file is protected to prevent accidental modifications."
        exit 1
    fi
done

# Check path against protected directories
for dir in "${PROTECTED_DIRS[@]}"; do
    if [[ "$FILE_PATH" == *"$dir"* ]]; then
        echo "BLOCKED: Cannot edit files in protected directory: $dir"
        echo "This directory is protected to prevent accidental modifications."
        exit 1
    fi
done

# Check for sensitive content patterns in existing file
if [ -f "$FILE_PATH" ]; then
    # Check for private key markers
    if grep -q "-----BEGIN.*PRIVATE KEY-----" "$FILE_PATH" 2>/dev/null; then
        echo "BLOCKED: Cannot edit file containing private keys: $FILE_PATH"
        exit 1
    fi

    # Check for AWS credentials
    if grep -qE "AKIA[0-9A-Z]{16}" "$FILE_PATH" 2>/dev/null; then
        echo "WARNING: File may contain AWS credentials: $FILE_PATH"
        echo "Proceeding with caution..."
    fi
fi

# File is not protected
exit 0
