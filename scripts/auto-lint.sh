#!/bin/bash
#
# Auto-Lint Hook Script
# Automatically formats files after editing
#
# Usage: ./auto-lint.sh <file_path>
#

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
    echo "No file path provided"
    exit 0
fi

# Skip if file doesn't exist (was deleted)
if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

# Get file extension
EXT="${FILE_PATH##*.}"

# Apply appropriate formatter based on file type
case "$EXT" in
    js|jsx|ts|tsx|mjs|cjs)
        # JavaScript/TypeScript - use Prettier if available
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (prettier)"
        elif command -v npx &> /dev/null; then
            npx prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (npx prettier)"
        fi
        ;;
    json)
        # JSON - use Prettier or jq
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (prettier)"
        elif command -v jq &> /dev/null; then
            tmp=$(mktemp)
            jq '.' "$FILE_PATH" > "$tmp" && mv "$tmp" "$FILE_PATH"
            echo "Formatted: $FILE_PATH (jq)"
        fi
        ;;
    py)
        # Python - use Black if available
        if command -v black &> /dev/null; then
            black --quiet "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (black)"
        elif command -v autopep8 &> /dev/null; then
            autopep8 --in-place "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (autopep8)"
        fi
        ;;
    md)
        # Markdown - use Prettier if available
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (prettier)"
        fi
        ;;
    css|scss|less)
        # CSS/SCSS - use Prettier if available
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (prettier)"
        fi
        ;;
    html|htm)
        # HTML - use Prettier if available
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (prettier)"
        fi
        ;;
    yaml|yml)
        # YAML - use Prettier if available
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null
            echo "Formatted: $FILE_PATH (prettier)"
        fi
        ;;
    *)
        # Unknown extension - skip
        exit 0
        ;;
esac

exit 0
