---
name: ui-ux-design
description: >
  Mandatory design standards for any visual or front-end output - websites, portfolios, landing
  pages, dashboards, HTML/CSS, components, mockups. Bans generic AI-template styling and requires
  a stated design direction, real typographic hierarchy, and rendered visual verification before
  anything is presented. Triggers on: design, UI, UX, portfolio, website, landing page, frontend,
  CSS, HTML, layout, typography, prototype, mockup, visual, brand, responsive, deploy
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, WebSearch
---

# UI/UX Design Standards

> **Provenance.** This is a local stand-in written for this repo. The intended source is
> `nextlevelbuilder/ui-ux-pro-max-skill`, which this session could not reach: GitHub access is
> scoped to `tranjasonforwork-commits/*` and `add_repo` refuses cross-owner adds. When that repo
> is available, replace the body of this file with its content and keep the frontmatter and the
> hook wiring intact.

## Rule 0 - never ship the default

The failure mode is a page that looks like every other AI-generated page. If the output could be
swapped into an unrelated project without anyone noticing, it has failed. Before writing markup,
state the design direction in one sentence: the reference point, the mood, and the one move that
makes it specific. Then build to that sentence.

## Banned by default

Do not use these unless the user asks for them by name:

- Purple/indigo-to-blue gradients, `#6366F1`, and the Tailwind-default palette as a whole
- Rounded-corner white cards with a soft drop shadow, laid out in a three-column grid
- An emoji or a generic outline icon standing in for real visual content
- Inter/Roboto/Open Sans at 16px for everything, with no display face and no contrast
- Centered hero, one-line subtitle, two pill buttons side by side
- "Lorem ipsum" or filler that pretends to be content - use bracketed `[PLACEHOLDERS]` instead
- Section padding and font sizes that never vary, so every band reads at the same volume

## Required

**Typographic hierarchy.** At least two families with a real job each: a display face for headlines
and a text face for reading. The step between the largest and smallest type on the page should be
at least 6x. Use fluid `clamp()` sizing, not fixed pixel breakpoint jumps.

**A committed palette.** Three to five values, defined as CSS custom properties, one of them an
accent used sparingly enough to still mean something. Never use pure `#000` on pure `#FFF`.

**Rhythm.** Sections must differ from each other - invert ink and ground, change the grid, change
the type scale. A page that scrolls at one volume reads as a template.

**Real content shape.** Structure follows what the content has to prove, not a generic section list.
Ask what the reader must believe by the end and order the page around that.

**Responsive by construction.** Fluid units and grid/flex, never fixed widths. Zero horizontal
overflow at 320px. Verify, don't assume.

**Motion with restraint.** One idea, executed well, beats five. Always honour
`prefers-reduced-motion`. Never animate anything that delays reading.

**Accessibility.** Body text at 4.5:1 contrast minimum, real focus states, semantic landmarks,
alt text, and a tap target of at least 44px. Decorative overlays get `pointer-events:none`.

## Verification - do not skip

Rendering it in your head is not verification. Before presenting any visual work:

1. Screenshot it with headless Chromium (`/opt/pw-browsers/chromium-1194/chrome-linux/chrome`
   via `playwright-core`) at 1440px and 390px wide, and **look at the images with the Read tool**.
2. Confirm webfonts actually loaded (`document.fonts.check('400 100px <Family>')`). This
   container cannot reach `fonts.googleapis.com` from the browser, so a local screenshot silently
   shows fallback type. Fetch the woff2 through `curl` (which uses the proxy) and inline it as
   base64 in a local render copy when accurate screenshots matter.
3. Measure, don't eyeball: check `scrollWidth - clientWidth` for overflow, and measure display
   type against its container rather than guessing a `vw` value.
4. Capture interactive states too - hover, active, empty - not just the resting page.
5. Fix what the screenshots reveal, then re-render. Iterate until it holds up.

## Honesty in placeholder work

Prototypes for a real person must never fabricate credentials that could be mistaken for real
ones. Keep every unverified fact in `[BRACKETS]`, label sample metrics as samples, mark the page
`noindex`, and carry a visible prototype notice until real content lands.
