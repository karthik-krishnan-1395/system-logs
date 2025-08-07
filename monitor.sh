#!/bin/bash

# Set working directory
cd "$(dirname "$0")"

# Timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Log files
HISTORY_FILE="history_$timestamp.log"
USAGE_FILE="usage_$timestamp.log"

# 1. Save command history
history > "$HISTORY_FILE"

# 2. Save CPU & RAM info
echo "=== TOP Snapshot ===" > "$USAGE_FILE"
top -b -n1 | head -20 >> "$USAGE_FILE"
echo "" >> "$USAGE_FILE"
echo "=== FREE Memory ===" >> "$USAGE_FILE"
free -h >> "$USAGE_FILE"
echo "" >> "$USAGE_FILE"
echo "=== VMSTAT ===" >> "$USAGE_FILE"
vmstat >> "$USAGE_FILE"

# 3. Git add, commit, push
git add .
git commit -m "Log update: $timestamp"
git push origin main

