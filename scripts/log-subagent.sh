#!/bin/bash
#
# Log Subagent Hook Script
# Logs subagent activity for orchestration tracking
#
# Usage: ./log-subagent.sh <agent_name> <status>
#

AGENT_NAME="$1"
STATUS="$2"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Log directory
LOG_DIR="${PROJECT_ROOT:-.}/logs"
LOG_FILE="$LOG_DIR/subagent.log"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Create log entry
LOG_ENTRY=$(cat <<EOF
{
  "timestamp": "$TIMESTAMP",
  "agent": "$AGENT_NAME",
  "status": "$STATUS",
  "session": "${SESSION_ID:-unknown}"
}
EOF
)

# Append to log file
echo "$LOG_ENTRY" >> "$LOG_FILE"

# Also log to console for visibility
echo "[$TIMESTAMP] Agent: $AGENT_NAME - Status: $STATUS"

# Track agent statistics
STATS_FILE="$LOG_DIR/agent-stats.json"

if [ -f "$STATS_FILE" ]; then
    # Update existing stats (simplified - production would use jq properly)
    echo "Stats updated for $AGENT_NAME"
else
    # Create initial stats file
    cat > "$STATS_FILE" <<EOF
{
  "agents": {},
  "last_updated": "$TIMESTAMP"
}
EOF
fi

exit 0
