#!/usr/bin/env bash
# UserPromptSubmit hook: makes the ui-ux-design skill mandatory for visual work.
# Reads the hook payload on stdin and, when the prompt looks like a design or
# front-end request, prints a directive that Claude Code adds to the context.
set -uo pipefail

payload="$(cat)"
prompt="$(printf '%s' "$payload" | python3 -c 'import sys, json; print(json.load(sys.stdin).get("prompt", ""))' 2>/dev/null || true)"

# Match on design/front-end intent, case-insensitively.
if printf '%s' "$prompt" | grep -Eiq '(design|ui|ux|portfolio|website|web ?site|landing|webpage|web page|frontend|front-end|css|html|layout|typograph|font|mockup|prototype|wireframe|brand|visual|styling|theme|responsive|figma|vercel|deploy)'; then
  cat <<'DIRECTIVE'
<ui-ux-design-mandate>
This request involves visual or front-end work, so the repo's UI/UX design standards are MANDATORY.
Before writing any markup, CSS, or design decision, read .claude/skills/ui-ux-design/SKILL.md and
follow it. In particular:
  - State the design direction in one sentence before building.
  - Do not use the banned default styling (purple gradients, rounded white card grids, single-font
    16px everything, centered hero + two pill buttons).
  - Screenshot the result with headless Chromium at 1440px and 390px, view the images, and iterate
    until it holds up. Rendering it in your head is not verification.
  - Confirm webfonts actually loaded before trusting any screenshot.
Skipping this checklist is not acceptable, even for a quick prototype.
</ui-ux-design-mandate>
DIRECTIVE
fi
exit 0
