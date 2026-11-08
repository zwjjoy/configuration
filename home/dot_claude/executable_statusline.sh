#!/bin/bash
# Claude Code statusline. Reads session JSON on stdin, prints one line.
input=$(cat)

# Segments to show. Delete a word to hide it, or override per-shell:
#   export CC_STATUSLINE="git ctx"
SHOW="${CC_STATUSLINE-git ctx cost diff}"

IFS=$'\t' read -r model dir transcript cost add del < <(
  jq -r '[
    (.model.display_name // "?"),
    (.workspace.current_dir // .cwd // ""),
    (.transcript_path // ""),
    (.cost.total_cost_usd // 0),
    (.cost.total_lines_added // 0),
    (.cost.total_lines_removed // 0)
  ] | @tsv' <<<"$input"
)

# colorblind-safe palette (no red/green pairing)
B=$'\033[38;5;39m'   # blue
O=$'\033[38;5;208m'  # orange
Y=$'\033[38;5;221m'  # yellow
C=$'\033[38;5;80m'   # cyan
G=$'\033[38;5;245m'  # grey
R=$'\033[0m'

short_dir=${dir/#$HOME/\~}

if [[ $SHOW == *git* ]]; then
  branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null \
        || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
fi
if [[ -n $branch ]]; then
  git -C "$dir" diff --quiet --ignore-submodules HEAD 2>/dev/null || branch+="*"
  git_part=" ${G}|${R} ${Y}⎇ ${branch}${R}"
fi

# context used = token count on the most recent main-thread assistant message
if [[ $SHOW == *ctx* && -s $transcript ]]; then
  used=$(tail -r "$transcript" 2>/dev/null | jq -rn 'first(
    inputs
    | select(.isSidechain != true and .message.usage.input_tokens != null)
    | .message.usage
    | (.input_tokens + (.cache_read_input_tokens // 0) + (.cache_creation_input_tokens // 0))
  )' 2>/dev/null)
fi
if [[ $used =~ ^[0-9]+$ ]]; then
  limit=200000; ((used > limit)) && limit=1000000
  pct=$((used * 100 / limit))
  bar=$C; ((pct >= 60)) && bar=$Y; ((pct >= 80)) && bar=$O
  ctx_part=" ${G}|${R} ${bar}ctx ${pct}%${R}"
fi

cost_part=""
[[ $SHOW == *cost* ]] &&
  (( $(printf '%.0f' "$(bc -l <<<"$cost * 1000")" 2>/dev/null || echo 0) > 0 )) &&
  cost_part=$(printf " ${G}|${R} ${G}\$%.2f${R}" "$cost")

diff_part=""
[[ $SHOW == *diff* ]] && ((add + del > 0)) &&
  diff_part=" ${G}|${R} ${G}+${add}/-${del}${R}"

printf "${B}%s${R} ${G}|${R} ${C}%s${R}%s%s%s%s\n" \
  "$model" "$short_dir" "$git_part" "$ctx_part" "$cost_part" "$diff_part"
