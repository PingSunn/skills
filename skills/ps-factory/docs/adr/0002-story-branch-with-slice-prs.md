# Story Branch with Slice pull requests

No factory work opens a pull request straight into the Target Branch. Each Story gets a Story Branch cut from the Target Branch; each Slice merges into the Story Branch through its own small pull request that QA has passed, and one Story pull request takes the Story Branch into the Target Branch. QA checks every Slice and then the whole Story against its acceptance criteria. Who merges Slices and the Story pull request is set by the Project Policy; without one, the owner merges. This keeps each review small, lets several Devs work one Story in parallel, and keeps the Target Branch untouched until the owner accepts the whole Story. It generalises the owner's feature integration branch rule (ipd-report ADR 0058) to every project the factory runs in.

Each Slice gets its own worktree, a child of the Story's worktree, so parallel Devs never edit the same checkout; the Story's worktree stays on the Story Branch for the Lead and the whole-Story QA check.

## Considered options

- **One pull request per Story straight into the Target Branch:** rejected; large reviews, and parallel Devs would collide on one branch.
- **A Feature level above Story that owns the integration branch:** rejected; it adds a layer with no role to run it.
