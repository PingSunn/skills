# ps-factory

The owner's project-agnostic way of running coding work through a team of agents: one Orchestrator routes work to per-Story Leads, and each Lead runs a Dev and a QA that work the Story together.

## Language

### Roles

**Orchestrator**:
The single top-level agent per project that the owner talks to; the owner gives every instruction through it, it routes work to Leads, and it is the only role that reports to the owner.
_Avoid_: coordinator, manager, boss

**Lead**:
The agent that owns one Story end to end, runs its Devs and its QA, and reports the Story's outcome to the Orchestrator. A project has at most one Orchestrator and, by default, at most three open Leads at a time.
_Avoid_: base, story lead, foreman, supervisor

**Dev**:
An agent that implements part of a Story's change; a Lead may run several Devs when a Story has several independent parts.
_Avoid_: developer, builder, worker

**QA**:
The agent that independently checks one Slice, or a whole Story, against its acceptance criteria and gives a verdict; a fresh QA is started for each.
_Avoid_: reviewer, tester, checker

### Work

**Story**:
One unit of work with its own outcome, owned by exactly one Lead; it may come from a tracker issue or from the owner's prompt. It stays open until its Story Branch is merged into the Target Branch and the owner confirms it is closed.
_Avoid_: เรื่อง, task, ticket, job

**Fix Loop**:
The rounds in which QA fails a Dev's change and Dev revises it; after three failed rounds, or when Dev disputes a finding, the Lead decides.
_Avoid_: review cycle, iteration

**Story Ledger**:
The Orchestrator's own record of every open Story, one line each, kept outside the project so it survives context loss and is the same from every worktree.
_Avoid_: tracker, board, state file

**Decision Log**:
The Orchestrator's append-only record of every owner decision and Routing choice, with its reason.
_Avoid_: history, journal

**Checkpoint**:
A moment when the Orchestrator has nothing in flight and every state file is current, so its context can be cleared without loss.
_Avoid_: save point, sync point

**Refresh**:
Replacing a Lead with a fresh one that resumes its Story from the Story Notes.
_Avoid_: restart, reset, respawn

**Story Notes**:
A Lead's detailed record of its own Story: its Slices, pull requests, Fix Loop outcomes and decisions.
_Avoid_: story log, journal

**Project Policy**:
The per-project rules the factory follows, such as which branch Stories merge into and whether the Orchestrator may merge without the owner; with no Project Policy, nothing merges until the owner says so.
_Avoid_: config, settings

**Target Branch**:
The branch a Story finally merges into, named by the Project Policy: the branch the project develops on, such as main, dev or develop.
_Avoid_: base branch, trunk, main

**Story Branch**:
The branch a Story's work collects on before one pull request takes it into the Target Branch.
_Avoid_: feature branch, integration branch

**Slice**:
One independent part of a Story, built by one Dev and merged into the Story Branch through its own pull request after QA passes it.
_Avoid_: sub-task, sub-PR, chunk

**Routing**:
The Orchestrator's decision to attach incoming work to an existing Lead's Story or to open a new Story with a new Lead.
_Avoid_: assignment, dispatch

**Report**:
A message carrying a role's result up one level: Dev or QA to Lead, Lead to Orchestrator.
_Avoid_: update, status
