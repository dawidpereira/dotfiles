#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

git_branch=""
if [ -n "$cwd" ]; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# Catppuccin Mocha
C_GREEN='\033[38;2;166;227;161m'
C_PINK='\033[38;2;245;194;231m'
C_BLUE='\033[38;2;137;180;250m'
C_RED='\033[38;2;243;139;168m'
C_PEACH='\033[38;2;250;179;135m'
C_SUBTEXT='\033[38;2;166;173;200m'
C_OVERLAY='\033[38;2;127;132;156m'
RESET='\033[0m'

build_bar() {
  local pct=$1 width=$2 fill_color=$3
  local filled=0 empty bar=""

  if [ "$pct" -gt 0 ] 2>/dev/null; then
    filled=$(( pct * width / 100 ))
    [ "$filled" -eq 0 ] && filled=1
  fi
  empty=$(( width - filled ))

  if [ "$filled" -gt 0 ]; then
    bar="${fill_color}"
    for (( i=0; i<filled; i++ )); do bar="${bar}█"; done
  fi
  if [ "$empty" -gt 0 ]; then
    bar="${bar}${C_OVERLAY}"
    for (( i=0; i<empty; i++ )); do bar="${bar}░"; done
  fi
  printf '%s%b' "$bar" "$RESET"
}

sep() { printf ' %b·%b ' "$C_SUBTEXT" "$RESET"; }

out=""

if [ -n "$git_branch" ]; then
  out="${out}$(printf '%b %s%b' "$C_PINK" "$git_branch" "$RESET")"
fi

out="${out}$(sep)"

if [ -n "$used_pct" ]; then
  used_int=${used_pct%.*}
  if [ "$used_int" -ge 80 ] 2>/dev/null; then
    fc="$C_RED"
  elif [ "$used_int" -ge 50 ] 2>/dev/null; then
    fc="$C_PEACH"
  else
    fc="$C_GREEN"
  fi
  out="${out}$(printf '🧠 %b %b%d%%%b' "$(build_bar "$used_int" 15 "$fc")" "$fc" "$used_int" "$RESET")"
fi

out="${out}$(sep)"

if [ -n "$model" ]; then
  out="${out}$(printf '%b🤖 %s%b' "$C_BLUE" "$model" "$RESET")"
fi

printf '%b' "$out"
