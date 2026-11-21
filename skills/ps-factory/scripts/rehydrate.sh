#!/usr/bin/env bash
set -u

input=$(cat)
source=$(jq -r '.source // ""' <<<"$input")
cwd=$(jq -r '.cwd // ""' <<<"$input")

case "$source" in
  compact|clear|resume) ;;
  *) exit 0 ;;
esac

[ -n "$cwd" ] || cwd=$PWD
top=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -f "$top/.ps-factory/policy.md" ] || exit 0

common=$(git -C "$cwd" rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || exit 0
gitdir=$(git -C "$cwd" rev-parse --path-format=absolute --git-dir 2>/dev/null) || exit 0
project=$(basename "$(dirname "$common")")
state="$HOME/.ps-factory/$project"

if [ "$common" = "$gitdir" ]; then
  [ -f "$state/ledger.md" ] || exit 0
  ctx="ps-factory: this is the main checkout of '$project'. If this session is the ps-factory Orchestrator, your memory was just reset ($source). Re-read the ps-factory skill and your Orchestrator role file, then continue from 'On start' using the state below. Otherwise ignore this note.

## Story Ledger ($state/ledger.md)
$(cat "$state/ledger.md")"
  if [ -f "$state/decisions.md" ]; then
    ctx="$ctx

## Last 20 decisions ($state/decisions.md)
$(grep -E '^- ' "$state/decisions.md" | tail -n 20)"
  fi
else
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  case "$branch" in
    feat/*) story=${branch#feat/} ;;
    *) exit 0 ;;
  esac
  notes="$state/stories/$story.md"
  [ -f "$notes" ] || exit 0
  ctx="ps-factory: this is the Story worktree of '$story'. If this session is its ps-factory Lead, your memory was just reset ($source). Re-read the ps-factory skill and your Lead role file, then continue from 'Resume' using the Story Notes below. Otherwise ignore this note.

## Story Notes ($notes)
$(cat "$notes")"
fi

jq -n --arg c "$ctx" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $c}}'
