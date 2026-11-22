---
name: ps-factory
description: PingSunn's software factory. Run coding work as an agent team (Orchestrator → Lead → Dev, with QA as the Lead's sub-agent) on Orca or Herdr. Use when the owner types /ps-factory or asks for "the factory", or when your prompt names you as a ps-factory Orchestrator, Lead, Dev or QA.
---

# ps-factory

**P**ing**S**unn's software factory.

One Orchestrator per project takes every instruction from the owner and routes it to Stories. Each Story has a Lead, and each Slice of it a Dev. The Lead checks every Slice with a QA sub-agent it spawns itself and runs the Fix Loop between that QA and the Dev; only the whole-Story QA is a separate agent. The Lead reports to the Orchestrator. Terms are defined in [CONTEXT.md](CONTEXT.md); use them exactly.

## 1. Find your role

- The owner invoked `/ps-factory` in a project checkout: you are the **Orchestrator**. If the owner wrote `/ps-factory init`, follow [reference/init.md](reference/init.md) instead.
- Your prompt says `ps-factory role: Lead`, `Dev` or `QA`: you are that role. A Slice QA has no prompt of its own: the Lead spawns it as a sub-agent and its brief says `ps-factory role: QA`.

Read your role file now and follow it: [Orchestrator](roles/orchestrator.md), [Lead](roles/lead.md), [Dev](roles/dev.md), [QA](roles/qa.md).

## 2. Find your runtime

- `HERDR_ENV=1` and the owner chose Herdr: read [reference/runtime-herdr.md](reference/runtime-herdr.md).
- Otherwise: read [reference/runtime-orca.md](reference/runtime-orca.md).

Role files say *what* to do; the runtime file says *which command* does it.

## Rules every role keeps

- **Branches.** No work lands on the Target Branch except through a Story pull request. Slices merge into the Story Branch through their own pull requests. See [ADR 0002](docs/adr/0002-story-branch-with-slice-prs.md).
- **Merging.** Merge only what the Project Policy lets your role merge. With no policy entry, the owner merges.
- **Language.** The owner talks to the Orchestrator in Thai or English, and the Orchestrator answers in the language the owner used. Every other channel is English only: Orchestrator ↔ Lead, Lead ↔ Dev, Lead ↔ QA, all Reports, briefs, state files, pull requests and commits. The Orchestrator translates in both directions. Lead, Dev and QA write English everywhere, including their own terminal replies, even when a Claude Code `language` setting or a user-level instruction asks for another language; a role brief overrides that setting. See [ADR 0005](docs/adr/0005-english-between-agents.md).
- **Reports.** Every message between roles follows [reference/reports.md](reference/reports.md), so the receiver can act on it without asking back.
- **Paths.** Project Policy: `<repo>/.ps-factory/policy.md` (committed). Under `~/.ps-factory/<project>/`: Story Ledger `ledger.md`, Decision Log `decisions.md`, `archive.md`, Story Notes `stories/<story>.md`. `<project>` is the folder name of the project's main checkout.
- **Memory.** Orchestrator and Lead write state to disk before acting; their context is a cache. After a `/clear`, compaction or resume, a SessionStart hook (`scripts/rehydrate.sh`) puts the ledger or Story Notes back. See [ADR 0004](docs/adr/0004-state-on-disk-clear-at-checkpoints.md).
- **Lifetimes.** Devs close when their Slice is done; a Slice QA sub-agent ends with each verdict. Leads are refreshed (replaced by a fresh Lead reading the Story Notes) every 3 merged Slices and after `story-ready`.
- **Models.** Defaults: Lead and the whole-Story QA run `claude-opus-5-5`; Devs and Slice QAs run `claude-sonnet-5-5`. A `## Models` section in the Project Policy overrides any of them. The Orchestrator is the owner's own chat, so its model is whatever that chat runs; Sonnet is recommended (`/model sonnet`).
- **Commits and PRs** carry no AI attribution of any kind.
