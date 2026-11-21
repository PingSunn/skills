# skills

Agent skills I wrote, installable with the [`skills`](https://github.com/vercel-labs/skills) CLI.

```sh
npx skills add PingSunn/skills -g -a claude-code
```

## Skills in this repo

| Skill | What it does |
| --- | --- |
| [ps-factory](skills/ps-factory/SKILL.md) | Runs coding work as an agent team on Orca or Herdr: one Orchestrator per project, a Lead per Story, a Dev per Slice and a QA sub-agent per review round, with Story Branches and small Slice pull requests. |

### ps-factory in 30 seconds

[▶ Watch the clip (MP4, 30 s)](docs/media/ps-factory.mp4)

The clip is rendered frame by frame from [docs/media-src/ps-factory-clip.html](docs/media-src/ps-factory-clip.html) with [docs/media-src/render.cjs](docs/media-src/render.cjs) (`node render.cjs <html> <out.mp4> 60`, needs Playwright and ffmpeg).

Quick start: install the repo, open a Claude Code chat in your project's main checkout, run `/ps-factory init` once, then `/ps-factory` and describe the work.

### Agent Tree

A real run: one Story that fixes the findings from a code review of a long-lived `upgrade/v2` branch. The owner talks only to the Orchestrator. The Lead owns the Story and its Story Branch, runs a Dev per Slice and spawns a fresh QA sub-agent for every review round. Only the whole-Story QA is a separate agent.

```text
Owner
└── Orchestrator                      one per project, only role that talks to the owner
    └── Lead: v2-review-fixes         owns the Story, Story Branch fix/v2-review
        ├── Dev S1  schema split + migration guards      own workspace, Slice PR
        │   └── QA sub-agent          round 1: pass
        ├── Dev S2  silent data loss
        │   └── QA sub-agent          round 1: pass
        ├── Dev S3  authorization
        │   ├── QA sub-agent          round 1: fail
        │   └── QA sub-agent          round 2: pass (fresh agent, previous findings in its brief)
        ├── Dev S4  small fixes
        │   └── QA sub-agent          round 1: pass
        ├── Dev S5  fix for the whole-Story QA finding
        │   └── QA sub-agent          round 1: pass
        └── Story QA                  separate agent on the Story PR, rerun after S5
```

How the work flowed:

1. The Orchestrator routes the Story to a Lead. The Lead cuts the Story Branch and splits the work into Slices.
2. Each Slice: the Dev builds it and sends the Lead a `review-request`. The Lead spawns a fresh QA sub-agent, gets a `verdict` back as its result, and forwards a `fail` to the Dev. That is the Fix Loop. When QA passes, the Lead sends the Orchestrator an `awaiting-merge` message with the Slice PR, the verdict and the CI state.
3. The Orchestrator merges a Slice PR into the Story Branch with a merge commit once CI and e2e are green, then replies to the Lead. It never merges into the Target Branch without the owner.
4. When every Slice is in, the Lead opens one Story PR from the Story Branch into the Target Branch and starts the Story QA. A finding there becomes one more Slice (S5 here), and the Story QA runs again.
5. The Lead sends `story-ready`, and the Orchestrator tells the owner. The owner reviews the one Story PR and merges it.

When something outside a Slice breaks (here a CI job failed on every later Slice PR because of a stale runner ref), the Lead fixes it in its own small PR into the Story Branch, the Orchestrator merges it first, and the Slice branches pick it up before they ask for a merge.

## Updating

Edit in this clone, push, then on each machine:

```sh
npx skills update ps-factory -g
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
