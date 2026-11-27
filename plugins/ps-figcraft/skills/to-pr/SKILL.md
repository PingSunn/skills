---
name: to-pr
description: Open a pull request for the coded FigCraft threads, with before and after screenshots of the real pages.
disable-model-invocation: true
---

# /ps-figcraft:to-pr

Ship every **coded** thread on the current branch as one pull request. Thread states, the **Target** and tools are in [../../reference/threads.md](../../reference/threads.md).

Done when the pull request is open with before and after images and each thread has a `PR:` reply. Never merge; the owner merges with the project's own merge script.

## Steps

1. **Check.** The current branch is not `main` and holds the `Code:` commits. The `.figcraft-pr/<branch>/before-*.png` files exist; without them, say so and stop.
2. **After.** Start the dev server on a free high port, screenshot the same pages at the same width into `.figcraft-pr/<branch>/after-<screen>.png`.
3. **Open** the pull request against `main` (or the project's feature integration branch) with `gh pr create`. Body: what changed per thread, a before/after table, the checks that ran. The owner's global Git rules apply: no AI attribution.
4. **Images.** `gh` cannot upload images into a body. Copy the PNGs to `docs/pr-assets/<pr number>/`, commit, push, then edit the body so each image is `![before](https://github.com/<owner>/<repo>/blob/<branch>/docs/pr-assets/<n>/<file>?raw=true)`. Remind the owner to drop or squash the assets at merge if the history should stay clean.
5. **Reply** in each thread: `PR: <url>`.

Report the pull request URL.
