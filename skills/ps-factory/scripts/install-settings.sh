#!/usr/bin/env bash
set -euo pipefail

settings="${1:-$HOME/.claude/settings.json}"
hook_cmd="bash $HOME/.claude/skills/ps-factory/scripts/rehydrate.sh"

[ -f "$settings" ] || printf '{}\n' > "$settings"
cp "$settings" "$settings.bak-ps-factory"

tmp=$(mktemp)
jq --arg cmd "$hook_cmd" '
  .hooks //= {} |
  .hooks.SessionStart //= [] |
  (if any(.hooks.SessionStart[]?.hooks[]?; .command == $cmd) then .
   else .hooks.SessionStart += [{
     matcher: "^(compact|clear|resume)$",
     hooks: [{type: "command", command: $cmd, timeout: 10, statusMessage: "Restoring ps-factory state"}]
   }] end)
' "$settings" > "$tmp"
mv "$tmp" "$settings"

echo "ps-factory settings applied to $settings (backup: $settings.bak-ps-factory)"
echo "- SessionStart hook: $hook_cmd"
