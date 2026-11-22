# Fewer, bigger Slices, and no Story Branch for a one-Slice Story

Context: on ipd-report the org-nav Story was split into six Slices by layer (permissions, sidebar, copy, routes). Each Slice paid for a Dev, a QA round, a CI run and a wait for the owner's merge, and the owner found the Story too slow.

Decision: a Lead splits a Story into as few Slices as it can, aiming for 2 to 4. Each Slice is a feature that can be tested end to end on its own, never a layer or a size cut. A Story that fits in one Slice has no Story Branch: its single pull request goes straight into the Target Branch, its Slice QA is the only QA, and it is reported as `story-ready`. This amends [ADR 0002](0002-story-branch-with-slice-prs.md) for one-Slice Stories only.

Why: the fixed cost per Slice (QA, CI, merge wait) dominated the work time, while small Slices bought little review benefit because the owner still reviews the whole Story pull request.

## Considered options

- **Keep small Slices and let the Orchestrator merge them:** rejected for now; the owner keeps Slice merges.
- **One pull request per Story always:** rejected; large Stories still need parallel Devs on separate branches.
