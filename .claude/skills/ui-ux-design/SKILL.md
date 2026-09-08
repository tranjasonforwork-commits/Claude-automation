---
name: ui-ux-design
description: >
  House rules for visual and front-end work in this repo. Wraps the vendored ui-ux-pro-max
  design intelligence with this environment's verification requirements: mandatory rendered
  screenshot review, webfont load checks, and honesty rules for placeholder prototypes.
  Triggers on: design, UI, UX, portfolio, website, landing page, frontend, CSS, HTML, layout,
  typography, prototype, mockup, visual, brand, responsive, deploy
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, WebSearch
---

# UI/UX House Rules

Design intelligence lives in the vendored **`ui-ux-pro-max`** skill. This file is the thin layer
on top: which source to consult, and how to prove the result actually works before showing it.

## 1. Query the design database first

Do not invent a visual direction from scratch. Search the local database:

```bash
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "<2-5 term query>" --domain <style|color|typography|ux|chart|icons|gsap|product>
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system   # new page or system-wide direction
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --stack <stack>   # implementation details
```

The upstream skill documents this as `${CLAUDE_PLUGIN_ROOT}/.claude/skills/...`. These skills are
vendored into this repo rather than installed as a plugin, so that variable is not set - use the
repo-relative path above.

Read `.claude/skills/ui-ux-pro-max/SKILL.md` for the full query contract, and its
`references/quick-reference.md` for all 119 UX rules on demand.

## 2. State the direction before building

One sentence, naming the style the search returned, the mood, and the single move that makes this
page specific to its subject. If the output could be dropped into an unrelated project without
anyone noticing, it has failed.

## 3. Never ship the AI-template look

Not without the user asking for it by name: purple/indigo gradients and the stock Tailwind palette;
rounded white cards with soft shadows in a three-column grid; emoji standing in for icons; one
sans at 16px for everything with no display face; centered hero with two pill buttons. A page that
scrolls at one volume - same padding, same type scale, same ground for every band - reads as a
template. Invert ink and ground, change the grid, change the scale.

## 4. Verification - do not skip

Rendering it in your head is not verification. Before presenting any visual work:

1. **Screenshot it and look at the images with the Read tool**, at 1440px and 390px wide. Use
   headless Chromium at `/opt/pw-browsers/chromium-1194/chrome-linux/chrome` via `playwright-core`.
2. **Confirm webfonts actually loaded** - `document.fonts.check('400 100px <Family>')`. This
   container's browser cannot reach `fonts.googleapis.com` (ERR_CONNECTION_RESET), so a local
   screenshot silently renders fallback type and you will review a design you are not seeing.
   Fetch the woff2 through `curl` (which uses the proxy) with the Google CSS API's `text=`
   parameter to subset it, then base64-inline it into a local render copy.
3. **Measure, do not eyeball.** Check `scrollWidth - clientWidth` for overflow at every breakpoint.
   Measure display type against its container instead of guessing a `vw` value.
4. **Capture interactive states** - hover, active, empty - not just the resting page.
5. Fix what the screenshots reveal, re-render, repeat until it holds up.

## 5. Honesty in placeholder work

A prototype for a real person must never fabricate credentials that could pass as real. Keep every
unverified fact in `[BRACKETS]`, label sample metrics as samples, mark the page `noindex`, and
carry a visible prototype notice until real content lands.

## Provenance

`banner-design`, `brand`, `design`, `design-system`, `slides`, `ui-styling`, and `ui-ux-pro-max`
are vendored from [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)
at commit `4aad0584d92131626b16d4ff4d77f0455385013c` (v2.13.0), MIT licensed - see
`.claude/skills/UPSTREAM-LICENSE`. They were copied rather than forked because this session cannot
create or fork repositories outside `tranjasonforwork-commits/claude-automation`. To update, re-clone
upstream and replace those seven directories.
