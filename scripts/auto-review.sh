#!/bin/bash
#
# Auto-Review Hook Script
# Implements Class 1, Grade 4 Feedback Loop
# Automatically triggers reviewer agent after builder/fixer complete
#
# Usage: ./auto-review.sh <agent_name> <status>
#

AGENT_NAME="$1"
STATUS="$2"
PROJECT_ROOT="${PROJECT_ROOT:-.}"
LOG_DIR="$PROJECT_ROOT/logs"
REVIEW_FLAG="$LOG_DIR/.review_pending"

# Create log directory if needed
mkdir -p "$LOG_DIR"

# Only proceed if agent completed successfully
if [ "$STATUS" != "success" ]; then
    echo "[auto-review] Agent $AGENT_NAME failed, skipping review trigger"
    exit 0
fi

# Agents that should trigger automatic review
REVIEW_TRIGGER_AGENTS=("builder" "fixer" "refactorer")

# Check if this agent should trigger a review
should_trigger=false
for agent in "${REVIEW_TRIGGER_AGENTS[@]}"; do
    if [ "$AGENT_NAME" == "$agent" ]; then
        should_trigger=true
        break
    fi
done

if [ "$should_trigger" = false ]; then
    echo "[auto-review] Agent $AGENT_NAME does not trigger review"
    exit 0
fi

# Prevent infinite loops - check if we're already in a review cycle
if [ -f "$REVIEW_FLAG" ]; then
    REVIEW_COUNT=$(cat "$REVIEW_FLAG")
    if [ "$REVIEW_COUNT" -ge 3 ]; then
        echo "[auto-review] Max review iterations (3) reached, stopping loop"
        rm -f "$REVIEW_FLAG"
        exit 0
    fi
    NEW_COUNT=$((REVIEW_COUNT + 1))
    echo "$NEW_COUNT" > "$REVIEW_FLAG"
    echo "[auto-review] Review iteration $NEW_COUNT of 3"
else
    echo "1" > "$REVIEW_FLAG"
    echo "[auto-review] Starting review cycle (iteration 1 of 3)"
fi

# Log the trigger
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "{\"timestamp\": \"$TIMESTAMP\", \"trigger\": \"$AGENT_NAME\", \"action\": \"review\"}" >> "$LOG_DIR/feedback-loop.log"

# Trigger the review
# Note: This outputs a message that Claude Code will see
echo ""
echo "=============================================="
echo "  FEEDBACK LOOP TRIGGERED"
echo "=============================================="
echo ""
echo "  Agent '$AGENT_NAME' completed successfully."
echo "  Per Class 1, Grade 4 feedback loop:"
echo ""
echo "  → Automatic review recommended"
echo "  → Run: /project:review"
echo ""
echo "  To complete the cycle, also run:"
echo "  → /project:fix (if issues found)"
echo ""
echo "=============================================="
echo ""

# For headless/automated mode, we could invoke claude directly:
# claude --print "/project:review" 2>/dev/null || true

# Clean up review flag if this was triggered by reviewer/fixer completing
# (indicates cycle is complete)
if [ "$AGENT_NAME" == "reviewer" ]; then
    rm -f "$REVIEW_FLAG"
    echo "[auto-review] Review complete, feedback loop closed"
fi

exit 0
