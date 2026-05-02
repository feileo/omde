#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
TOTAL_IN=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
TOTAL_OUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')
CWD=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')

R=$'\033[0m'; DIM=$'\033[2m'; GRAY=$'\033[90m'
GREEN=$'\033[92m'; RED=$'\033[31m'

SEP="${GRAY}|${R}"
BC="$GRAY"

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v F "%${FILLED}s"; printf -v P "%${EMPTY}s"
BAR="${BC}${F// /█}${DIM}${P// /░}${R}"

TOKENS=$(( (TOTAL_IN + TOTAL_OUT) / 1000 ))
COST_FMT=$(printf '%.3f' "$COST")
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

# git
GIT_PART=""
if [ -n "$CWD" ] && git -C "$CWD" rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=$(git -C "$CWD" symbolic-ref --short HEAD 2>/dev/null || git -C "$CWD" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$(git -C "$CWD" status --porcelain 2>/dev/null)" ]; then
    STAT=$(git -C "$CWD" diff --shortstat HEAD 2>/dev/null)
    ADD=$(echo "$STAT" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+'); ADD=${ADD:-0}
    DEL=$(echo "$STAT" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+'); DEL=${DEL:-0}
    GIT_PART=" $SEP ${GRAY}${BRANCH}*${R} ${GREEN}+${ADD}${R}${DIM}/${R}${RED}-${DEL}${R}"
  else
    GIT_PART=" $SEP ${GRAY}${BRANCH}${R}"
  fi
fi

printf "${GRAY}[${MODEL}]${R}"
[ -n "$EFFORT" ] && printf " $SEP ${GRAY}${EFFORT}${R}"
printf " $SEP [${BAR}] ${BC}${PCT}%%${R} ${DIM}(${TOKENS}k)${R}"
printf " $SEP ${GRAY}\$${COST_FMT}${R} $SEP ${GRAY}${MINS}m${SECS}s${R}"
printf "%s\n" "$GIT_PART"

