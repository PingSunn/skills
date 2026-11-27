---
name: code
description: Turn FigCraft threads that were fixed in the design into code changes on a new branch, and stop at the commit.
disable-model-invocation: true
---

# /ps-figcraft:code

Make the code match every **fixed** thread. Thread states, tools and the attach check are in [../../reference/threads.md](../../reference/threads.md); read it first.

Done when each fixed thread has a commit and a `Code:` reply, then stop: no push, no pull request. `/ps-figcraft:to-pr` opens it.

## Steps

1. **Read the project.** `AGENTS.md`, `CLAUDE.md`, `DESIGN.md` and the project's check commands. Follow what they say about framework docs, comments, ADRs and tests.
2. **Branch.** Cut `fix/<slug>` from `main`. A feature integration branch named in the project's rules replaces `main`.
3. **Map.** For each thread, find the source file from the frame and layer names (`Grep` the component or route name). A thread whose file cannot be found is skipped and reported.
4. **Before.** Start the dev server on a free high port (check with `lsof -ti tcp:<port>` first; never reclaim a busy one). Screenshot each affected page at the frame's width into `.figcraft-pr/<branch>/before-<screen>.png`, adding `.figcraft-pr/` to `.git/info/exclude`. A page behind sign-in uses the project's test login; with none, ask the owner.
5. **Edit.** Change the code to match the design: tokens from the project's CSS over raw values. Use `shadcn` for components under a `components.json`, `modern-web-guidance` for CSS and layout.
6. **Check.** Run the project's checks (typecheck, lint on changed files, the affected tests).
7. **Commit** in the project's message style. Owner's global Git rules apply: no AI attribution.
8. **Reply** in each thread: `Code: <branch>@<short sha>`.

Report the branch, the commits, and any skipped thread.
