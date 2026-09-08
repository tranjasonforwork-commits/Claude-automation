#!/usr/bin/env bash
# UserPromptSubmit hook: makes the UI/UX design skills mandatory for visual work.
# Reads the hook payload on stdin and, when the prompt looks like a design or
# front-end request, prints a directive that Claude Code adds to the context.
set -uo pipefail

payload="$(cat)"
prompt="$(printf '%s' "$payload" | python3 -c 'import sys, json; print(json.load(sys.stdin).get("prompt", ""))' 2>/dev/null || true)"

# Match on design/front-end intent, case-insensitively.
if printf '%s' "$prompt" | grep -Eiq '(design|ui|ux|portfolio|website|web ?site|landing|webpage|web page|frontend|front-end|css|html|layout|typograph|font|mockup|prototype|wireframe|brand|visual|styling|theme|responsive|figma|vercel|deploy)'; then
  cat <<'DIRECTIVE'
<ui-ux-design-mandate>
This request involves visual or front-end work. The repo's design skills are MANDATORY here.

1. Query the design database BEFORE choosing any visual direction:
     python3 .claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --domain <style|color|typography|ux>
     python3 .claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system
   Read .claude/skills/ui-ux-pro-max/SKILL.md for the full query contract.
2. Read .claude/skills/ui-ux-design/SKILL.md for this repo's house rules and verification loop.
3. State the design direction in one sentence before writing any markup.
4. Do not ship the AI-template look (purple gradients, rounded white card grids, one font at 16px,
   centered hero + two pill buttons).
5. Screenshot the result at 1440px and 390px, VIEW the images with the Read tool, and iterate.
   Confirm webfonts actually loaded first - this container's browser cannot reach Google Fonts,
   so screenshots silently show fallback type.

Skipping this is not acceptable, even for a quick prototype.
</ui-ux-design-mandate>
DIRECTIVE
fi
exit 0
