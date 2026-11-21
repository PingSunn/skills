# skills

Agent skills I wrote, installable with the [`skills`](https://github.com/vercel-labs/skills) CLI.

```sh
npx skills add PingSunn/skills -g -a claude-code
```

## Skills in this repo

| Skill | What it does |
| --- | --- |
| [ps-factory](skills/ps-factory/SKILL.md) | Runs coding work as an agent team on Orca or Herdr: one Orchestrator per project, a Lead per Story, a Dev per Slice and a QA, with Story Branches and small Slice pull requests. |

### ps-factory in 30 seconds

[▶ Watch the clip (MP4, 30 s)](docs/media/ps-factory.mp4)

The clip is rendered frame by frame from [docs/media-src/ps-factory-clip.html](docs/media-src/ps-factory-clip.html) with [docs/media-src/render.cjs](docs/media-src/render.cjs) (`node render.cjs <html> <out.mp4> 60`, needs Playwright and ffmpeg).

Quick start: install the repo, open a Claude Code chat in your project's main checkout, run `/ps-factory init` once, then `/ps-factory` and describe the work.

## Updating

Edit in this clone, push, then on each machine:

```sh
npx skills update -g
```

## Other skills I use

Not published here; install them from their authors.

| Skill | Source |
| --- | --- |
| ask-matt, code-review, diagnosing-bugs, domain-modeling, grill-me, grill-with-docs, grilling, handoff, implement, improve-codebase-architecture, resolving-merge-conflicts, retro, tdd, to-questionnaire, to-spec, to-tickets, triage, wayfinder, writing-for-agents | [mattpocock/skills](https://github.com/mattpocock/skills) |
| scrutinize | [thananon/9arm-skills](https://github.com/thananon/9arm-skills) |
| stack-diagram | [caru-ini/stack-diagram](https://github.com/caru-ini/stack-diagram) |
| modern-web-guidance | [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) |
| defuddle, json-canvas, obsidian-bases, obsidian-cli, obsidian-markdown | [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) |
| find-skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| shadcn | [shadcn/ui](https://github.com/shadcn-ui/ui) |
| impeccable | Impeccable |
| diagram-design | diagram-design |
| reverse-engineer-anything | [morluto/rea](https://github.com/morluto/rea) |
| ui-ux-pro-max | ui-ux-pro-max |
| caveman | caveman (Claude Code plugin) |
| orca-cli | bundled with Orca |
| teach | source not recorded |
| herdr | bundled with Herdr |
